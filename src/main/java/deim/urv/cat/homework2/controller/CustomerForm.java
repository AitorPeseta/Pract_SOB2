/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deim.urv.cat.homework2.controller;

import jakarta.mvc.binding.MvcBinding;
import jakarta.ws.rs.FormParam;
import jakarta.validation.constraints.*;
import jakarta.json.bind.annotation.JsonbTransient;
import java.util.Date;
import java.util.List;
import deim.urv.cat.homework2.model.Article;
import deim.urv.cat.homework2.model.Credentials;
import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Named;

@Named("customerForm")
@RequestScoped
public class CustomerForm {
    @NotBlank(message = "Email must not be blank")
    @Email(message = "Email should be valid")
    @FormParam("email")
    private String email;

    @NotNull
    @FormParam("isAuthor")
    private Boolean isAuthor;

    @Min(0)
    @FormParam("lastArticleId")
    private Long lastArticleId; // For HATEOAS

    @PastOrPresent(message = "Registration date cannot be in the future")
    @NotNull(message = "Registration date must not be null")
    @FormParam("registrationDate")
    private Date registrationDate = new Date();

    @NotNull(message = "Credentials must not be null")
    @FormParam("credenciales")
    private Credentials credenciales;

    @NotNull(message = "Articles list must not be null")
    @Size(min = 0, message = "Articles list must have at least zero elements")
    private List<Article> articles;

    public CustomerForm(){
        
    }
    // Getters and Setters with `fixNull` and safe access
    public String getEmail() {
        return fixNull(email);
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getIsAuthor() {
        return isAuthor;
    }

    public void setIsAuthor(Boolean isAuthor) {
        this.isAuthor = isAuthor;
    }

    public Long getLastArticleId() {
        return lastArticleId;
    }

    public void setLastArticleId(Long lastArticleId) {
        this.lastArticleId = lastArticleId;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    public Credentials getCredenciales() {
        return credenciales;
    }

    public void setCredenciales(Credentials credenciales) {
        this.credenciales = credenciales;
    }

    public List<Article> getArticles() {
        return articles;
    }

    public void setArticles(List<Article> articles) {
        this.articles = articles;
    }

    // Helper to prevent null values
    private String fixNull(String in) {
        return (in == null) ? "" : in;
    }
}
