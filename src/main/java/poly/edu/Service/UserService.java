package poly.edu.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.Optional;
import java.util.UUID;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import poly.edu.Model.User;
import poly.edu.Repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private EmailService emailService;

    // Pattern for validating phone number - exactly 10 digits
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10}$");

    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    // Đăng ký tài khoản - với mã hóa mật khẩu và kiểm tra số điện thoại
    @Transactional // Add Transactional annotation for database operations
    public String registerUser(String username, String rawPassword, String email,
            String hovaten, String sodienthoai, String diaChi) {
        // Kiểm tra username đã tồn tại
        if (userRepository.existsByUsername(username)) {
            return "Tên người dùng đã tồn tại!";
        }

        // Kiểm tra email đã tồn tại
        if (userRepository.existsByEmail(email)) {
            return "Email đã được sử dụng!";
        }

        // Kiểm tra số điện thoại
        if (sodienthoai != null && !sodienthoai.isEmpty()) {
            // Kiểm tra số điện thoại đã tồn tại
            if (userRepository.existsBySodienthoai(sodienthoai)) {
                return "Số điện thoại đã được sử dụng!";
            }

            // Kiểm tra định dạng số điện thoại (10 số)
            if (!PHONE_PATTERN.matcher(sodienthoai).matches()) {
                return "Số điện thoại phải có đúng 10 chữ số!";
            }
        }

        // Kiểm tra họ tên
        if (hovaten == null || hovaten.trim().isEmpty()) {
            return "Họ tên không được để trống!";
        }

        // Kiểm tra mật khẩu
        if (rawPassword == null || rawPassword.length() < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự!";
        }

        User newUser = new User();
        newUser.setUsername(username);
        // Mã hóa mật khẩu trước khi lưu
        newUser.setPassword(passwordEncoder.encode(rawPassword));
        newUser.setEmail(email);
        newUser.setHovaten(hovaten);
        newUser.setSodienthoai(sodienthoai != null ? sodienthoai : null);
        newUser.setDiaChi(diaChi);
        //newUser.setRole("USER");
        newUser.setRole("ADMIN");

        // For testing purposes, you might want to set this to true initially
        // Remove this line or set to false for production
        // newUser.setEnabled(true);

        // Tạo token xác thực và thiết lập thời gian hết hạn
        String token = generateVerificationToken();
        newUser.setVerificationToken(token);
        newUser.setTokenExpiry(calculateExpiryDate(24 * 60)); // 24 hours in minutes
        newUser.setEnabled(false); // Tài khoản chưa được kích hoạt

        User savedUser = userRepository.save(newUser);

        // Gửi email xác thực
        boolean emailSent = emailService.sendVerificationEmail(savedUser, token);

        if (!emailSent) {
            // If email fails, still create the account but warn the user
            return "Đăng ký thành công! Tuy nhiên, không thể gửi email xác thực. Vui lòng liên hệ hỗ trợ hoặc thử lại sau.";
        }

        return "Đăng ký thành công! Vui lòng kiểm tra email để xác thực tài khoản của bạn.";
    }

    @Transactional
    public String handleForgotPassword(String email) {
        User user = userRepository.findByEmail(email);
        if (user != null) {
            String newRawPassword = generateRandomPassword();
            // Mã hóa mật khẩu trước khi lưu
            user.setPassword(passwordEncoder.encode(newRawPassword));
            userRepository.save(user);
            // Lưu ý: Gửi mật khẩu thô qua email là không an toàn.
            // Nên gửi link đặt lại mật khẩu có token hết hạn.
            emailService.sendResetPasswordEmail(user, newRawPassword); // Cần cải thiện logic này
            return "Mật khẩu mới đã được gửi vào email của bạn!";
        }
        return "Email không tồn tại trong hệ thống.";
    }

    // Xác thực tài khoản bằng token
    @Transactional
    public String verifyAccount(String token) {
        logger.debug("Verifying account with token: {}", token);

        User user = userRepository.findByVerificationToken(token);
        if (user == null) {
            logger.warn("No user found with token: {}", token);
            return "Token xác thực không hợp lệ hoặc không tồn tại.";
        }

        // Kiểm tra xem token đã hết hạn chưa
        if (user.getTokenExpiry().before(new Date())) {
            logger.warn("Token expired for user: {}", user.getUsername());
            return "Token xác thực đã hết hạn. Vui lòng yêu cầu gửi lại email xác thực.";
        }

        // Kích hoạt tài khoản
        user.setEnabled(true);
        user.setVerificationToken(null);
        user.setTokenExpiry(null);
        userRepository.save(user);

        logger.info("Account verified successfully for user: {}", user.getUsername());
        return "Xác thực tài khoản thành công! Bạn có thể đăng nhập ngay bây giờ.";
    }

    // Gửi lại email xác thực
    @Transactional
    public String resendVerificationEmail(String email) {
        User user = userRepository.findByEmail(email);
        if (user == null) {
            return "Không tìm thấy tài khoản với địa chỉ email này.";
        }

        if (user.isEnabled()) {
            return "Tài khoản này đã được xác thực. Bạn có thể đăng nhập ngay.";
        }

        // Tạo token mới và thiết lập thời gian hết hạn
        String token = generateVerificationToken();
        user.setVerificationToken(token);
        user.setTokenExpiry(calculateExpiryDate(24 * 60)); // 24 hours in minutes
        userRepository.save(user);

        // Gửi lại email xác thực
        emailService.resendVerificationEmail(user, token);

        return "Đã gửi lại email xác thực thành công. Vui lòng kiểm tra hộp thư của bạn.";
    }

    // Tạo mã xác thực ngẫu nhiên
    private String generateVerificationToken() {
        return UUID.randomUUID().toString();
    }

    // Tính toán thời gian hết hạn
    private Date calculateExpiryDate(int expiryTimeInMinutes) {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MINUTE, expiryTimeInMinutes);
        return calendar.getTime();
    }

    // Đổi mật khẩu - với mã hóa và so sánh mật khẩu an toàn
    @Transactional
    public String changePassword(Integer userId, String currentRawPassword, String newRawPassword) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return "Người dùng không tồn tại!";
        }

        // So sánh mật khẩu hiện tại với mật khẩu đã mã hóa trong cơ sở dữ liệu
        if (!passwordEncoder.matches(currentRawPassword, user.getPassword())) {
            return "Mật khẩu hiện tại không đúng!";
        }

        if (newRawPassword == null || newRawPassword.length() < 6) {
            return "Mật khẩu mới phải có ít nhất 6 ký tự!";
        }

        // Mã hóa mật khẩu mới trước khi lưu
        user.setPassword(passwordEncoder.encode(newRawPassword));

        userRepository.save(user);
        return "Mật khẩu đã được cập nhật thành công!";
    }

    // *** PHƯƠNG THỨC MỚI ĐỂ CẬP NHẬT THÔNG TIN PROFILE ***
    @Transactional // Add Transactional annotation
    public String updateProfile(Integer userId, String fullname, String email, String address, String phone) {
        Optional<User> userOptional = userRepository.findById(userId);
        if (!userOptional.isPresent()) {
            return "Người dùng không tồn tại."; // User not found
        }

        User user = userOptional.get();

        // Optional: Add validation for input fields here
        if (fullname == null || fullname.trim().isEmpty()) {
            return "Họ tên không được để trống!";
        }
        // Add more validation as needed (e.g., email format, phone format)

        // Update fields
        user.setHovaten(fullname);
        user.setEmail(email);
        user.setDiaChi(address);
        user.setSodienthoai(phone);

        // Note: Password and Role are NOT updated here.
        // Password should be updated via the changePassword method.
        // Role should typically not be user-editable.

        try {
            userRepository.save(user);
            return "Cập nhật thông tin thành công!";
        } catch (Exception e) {
            // Log the exception
            e.printStackTrace(); // Replace with proper logging
            return "Đã xảy ra lỗi khi cập nhật thông tin.";
        }
    }

    // Tạo mật khẩu ngẫu nhiên cho chức năng quên mật khẩu
    private String generateRandomPassword() {
        return UUID.randomUUID().toString().substring(0, 8);
    }
}