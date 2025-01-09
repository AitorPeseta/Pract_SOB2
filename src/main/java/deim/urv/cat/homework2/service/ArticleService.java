/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package deim.urv.cat.homework2.service;
import deim.urv.cat.homework2.model.Article;
import java.util.List;


public interface ArticleService {
    public List<Article> findArticleByTopicAuthor(List<Integer> topics, String author) throws Exception;
    public Article findArticleById(String id) throws Exception;
    public boolean deleteArticle(String id) throws Exception;
    public boolean createArticle(Article article) throws Exception;
    public boolean isPrivate(String id);
}
