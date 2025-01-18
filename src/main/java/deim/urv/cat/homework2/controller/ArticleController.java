package deim.urv.cat.homework2.controller;

import deim.urv.cat.homework2.exception.Exception400;
import deim.urv.cat.homework2.exception.Exception404;
import deim.urv.cat.homework2.model.Article;
import deim.urv.cat.homework2.service.ArticleService;
import deim.urv.cat.homework2.exception.*;
import deim.urv.cat.homework2.model.Customer;
import deim.urv.cat.homework2.model.Topic;
import deim.urv.cat.homework2.service.CustomerService;
import jakarta.inject.Inject;
import jakarta.mvc.Controller;
import jakarta.mvc.Models;
import jakarta.mvc.UriRef;
import jakarta.mvc.security.CsrfProtected;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import jakarta.ws.rs.BeanParam;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.FormParam;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import java.util.ArrayList;
import jakarta.servlet.http.HttpServletRequest;
import java.util.HashSet;

import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

@Controller
@Path("Articles")
public class ArticleController {

    @Inject ArticleService articleService;
    @Inject CustomerService customerService;
    @Inject Models models;
    @Inject Logger log;


    @GET
    @Path("/")
    public String showArticlesPage(@Context HttpServletRequest request) throws Exception {
        try {
            // Cargar los artículos (en este caso, el primer set de artículos)
            List<Article> articles = articleService.findArticleByTopicAuthor(null, null); // Vacío en lugar de null
            articles.sort((a1, a2) -> {
                // Primero compara por el número de visitas (mayor primero)
                int visitsComparison = Integer.compare(a2.getViews(), a1.getViews());
                if (visitsComparison != 0) {
                    return visitsComparison;
                }
                // Si las visitas son iguales, compara alfabéticamente por el título
                return a1.getTitle().compareTo(a2.getTitle());
            });
            
            
            // Crear un Set para almacenar los nombres únicos de los temas
            Set<Topic> uniqueTopics = new HashSet<>();
            Set<String> uniqueName = new HashSet<>();
            int cont;

            // Iterar sobre los artículos y sus temas para agregar los nombres de los temas al Set
            for (Article article : articles) {
                for (Topic topic : article.getTopic()) {
                    cont = uniqueName.size();
                    uniqueName.add(topic.getName()); // Agregar el nombre del tema al Set
                    if(uniqueName.size()!=cont)
                        uniqueTopics.add(topic); // Agregar el nombre del tema al Set
                }
            }
            
            // Pasar el Set de temas únicos al modelo
            models.put("articles", articles);
            models.put("uniqueTopics", uniqueTopics);  // Pasar los temas únicos al JSP
            models.put("page", 0); // Página inicial

        } catch (Exception404 e) {
            // Manejo de errores: agregar un mensaje de error al modelo
            models.put("error", "No se ha encontrado el artículo.");
            log.log(Level.WARNING, "No se ha encontrado el artículo.");
            return "error404.jsp"; // Mostrar página de error
        } catch (Exception400 e) {
            // Manejo de errores: agregar un mensaje de error al modelo
            models.put("error", "Los parámetros que nos has proporcionado son incorrectos.");
            log.log(Level.WARNING, "Los parámetros que nos has proporcionado son incorrectos.");
            return "error400.jsp"; // Mostrar página de error
        }

        log.log(Level.WARNING, "Entrando a la página web principal exitosamente.");
        return "article_page.jsp"; // Renderizar la página con los artículos y los temas únicos
    }
    
