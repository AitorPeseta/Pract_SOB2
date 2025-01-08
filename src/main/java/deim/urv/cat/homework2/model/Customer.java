/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deim.urv.cat.homework2.model;

import java.util.Date;
import java.util.List;


public class Customer {
    
    private int id;
    
    private String email;

    private Boolean isAuthor;

    private Long lastArticleId; // For HATEOAS
    
    private String perfil;

    private Date registrationDate = new Date();

    private Credentials credenciales;

    private List<Article> articles;

    // Getters and Setters with `fixNull` and safe access
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
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
    
    public String getPerfil() {
        return perfil;
    }
    
    public void setPerfil(String perfil) {
        this.perfil = perfil;
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
    private String fixNull(String input) {
        return (input == null) ? "" : input;
    }
}
