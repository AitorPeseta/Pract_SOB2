package deim.urv.cat.homework2.controller;

import deim.urv.cat.homework2.exception.Exception400;
import deim.urv.cat.homework2.exception.Exception404;
import deim.urv.cat.homework2.model.Article;
import deim.urv.cat.homework2.service.ArticleService;
import deim.urv.cat.homework2.exception.*;
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

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@Controller
@Path("Articles")
public class ArticleController {

    @Inject ArticleService articleService;
    @Inject Models models;
    @Inject Logger log;


    @GET
    @Path("/")
    public String showArticlesPage() throws Exception {
        try {
            // Cargar los primeros artículos (página inicial)
            List<Article> articles = articleService.findArticleByTopicAuthor(null, null); // Vacío en lugar de null
            models.put("articles", articles);
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
        return "article_page.jsp";
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
            Article article = articleService.findArticleById(articleId);
            
            System.out.print(article.getIsPublic());
            System.out.print(username);

            if ( username == null && article.getIsPublic()==false) {
                throw new Exception403("");
            }else{

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
            return "login-form.jsp";
        } 

        log.log(Level.WARNING, "Entrando a la página del artículo de forma exitosa");
        // Devolver la vista JSP de la página del artículo
        return "article_details.jsp";
    }

}
