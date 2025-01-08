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
import java.util.List;

import java.util.logging.Level;
import java.util.logging.Logger;

@Controller
@Path("Login")
public class LoginFormController {    
    // CDI
    @Inject BindingResult bindingResult;
    @Inject Logger log;
    @Inject CustomerService service;
    @Inject Models models;
    @Inject AlertMessage flashMessage;
    @Inject SignUpAttempts attempts;
    
    @GET
    public String showForm() {
        return "login-form.jsp"; // Injects CRSF token
    }    
    
    @POST
    @UriRef("log-in")
    @CsrfProtected
    public String logIn(@FormParam("credenciales.username") String username,
                    @FormParam("credenciales.password") String password,
                    @Context HttpServletRequest request) {
        
        if (bindingResult.isFailed()) {
            AlertMessage alert = AlertMessage.danger("Validation failed!");
            bindingResult.getAllErrors()
                    .stream()
                    .forEach((ParamError t) -> {
                        alert.addError(t.getParamName(), "", t.getMessage());
                    });
            log.log(Level.WARNING, "Data binding for loginFormController failed.");
            models.put("errors", alert);
            return "login-form.jsp";
        }
        
        if(attempts.hasExceededMaxAttempts()) {
            return "login-form.jsp";
        }
        Customer user;

        user = service.findUserByUsername(username);

         
        if(user == null){
            AlertMessage alert = AlertMessage.danger("Username not registered!");
            log.log(Level.WARNING, "Username not found!");
            models.put("errors", alert);
            return "login-form.jsp";
        }
        if (user.getCredenciales().getPassword().equals(password)) {
            models.put("customer",user);
            log.log(Level.INFO, "Redirecting to the success page.");
            attempts.reset();
            HttpSession session = request.getSession();
            session.setAttribute("username", user.getCredenciales().getUsername());
            return "login-success.jsp";
            
        } else {
            AlertMessage alert = AlertMessage.danger("Password is incorrect.");
            log.log(Level.WARNING, "Username not found!");
            models.put("errors", alert);
            return "login-form.jsp";
        }
        
    } 
}
