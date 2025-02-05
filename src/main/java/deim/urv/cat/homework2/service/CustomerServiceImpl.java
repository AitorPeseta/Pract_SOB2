package deim.urv.cat.homework2.service;

import deim.urv.cat.homework2.controller.CustomerForm;
import deim.urv.cat.homework2.model.Customer;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.GenericType;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.ws.rs.core.Context;
import java.util.Base64;

@ApplicationScoped
public class CustomerServiceImpl implements CustomerService{
    private WebTarget webTarget;
    private final jakarta.ws.rs.client.Client client;
    private static final String BASE_URI = "http://localhost:8080/Pract1_Aitor_Xavi/rest/api/v1/";
    
    public CustomerServiceImpl() {
        client = jakarta.ws.rs.client.ClientBuilder.newClient();
        webTarget = client.target(BASE_URI).path("customer");
    }
    public List<Customer> findAllCustomers(){
        
        Response response = webTarget.request(MediaType.APPLICATION_JSON).get();
        if (response.getStatus() == 200) {
            return response.readEntity(new GenericType<List<Customer>>() {});
        }
        return null;
    }
    public Customer findCustomerById(String id){
        
        Response response = webTarget
                .queryParam("id")
                .request(MediaType.APPLICATION_JSON)
                .get();
        if (response.getStatus() == 200) {
            return response.readEntity(new GenericType<Customer>() {});
        }
        return null;
    }
    public Customer findUserByEmail(String email){
        
        Response response = webTarget.path(email)
                .request(MediaType.APPLICATION_JSON)
                .get();
        if (response.getStatus() == 200) {
            return response.readEntity(Customer.class);
        }
        return null;
    }
    public Customer findUserByUsername(String username){
        
        Response response = webTarget.path("/username/"+username)
                .request(MediaType.APPLICATION_JSON)
                .get();
        if (response.getStatus() == 200) {
            return response.readEntity(Customer.class);
        }
        return null;
    }
    public void updateCustomer(int id, Customer updatedCustomer, @Context HttpServletRequest request){
        HttpSession session = request.getSession(); 
        String encodedPassword = null;
        if(session.getAttribute("password") != null )
           encodedPassword = Base64.getEncoder().encodeToString(session.getAttribute("password").toString().getBytes());
        
        
        Response response = webTarget
            .queryParam("id", id)
            .request(MediaType.APPLICATION_JSON)
            .header("Authorization", encodedPassword)
            .put(Entity.entity(updatedCustomer, MediaType.APPLICATION_JSON));
    }
    public boolean addUser(CustomerForm customer) {
       
        Response response = webTarget.request(MediaType.APPLICATION_JSON)
                .post(Entity.entity(customer, MediaType.APPLICATION_JSON), 
                    Response.class);
        return response.getStatus() == 201;
    }
}
