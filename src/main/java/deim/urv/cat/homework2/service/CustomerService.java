/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package deim.urv.cat.homework2.service;
import deim.urv.cat.homework2.controller.CustomerForm;
import deim.urv.cat.homework2.model.Customer;
import java.util.List;


public interface CustomerService {
    public List<Customer> findAllCustomers();
    public Customer findCustomerById(String id);
    public void updateCustomer(int id, Customer updatedCustomer);
    public Customer findUserByEmail(String email);
    public Customer findUserByUsername(String username);
    public boolean addUser(CustomerForm customer);
    
}
