package poly.edu.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.annotation.SessionScope;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import jakarta.servlet.http.HttpSession;
import poly.edu.Model.GioHang;
import poly.edu.Model.User;
import poly.edu.Repository.GioHangRepository;
import poly.edu.Repository.UserRepository;

@SessionScope // One instance per user session
@Service
public class CartServiceImp implements CartService {

    private static final Logger log = LoggerFactory.getLogger(CartServiceImp.class);

    // Map uses CartID (GioHang primary key) as key for consistency
    private Map<Long, GioHang> maps = new HashMap<>();

    @Autowired
    private GioHangRepository gioHangRepository;

    @Autowired
    private UserRepository userRepo;

    // Helper method to update the HTTP session
    private void updateSession() {
        try {
            ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            HttpSession session = attr.getRequest().getSession(true); // true == create if not exists
            session.setAttribute("CART_ITEMS", new ArrayList<>(maps.values()));
            log.debug("Session updated with {} cart items.", maps.size());
        } catch (IllegalStateException e) {
            log.warn("Could not update session - perhaps no active request context?", e);
            // Handle cases where this might be called outside a request context if
            // necessary
        }
    }

    @Override
    @Transactional // Ensure atomicity
    public void add(GioHang newItem) {
        User currentUser = getCurrentUser();
        if (currentUser == null) {
            log.error("Cannot add item to cart: User not logged in.");
            // Depending on requirements, you might throw an exception or handle differently
            throw new IllegalStateException("Người dùng chưa đăng nhập để thêm vào giỏ hàng.");
        }
        if (newItem.getPhuKienOto() == null || newItem.getPhuKienOto().getAccessoryID() == null) {
            log.error("Cannot add item to cart: Item or Product ID is null.");
            throw new IllegalArgumentException("Sản phẩm không hợp lệ.");
        }

        Long productId = newItem.getPhuKienOto().getAccessoryID();
        int quantityToAdd = newItem.getSoLuong() <= 0 ? 1 : newItem.getSoLuong(); // Ensure at least 1 is added

        // Check if an item for this product already exists for the current user in the
        // DB
        Optional<GioHang> existingCartItemOpt = gioHangRepository.findByUserAndPhuKien(currentUser.getId(), productId);

        if (existingCartItemOpt.isPresent()) {
            // --- Item already exists, update quantity ---
            GioHang existingItem = existingCartItemOpt.get();
            log.info("Product ID {} already in cart for user {}. Updating quantity.", productId,
                    currentUser.getUsername());
            existingItem.setSoLuong(existingItem.getSoLuong() + quantityToAdd);
            // Update price if it can change - Assuming newItem.getGia() holds the current
            // price
            existingItem.setGia(newItem.getGia());

            GioHang savedItem = gioHangRepository.save(existingItem); // Save changes to DB
            maps.put(savedItem.getCartID(), savedItem); // Update in map (using CartID)

        } else {
            // --- Item is new, add it ---
            log.info("Product ID {} not in cart for user {}. Adding new item.", productId, currentUser.getUsername());
            newItem.setUser(currentUser); // Associate with current user
            newItem.setSoLuong(quantityToAdd); // Set initial quantity
            // Ensure price is set correctly from the newItem passed in
            // newItem.setGia(newItem.getGia()); // Already set presumably

            GioHang savedItem = gioHangRepository.save(newItem); // Save new item to DB (generates CartID)
            maps.put(savedItem.getCartID(), savedItem); // Add to map (using generated CartID)
        }

        updateSession();
    }

    @Override
    @Transactional
    public void remove(Long cartId) {
        if (maps.containsKey(cartId)) {
            maps.remove(cartId); // Remove from map first
            gioHangRepository.deleteById(cartId); // Then remove from DB
            log.info("Removed cart item with ID: {}", cartId);
            updateSession();
        } else {
            log.warn("Attempted to remove non-existent cart item with ID: {}", cartId);
            // Optionally check DB just in case map and DB are out of sync
            if (gioHangRepository.existsById(cartId)) {
                gioHangRepository.deleteById(cartId);
                log.warn("Item with ID {} existed in DB but not in session map. Removed from DB.", cartId);
                // No session update needed if it wasn't in the map
            }
        }
    }

