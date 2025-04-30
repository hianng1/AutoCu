<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt"
prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AutoCu - Về Chúng Tôi</title> <%-- More specific title --%>

    <%-- Using Tailwind CSS for utility classes --%>
    <script src="https://cdn.tailwindcss.com"></script>

    <%-- Font Awesome for icons --%>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
      rel="stylesheet"
    />

    <%-- Google Fonts - Roboto --%>
    <link
      href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&amp;display=swap"
      rel="stylesheet"
    />

    <%--
      Removing one Bootstrap CSS link as two were included.
      Keeping one for potential components used elsewhere or default styles,
      but primarily relying on Tailwind for this page's layout and look.
      Consider removing Bootstrap entirely if not used extensively.
    --%>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous">

    <style>
      /* Custom styles to enhance the design */
       body {
         font-family: 'Roboto', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
         background-color: #f4f7f6; /* A softer background */
         color: #333;
         line-height: 1.6; /* Improved readability */
       }

       /* Adjust banner style for better contrast and visual appeal */
       .about-banner {
        background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url("https://pos.nvncdn.com/4e732c-26/art/artCT/20201015_LLLUpBDKbLdsrj0KfjLjj46G.jpg"); /* Overlay gradient for better text readability */
        background-size: cover;
        background-position: center;
        color: white;
        padding: 4rem 0; /* More vertical padding */
        text-shadow: 0 2px 8px rgba(0,0,0,0.7); /* Stronger text shadow */
       }

       .about-banner h1 {
            font-size: 2.5rem; /* Larger title */
            font-weight: 700;
            margin-bottom: 1rem;
       }

       .about-banner p {
           font-size: 1.15rem; /* Slightly larger tagline */
           margin-top: 0.5rem;
       }


       /* General section styling - enhanced */
       .autocu-section {
           background-color: #fff;
           padding: 2.5rem; /* Increased padding */
           margin-bottom: 2rem; /* More space between sections */
           border-radius: 0.75rem; /* More rounded corners */
           box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08); /* Softer, larger shadow */
       }

       /* Adjust typography within sections - enhanced */
       .autocu-section h2 {
           font-size: 1.8rem; /* Larger section title */
           font-weight: 700;
           color: #1a202c; /* Darker color for emphasis */
           margin-bottom: 1.8rem; /* More space below title */
           position: relative; /* For underline effect */
           padding-bottom: 0.5rem; /* Space for underline */
       }

       /* Add a subtle underline to section titles */
       .autocu-section h2::after {
           content: '';
           position: absolute;
           left: 0;
           bottom: 0;
           width: 60px; /* Underline length */
           height: 4px;
           background-color: #f97316; /* Orange underline */
           border-radius: 2px;
       }

        .autocu-section h3 {
            font-size: 1.4rem; /* Larger subheading size */
            font-weight: 600;
            color: #333;
            margin-bottom: 1.2rem;
        }

       .autocu-section p {
           font-size: 1.05rem; /* Slightly larger paragraph text */
           color: #4a5568; /* Medium gray-blue text color */
           line-height: 1.7; /* Improved line height */
           margin-bottom: 1.2rem; /* More space between paragraphs */
       }

        .autocu-section p:last-child {
            margin-bottom: 0; /* No bottom margin on last paragraph in a block */
        }

       /* Style for the tagline - more prominent */
       .tagline {
           font-size: 1.5rem; /* Larger tagline */
           font-weight: 700;
           text-align: center;
           margin: 3rem 0; /* More space above and below */
           color: #f97316; /* Orange color for tagline */
           text-transform: uppercase; /* Make it stand out */
           letter-spacing: 1.5px; /* Add some letter spacing */
       }

       /* Style for the statistics section - improved grid and appearance */
       .stats-grid {
           display: grid;
           grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); /* Adjusted for slightly wider minimum */
           gap: 2rem; /* Increased space between items */
           text-align: center;
       }

       .stat-item {
            background-color: #fefcbf; /* Light yellow background for stats */
            padding: 1.5rem;
            border-radius: 0.5rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border: 1px solid #fbd38d; /* Subtle border */
       }

       .stat-item .number {
           font-size: 2.5rem; /* Larger number size */
           font-weight: 700;
           color: #d97706; /* Darker orange for numbers */
           margin-bottom: 0.5rem;
       }

       .stat-item .label {
           font-size: 1rem; /* Slightly larger label text */
           color: #2d3748; /* Darker gray text */
           line-height: 1.5;
       }


       /* Adjust breadcrumb styling - cleaner */
        .breadcrumb-nav {
             background-color: #edf2f7; /* Light gray background */
             padding: 0.75rem 0;
             font-size: 0.95rem;
             box-shadow: inset 0 -1px 3px rgba(0, 0, 0, 0.05); /* Subtle bottom shadow */
        }

        .breadcrumb-nav .breadcrumb-link {
            color: #555;
            text-decoration: none; /* Remove underline */
            transition: color 0.2s ease-in-out; /* Smooth color transition */
        }
        .breadcrumb-nav .breadcrumb-link:hover {
            color: #f97316; /* Orange on hover */
        }
        .breadcrumb-nav span {
            margin: 0 0.6rem; /* More space around separator */
            color: #999;
        }
        .breadcrumb-nav .active-breadcrumb {
            color: #f97316;
            font-weight: 600;
        }

       /* Call to action button style - more prominent */
        .cta-button {
            display: inline-block;
            background-color: #f97316; /* Orange background */
            color: white;
            font-weight: 600;
            padding: 1rem 2.5rem; /* Increased padding */
            border-radius: 0.75rem; /* More rounded corners */
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.1s ease; /* Add transform for press effect */
            text-align: center;
            font-size: 1.1rem; /* Larger text */
            box-shadow: 0 4px 10px rgba(249, 115, 22, 0.3); /* Orange shadow */
        }
        .cta-button:hover {
            background-color: #ea580c; /* Darker orange on hover */
            box-shadow: 0 6px 15px rgba(249, 115, 22, 0.4); /* Larger shadow on hover */
        }
         .cta-button:active {
            background-color: #c2410c; /* Even darker orange on active */
            transform: scale(0.98); /* Slightly shrink on press */
            box-shadow: 0 2px 8px rgba(249, 115, 22, 0.5); /* Smaller shadow on active */
         }

         /* Utility class to limit content width and center */
         .container-custom {
             max-width: 1200px; /* Max width similar to default container */
             margin-left: auto;
             margin-right: auto;
             padding-left: 1rem; /* Tailwind's default px-4 */
             padding-right: 1rem; /* Tailwind's default px-4 */
         }

         /* Responsive adjustments */
         @media (min-width: 768px) { /* Medium screens and up */
             .autocu-section h2 {
                 font-size: 2rem;
             }
             .stats-grid {
                 grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); /* Adjust min width for larger screens */
                 gap: 2.5rem;
             }
         }

    </style>
  </head>
  <body>
    <%-- Include Header --%>
    <jsp:include page="/common/header.jsp"></jsp:include>

    <%-- Use flex to push footer down and add padding to main content --%>
    <div class="flex flex-col min-h-screen">

       <%-- Banner - Changed class name for clarity --%>
       <div class="about-banner">
            <div class="container-custom text-center">
                <h1 class="drop-shadow-md">Về Chúng Tôi</h1>
                <p class="max-w-3xl mx-auto">
                    Tìm hiểu về sứ mệnh, tầm nhìn và những giá trị cốt lõi của AutoCu.
                </p>
            </div>
        </div>

        <%-- Main content area with improved padding and container --%>
        <div class="container-custom py-12 flex-grow"> <%-- Increased vertical padding --%>

            <%-- Narrative Section - Changed class name --%>
            <div class="autocu-section">
                <h2>AutoCu - Cùng bạn đến mọi hành trình</h2>
                <p>
                  Mỗi chuyến đi là một hành trình khám phá cuộc sống và thế giới xung quanh, là cơ hội học hỏi và chinh phục những điều mới lạ của mỗi cá nhân để trở nên tốt hơn. Do đó, chất lượng trải nghiệm của khách hàng là ưu tiên hàng đầu và là nguồn cảm hứng của đội ngũ AUTOCU.
                </p>
                 <p>
                   AUTOCU là nền tảng chia sẻ ô tô, sứ mệnh của chúng tôi không chỉ dừng lại ở việc kết nối chủ xe và khách hàng một cách Nhanh chóng - An toàn - Tiện lợi, mà còn hướng đến việc truyền cảm hứng KHÁM PHÁ những điều mới lạ đến cộng đồng qua những chuyến đi trên nền tảng của chúng tôi.
                 </p>

                 <div class="tagline">
                    Drive. Explore. Inspire
                 </div>

                <p>
                   Cầm lái và Khám phá thế giới đầy Cảm hứng.
                </p>

                 <p>
                   AUTOCU đặt mục tiêu trở thành cộng đồng người dùng ô tô Văn minh & Uy tín #1 tại Việt Nam, nhằm mang lại những giá trị thiết thực cho tất cả những thành viên hướng đến một cuộc sống tốt đẹp hơn.
                 </p>

                 <p>
                    Chúng tôi tin rằng mỗi hành trình đều quan trọng, vì vậy đội ngũ và các đối tác của AUTOCU với nhiều kinh nghiệm về lĩnh vực cho thuê xe, công nghệ, bảo hiểm & du lịch sẽ mang đến cho hành trình của bạn thêm nhiều trải nghiệm mới lạ, thú vị cùng sự an toàn ở mức cao nhất.
                 </p>
            </div>

             <%-- Statistics Section - Changed class name --%>
             <div class="autocu-section">
                 <h2>AutoCu và những con số</h2>
                 <div class="stats-grid">
                     <div class="stat-item">
                         <div class="number">200.000+</div>
                         <p class="label">Chuyến đi đầy cảm hứng <br/> AutoCu đã đồng hành</p>
                     </div>
                     <div class="stat-item">
                         <div class="number">100.000+</div>
                         <p class="label">Khách hàng <br/> đã trải nghiệm dịch vụ</p>
                     </div>
                     <div class="stat-item">
                         <div class="number">10.000+</div>
                         <p class="label">Đối tác chủ xe <br/> trong cộng đồng AutoCu</p>
                     </div>
                     <div class="stat-item">
                         <div class="number">100+</div>
                         <p class="label">Dòng xe <br/> khác nhau đang cho thuê</p>
                     </div>
                     <div class="stat-item">
                         <div class="number">20+</div>
                         <p class="label">Thành phố <br/> AutoCu đã có mặt</p>
                     </div>
                     <div class="stat-item">
                         <div class="number">4.95/5★</div>
                         <p class="label">Là số điểm nhận được từ >100.000 khách hàng <br/> đánh giá về dịch vụ của chúng tôi</p>
                     </div>
                 </div>
             </div>

             <%-- Call to Action Section (Centered) --%>
             <div class="text-center mt-10 mb-12"> <%-- Increased margin top/bottom --%>
                 <a href="#" class="cta-button">
                    Bắt đầu ngay hôm nay
                 </a>
             </div>

        </div>

        <%-- Include Footer --%>
        <jsp:include page="/common/footer.jsp"></jsp:include>
    </div>

    <%-- Optional: Include Bootstrap JS if any components require it --%>
    <%-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script> --%>

  </body>
</html>