    @POST
    @Path("/article-filter")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public String showArticlesFilter(@FormParam("topics") List<Integer> topics, @FormParam("author") String author, @Context HttpServletRequest request) throws Exception {
        try {
            
            //Buscar id del autor
            String id = null;
            
            System.out.print("AUTOR: " + author);
            
            if(!author.isEmpty()){
                Customer user = customerService.findUserByUsername(author);
                id = String.valueOf(user.getId());
            }
            
            // Cargar los artículos (en este caso, el primer set de artículos)
            List<Article> articles = articleService.findArticleByTopicAuthor(topics, id); // Vacío en lugar de null

            // Crear un Set para almacenar los nombres únicos de los temas
            Set<Topic> uniqueTopics = new HashSet<>();
            Set<String> uniqueName = new HashSet<>();
            int cont;

            // Iterar sobre los artículos y sus temas para agregar los nombres de los temas al Set
            for (Article article : articles) {
                for (Topic topic : article.getTopic()) {
                    cont = uniqueName.size();
                    uniqueName.add(topic.getName()); // Agregar el nombre del tema al Set
                    if(uniqueName.size()!=cont)
                        uniqueTopics.add(topic); // Agregar el nombre del tema al Set
                }
            }

            // Pasar el Set de temas únicos al modelo
            models.put("articles", articles);
            models.put("uniqueTopics", uniqueTopics);  // Pasar los temas únicos al JSP
            models.put("page", 0); // Página inicial

        } catch (Exception404 e) {
            // Manejo de errores: agregar un mensaje de error al modelo
            models.put("error", "No se ha encontrado el artículo.");
            log.log(Level.WARNING, "No se ha encontrado el artículo.");
            models.put("articles", null);
            return "article_page_filter.jsp"; // Mostrar página de error
        } catch (Exception400 e) {
            // Manejo de errores: agregar un mensaje de error al modelo
            models.put("error", "Los parámetros que nos has proporcionado son incorrectos.");
            log.log(Level.WARNING, "Los parámetros que nos has proporcionado son incorrectos.");
            return "error400.jsp"; // Mostrar página de error
        } catch (NullPointerException e) {
            // Manejo de errores: agregar un mensaje de error al modelo
            models.put("error", "No existe el autor.");
            log.log(Level.WARNING, "No existe el autor.");
            models.put("articles", null);
            return "article_page_filter.jsp"; // Mostrar página de error
        }

        log.log(Level.WARNING, "Entrando a la página web principal exitosamente.");
        return "article_page_filter.jsp"; // Renderizar la página con los artículos y los temas únicos
    }
    
    @POST
    @Path("/article-details")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public String showArticleDetails(@FormParam("id") String articleId, @Context HttpServletRequest request) throws Exception {
        try {
            
            HttpSession session = request.getSession();
            
            String username = (String) session.getAttribute("username");
           
            // Verificar si el parámetro ID no es nulo
            if (articleId == null) {
                throw new Exception400(""); // Error 400: Solicitud incorrecta
            }
               
            // Llamar al servicio para obtener el artículo por su ID
            if (articleService.isPrivate(articleId) && username == null){
                throw new Exception403("");
            } else {
                Article article = articleService.findArticleById(articleId, request);
                // Comprobar si el artículo existe
                if (article == null) {
                    // Manejar el caso en que el artículo no exista (opcional)
                    throw new Exception404("");
                }

                // Poner el artículo en el modelo para pasarlo al JSP
                models.put("article", article);
            }
            

        } catch (Exception404 e) {
            // Manejo de errores: agregar un mensaje de error al modelo
            models.put("error", "No se ha encontrado el artículo.");
            log.log(Level.WARNING, "No se ha encontrado el artículo..");
            return "error404.jsp"; // Mostrar página de error
        } catch (Exception400 e) {
            // Manejo de errores: agregar un mensaje de error al modelo
            models.put("error", "Los parámetros que nos has proporcionado son incorrectos.");
            log.log(Level.WARNING, "Los parámetros que nos has proporcionado son incorrectos.");
            return "error400.jsp"; // Mostrar página de error
        } catch (Exception403 e) {
            return "redirect:/Login";
        }

        log.log(Level.WARNING, "Entrando a la página del artículo de forma exitosa");
        // Devolver la vista JSP de la página del artículo
        return "article_details.jsp";
    }

}