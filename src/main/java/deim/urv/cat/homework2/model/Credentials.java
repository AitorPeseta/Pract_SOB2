/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deim.urv.cat.homework2.model;

public class Credentials {
   
    private String password;

    private String username;

    // Getters and Setters
   
    public String getPassword() {
        return fixNull(password);
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return fixNull(username);
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // Helper to avoid null values
    private String fixNull(String input) {
        return (input == null) ? "" : input;
    }
}
