/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package deim.urv.cat.homework2.service;
import deim.urv.cat.homework2.model.Article;
import java.util.List;


public interface ArticleService {
    public List<Article> findArticleByTopicAuthor(List<Integer> topics, int author);
    public int findArticleById(String id);
    public void deleteArticle(String id);
    public void createArticle(Article article);
}