    @Override
    @Transactional
    public GioHang update(long cartId, int newQuantity) {
        // First check if the item is in the map
        GioHang giohang = maps.get(cartId);

        if (giohang == null) {
            // If not in map, try to find it in the database
            Optional<GioHang> giohangOpt = gioHangRepository.findById(cartId);
            if (giohangOpt.isPresent()) {
                giohang = giohangOpt.get();
                // Add it to the map if found in database
                maps.put(giohang.getCartID(), giohang);
                log.info("Cart item ID {} found in DB but not in session map. Added to map.", cartId);
            } else {
                log.warn("Attempted to update non-existent cart item with ID: {}", cartId);
                return null;
            }
        }

        // Now we have the item either from map or database
        if (newQuantity > 0) {
            log.info("Updating quantity for cart item ID {}: {} -> {}", cartId, giohang.getSoLuong(), newQuantity);
            giohang.setSoLuong(newQuantity);
            // Save to database
            GioHang savedItem = gioHangRepository.save(giohang);
            // Update the map with the saved item
            maps.put(cartId, savedItem);
            // Update session
            updateSession();
            return savedItem;
        } else {
            // If quantity is 0 or less, remove the item
            log.info("Quantity for cart item ID {} set to {}. Removing item.", cartId, newQuantity);
            remove(cartId);
            return null;
        }
    }

    @Override
    @Transactional
    public void clear() {
        User currentUser = getCurrentUser();
        if (currentUser != null) {
            log.info("Clearing cart for user: {}", currentUser.getUsername());
            // Delete all cart items associated with this user from the database
            int deletedCount = gioHangRepository.deleteAllByUser(currentUser);
            log.info("Deleted {} items from DB for user {}", deletedCount, currentUser.getUsername());
        } else {
            log.warn("Attempting to clear cart, but no user is logged in. Clearing session map only.");
        }
        maps.clear(); // Clear the map
        updateSession(); // Update the session
    }

    @Override
    public Collection<GioHang> getAllItems() {
        // Return a copy to prevent external modification of the internal map's values
        return new ArrayList<>(maps.values());
    }

    @Override
    public int getCount() {
        // Returns the number of *distinct line items* in the cart
        return maps.size();
    }

    // Optional: Get total number of individual items (sum of quantities)
    public int getTotalQuantity() {
        return maps.values().stream()
                .mapToInt(GioHang::getSoLuong)
                .sum();
    }

    @Override
    public BigDecimal getAmounts() {
        return maps.values().stream()
                .map(item -> item.getGia().multiply(BigDecimal.valueOf(item.getSoLuong()))) // gia * soLuong
                .reduce(BigDecimal.ZERO, BigDecimal::add); // Sum them up
    }

    @Override
    public List<GioHang> getGioHangByUser(User user) {
        if (user == null) {
            log.warn("getGioHangByUser called with null user. Returning empty list.");
            maps.clear(); // Clear map if user is null or logs out?
            updateSession();
            return new ArrayList<>();
        }
        log.info("Loading cart items from DB for user: {}", user.getUsername());
        List<GioHang> itemsFromDb = gioHangRepository.findByUser(user);

        // Re-synchronize the session map with the database state for this user
        maps.clear();
        itemsFromDb.forEach(item -> maps.put(item.getCartID(), item)); // Use CartID as key
        log.info("Loaded {} items into session map for user {}", maps.size(), user.getUsername());

        updateSession(); // Update session to reflect the loaded cart
        return itemsFromDb; // Return the list fetched from DB
    }

    @Override // Added @Override assuming this is part of the CartService interface
    @Transactional
    public void xoaGioHangSauKhiDatHang(String username) {
        log.info("Clearing cart for user {} after order placement.", username);
        User user = userRepo.findByUsername(username);

        int deletedCount = gioHangRepository.deleteAllByUser(user); // Delete from DB
        log.info("Deleted {} cart items from DB for user {} after order.", deletedCount, username);
        maps.clear(); // Clear the session map
        updateSession();
    }

    private User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()
                || "anonymousUser".equals(authentication.getPrincipal())) {
            log.warn("No authenticated user found in Security Context.");
            return null;
        }
        String username = authentication.getName();
        return userRepo.findByUsername(username);
    }

    @Override
    public GioHang findById(Long id) {
        // This implementation is empty which could cause issues
        // Need to properly implement findById to get a cart item
        if (id == null)
            return null;

        // First check in our session map
        GioHang item = maps.get(id);
        if (item != null) {
            return item;
        }

        // If not in map, try to find in database
        Optional<GioHang> optItem = gioHangRepository.findById(id);
        if (optItem.isPresent()) {
            // Add to our map for future reference
            GioHang dbItem = optItem.get();
            maps.put(dbItem.getCartID(), dbItem);
            return dbItem;
        }

        return null;
    }

}