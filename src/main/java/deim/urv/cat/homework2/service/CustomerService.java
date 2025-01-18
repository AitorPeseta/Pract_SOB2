package deim.urv.cat.homework2.service;
import deim.urv.cat.homework2.controller.CustomerForm;
import deim.urv.cat.homework2.model.Customer;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.core.Context;
import java.util.List;


public interface CustomerService {
    public List<Customer> findAllCustomers();
    public Customer findCustomerById(String id);
    public void updateCustomer(int id, Customer updatedCustomer, @Context HttpServletRequest request);
    public Customer findUserByEmail(String email);
    public Customer findUserByUsername(String username);
    public boolean addUser(CustomerForm customer);

}

