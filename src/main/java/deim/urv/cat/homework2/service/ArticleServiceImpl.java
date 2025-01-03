package deim.urv.cat.homework2.service;

import deim.urv.cat.homework2.model.Article;
import jakarta.ws.rs.client.WebTarget;
import java.util.List;
import deim.urv.cat.homework2.controller.ArticleForm;
import jakarta.ws.rs.client.Client;
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
    
    public List<Article> findArticleByTopicAuthor(List<Integer> topics, int author){
        
        String topicsString,authorString;
        try{
            // Formatear la lista de tópicos como un string separado por comas
            topicsString = String.join(",", topics.stream().map(String::valueOf).toArray(String[]::new));
        }catch(NullPointerException e){
            topicsString = ""; 
        }
        
        if(author == 0)
            authorString = "";
        else 
            authorString = "" + author; 
        
        // Construir el target de la URL
        Response response = webTarget
                .queryParam("topic", topicsString)
                .queryParam("author", authorString)
                .request(MediaType.APPLICATION_JSON)
                .get();
        
        // Realizar la petición GET
        //Response response = webTarget.request(MediaType.APPLICATION_JSON).get();
        if (response.getStatus() == 200) {
            return response.readEntity(new GenericType<List<Article>>() {});
        }
        return null;
    }
    public int findArticleById(String id){
        return 0;
    }
    public void deleteArticle(String id){
    
    }
    public void createArticle(Article article){
    
    }
}
