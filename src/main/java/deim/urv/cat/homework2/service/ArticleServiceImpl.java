package deim.urv.cat.homework2.service;

import deim.urv.cat.homework2.model.Article;
import deim.urv.cat.homework2.exception.*;
import java.util.List;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.core.GenericType;


public class ArticleServiceImpl implements ArticleService{
    
    private WebTarget webTarget;
    private final jakarta.ws.rs.client.Client client;
    private static final String BASE_URI = "http://localhost:8080/Pract1_Aitor_Xavi/rest/api/v1/";
    
    public ArticleServiceImpl() {
        client = jakarta.ws.rs.client.ClientBuilder.newClient();
        webTarget = client.target(BASE_URI).path("article");
    }
    
    @Override
    public List<Article> findArticleByTopicAuthor(List<Integer> topics, String author) throws Exception{
        
        // Agregar parámetros "topic" dinámicamente
        if (topics != null && !topics.isEmpty()) {
            for (Integer topic : topics) {
                webTarget = webTarget.queryParam("topic", topic);
            }
        }
       
        // Agregar el parámetro "author" si es proporcionado
        if (author != null) {
            webTarget = webTarget.queryParam("author", author);
        }
        
        // Construir el target de la URL
        Response response = webTarget.request(MediaType.APPLICATION_JSON)
                                     .get();
        
        
        switch (response.getStatus()) {
            case 200:
                return response.readEntity(new GenericType<List<Article>>() {});
            case 404:
                throw new Exception404("");
            case 400:
                throw new Exception400("");
            default:
                break;
        }
        
        return null;
    }
    
    @Override
    public Article findArticleById(String id) throws Exception {
        
        Response response = webTarget.queryParam("id", id)
                                     .request(MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML)
                                     .get();
       
        switch (response.getStatus()) {
            case 200:
                return response.readEntity(Article.class);
            case 404:
                throw new Exception404("");
            case 400:
                throw new Exception400("");
            default:
                break;
        }
        
        return null;
    }
    
    @Override
    public boolean deleteArticle(String id) throws Exception{
         
        Response response = webTarget.queryParam("id", id)
                                     .request(MediaType.APPLICATION_JSON)
                                     .delete();
        
        switch (response.getStatus()) {
            case 204:
                return true;
            case 404:
                throw new Exception404("");
            case 400:
                throw new Exception400("");
            case 403:
                throw new Exception403("");
            default:
                break;
        }
        return false;
    }
    
    @Override
    public boolean createArticle(Article article) throws Exception{
        Response response = webTarget.request(MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML)
               .post(Entity.entity(article, MediaType.APPLICATION_JSON), 
                    Response.class);
        
        switch (response.getStatus()) {
            case 201:
                return true;
            case 404:
                throw new Exception404("");
            case 400:
                throw new Exception400("");
            case 500:
                throw new Exception500("");
            default:
                break;
        }
        return false;
    }
    
}