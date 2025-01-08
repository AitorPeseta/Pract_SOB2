package deim.urv.cat.homework2.controller;

import deim.urv.cat.homework2.model.AlertMessage;
import deim.urv.cat.homework2.model.Credentials;
import deim.urv.cat.homework2.model.Customer;
import deim.urv.cat.homework2.model.SignUpAttempts;
import deim.urv.cat.homework2.service.CustomerService;

import jakarta.inject.Inject;
import jakarta.mvc.Controller;
import jakarta.mvc.Models;
import jakarta.mvc.UriRef;
import jakarta.mvc.binding.BindingResult;
import jakarta.mvc.binding.ParamError;
import jakarta.mvc.security.CsrfProtected;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import jakarta.ws.rs.BeanParam;
import jakarta.ws.rs.FormParam;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Context;
import java.util.HashSet;

import java.util.logging.Level;
import java.util.logging.Logger;

@Controller
@Path("SignUp")
public class SignUpFormController {    
    // CDI
    @Inject BindingResult bindingResult;
    @Inject Logger log;
    @Inject CustomerService service;
    @Inject Models models;
    @Inject AlertMessage flashMessage;
    @Inject SignUpAttempts attempts;
    
    @GET
    public String showForm() {
        return "signup-form.jsp"; // Injects CRSF token
    }    
    
    @POST
    @UriRef("sign-up")
    @CsrfProtected
    public String signUp(@Valid @FormParam("username") String username,
                    @FormParam("password") String password,
                    @FormParam("email") String email,
                    @Context HttpServletRequest request) {
        
        if (bindingResult.isFailed()) {
            AlertMessage alert = AlertMessage.danger("Validation failed!");
            bindingResult.getAllErrors()
                    .stream()
                    .forEach((ParamError t) -> {
                        alert.addError(t.getParamName(), "", t.getMessage());
                    });
            log.log(Level.WARNING, "Data binding for signupFormController failed.");
            models.put("errors", alert);
            return "signup-form.jsp";
        }
        
        if(attempts.hasExceededMaxAttempts()) {
            return "signup-form.jsp";
        }
       
        Customer user = service.findUserByUsername(username);
        if (user != null) {
            // Try again
            log.log(Level.WARNING, "A user with this username {0} already exists.", user.getCredenciales().getUsername());
            models.put("message", "A user with this username already exists!");
            attempts.increment();
            return "signup-form.jsp";
        } else {
            user = service.findUserByEmail(email);
            if(user != null){
                log.log(Level.WARNING, "A user with this e-mail address {0} already exists.", user.getEmail());
                models.put("message", "A user with this e-mail address already exists!");
                attempts.increment();
                return "signup-form.jsp";
            } else {
                CustomerForm cust = new CustomerForm();
                cust.setEmail(email);
                Credentials creds = new Credentials();
                creds.setPassword(password);
                creds.setUsername(username);
                cust.setCredenciales(creds);
                                
                log.log(Level.INFO, "Redirecting to the success page.");
                models.put("user", cust);
                service.addUser(cust);
                HttpSession session = request.getSession();
                session.setAttribute("username", cust.getCredenciales().getUsername());
                attempts.reset();
                return "signup-success.jsp";
            }
        }
        
    } 
}
