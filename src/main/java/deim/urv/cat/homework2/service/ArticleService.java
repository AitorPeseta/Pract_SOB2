/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package deim.urv.cat.homework2.service;
import deim.urv.cat.homework2.model.Article;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.core.Context;
import java.util.List;


public interface ArticleService {
    public List<Article> findArticleByTopicAuthor(List<Integer> topics, String author) throws Exception;
    public Article findArticleById(String id, @Context HttpServletRequest request) throws Exception;
    public boolean deleteArticle(String id, @Context HttpServletRequest request) throws Exception;
    public boolean createArticle(Article article, @Context HttpServletRequest request) throws Exception;
    public boolean isPrivate(String id);
}
