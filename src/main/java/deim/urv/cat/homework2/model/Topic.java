/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deim.urv.cat.homework2.model;

import jakarta.json.bind.annotation.JsonbTransient;
import java.util.List;


public class Topic {

    private String name;

    private List<Article> articles;

    // Getters and Setters

    public String getName() {
        return fixNull(name);
    }

    public void setName(String name) {
        this.name = name;
    }

    @JsonbTransient
    public List<Article> getArticles() {
        return articles;
    }

    public void setArticles(List<Article> articles) {
        this.articles = articles;
    }

    // Helper to avoid null values
    private String fixNull(String input) {
        return (input == null) ? "" : input;
    }
}
