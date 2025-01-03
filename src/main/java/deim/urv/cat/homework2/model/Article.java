/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deim.urv.cat.homework2.model;
import java.util.Date;
import java.util.List;


public class Article {
   
    private String content;

    private String featuredImageUrl;

    private Boolean isPublic;
    
    private Date publishedDate;

    private String summary;

    private String title;

    private Integer views;

    private Customer author;

    private List<Topic> topics;

    // Getters and Setters with `fixNull` for safe access
   
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
        return topics;
    }

    public void setTopics(List<Topic> topics) {
        this.topics = topics;
    }

    private String fixNull(String in) {
        return (in == null) ? "" : in;
    }
}
