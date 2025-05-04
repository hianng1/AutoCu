package poly.edu.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OrderTrackingController {
    @GetMapping("/order-tracking")
    public String orderTrackingPage() {
        return "order-tracking";
    }
} 