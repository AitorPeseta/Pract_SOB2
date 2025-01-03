package deim.urv.cat.homework2.controller;

import deim.urv.cat.homework2.exception.Exception400;
import deim.urv.cat.homework2.exception.Exception404;
import deim.urv.cat.homework2.model.Article;
import deim.urv.cat.homework2.service.ArticleService;
import deim.urv.cat.homework2.exception.*;
import jakarta.inject.Inject;
import jakarta.mvc.Controller;
import jakarta.mvc.Models;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.QueryParam;
import java.util.ArrayList;

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
    public String showArticlesPage() throws Exception {
        try {
            // Cargar los primeros artículos (página inicial)
            List<Article> articles = articleService.findArticleByTopicAuthor(null, null); // Vacío en lugar de null
            models.put("articles", articles);
            models.put("page", 0); // Página inicial
        } catch (Exception404 e) {
            // Manejo de errores: agregar un mensaje de error al modelo
            models.put("error", "No se ha encontrado el artículo.");
            return "error404.jsp"; // Mostrar página de error
        } catch (Exception400 e) {
            // Manejo de errores: agregar un mensaje de error al modelo
            models.put("error", "Los parámetros que nos has proporcionado son incorrectos.");
            return "error400.jsp"; // Mostrar página de error
        } 
        return "article_page.jsp";
    }

}
