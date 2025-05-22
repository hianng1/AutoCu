package poly.edu.DAO;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import poly.edu.Model.DonHang;

@Service
public class OrderDAO {

    @Autowired
    private SessionFactory sessionFactory;

    public DonHang getOrder(String orderId) {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM DonHang WHERE orderid = :orderId", DonHang.class)
                    .setParameter("orderId", orderId)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}