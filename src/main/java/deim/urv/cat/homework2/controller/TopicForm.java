/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deim.urv.cat.homework2.controller;
import jakarta.mvc.binding.MvcBinding;
import jakarta.ws.rs.FormParam;
import jakarta.validation.constraints.*;
import jakarta.json.bind.annotation.JsonbTransient;
import java.util.List;
import deim.urv.cat.homework2.model.Article;

public class TopicForm {
    
    @NotBlank(message = "Name must not be blank")
    @Size(max = 50, message = "Name must not exceed 50 characters")
    @FormParam("name")
    @MvcBinding
    private String name;

    @NotNull(message = "Articles list must not be null")
    @Size(min = 0, message = "Articles list must have at least zero elements")
    @JsonbTransient
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
