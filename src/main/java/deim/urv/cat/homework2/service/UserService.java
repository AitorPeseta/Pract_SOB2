package deim.urv.cat.homework2.service;

import deim.urv.cat.homework2.model.Customer;
import deim.urv.cat.homework2.controller.UserForm;

public interface UserService {
    
    public Customer findUserByEmail(String email);
    public boolean addUser(UserForm user);
}
