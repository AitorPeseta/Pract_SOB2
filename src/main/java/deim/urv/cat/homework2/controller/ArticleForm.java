/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deim.urv.cat.homework2.controller;

import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Named;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import jakarta.ws.rs.FormParam;
import java.io.Serializable;
import jakarta.validation.constraints.*;
import java.util.Date;
import java.util.List;
import deim.urv.cat.homework2.model.Topic;
import deim.urv.cat.homework2.model.Customer;


@Named("articleForm")
@RequestScoped
public class ArticleForm implements Serializable{
    private static final long serialVersionUID = 1L;
    
    @NotNull(message = "Id must not be null")
    @FormParam("id")
    private int id;
    
    @NotBlank(message = "Content must not be blank")
    @Size(max = 5000, message = "Content must be less than 5000 characters")
    @FormParam("content")
    private String content;

    @FormParam("featuredImageUrl")
    //@Pattern(regexp = "(http|https)://.*", message = "Image URL must be valid")
    private String featuredImageUrl;

    @NotNull
    @FormParam("isPublic")
    private Boolean isPublic;

    @PastOrPresent(message = "Published date must be in the past or present")
    @FormParam("publishedDate")
    private Date publishedDate;

    @NotBlank(message = "Summary must not be blank")
    @Size(max = 255, message = "Summary must be less than 255 characters")
    @FormParam("summary")
    private String summary;

    @NotBlank(message = "Title must not be blank")
    @Size(min = 5, max = 100, message = "Title must be between 5 and 100 characters")
    @FormParam("title")
    private String title;

    @Min(0)
    @FormParam("views")
    private Integer views;

    @NotNull(message = "Author must not be null")
    @FormParam("author")
    private Customer author;

    @NotNull(message = "Topics must not be null")
    @Size(min = 1, message = "At least one topic must be provided")
    @FormParam("topics")
    private List<Topic> topic;

    // Getters and Setters with `fixNull` for safe access
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getContent() {
        return fixNull(content);
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFeaturedImageUrl() {
        return fixNull(featuredImageUrl);
    }

    public void setFeaturedImageUrl(String featuredImageUrl) {
        this.featuredImageUrl = featuredImageUrl;
    }

    public Boolean getIsPublic() {
        return isPublic;
    }

    public void setIsPublic(Boolean isPublic) {
        this.isPublic = isPublic;
    }

    public Date getPublishedDate() {
        return publishedDate;
    }

    public void setPublishedDate(Date publishedDate) {
        this.publishedDate = publishedDate;
    }

    public String getSummary() {
        return fixNull(summary);
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getTitle() {
        return fixNull(title);
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public Customer getAuthor() {
        return author;
    }

    public void setAuthor(Customer author) {
        this.author = author;
    }

    public List<Topic> getTopics() {
        return topic;
    }

    public void setTopics(List<Topic> topics) {
        this.topic = topics;
    }

    private String fixNull(String in) {
        return (in == null) ? "" : in;
    }
 }

