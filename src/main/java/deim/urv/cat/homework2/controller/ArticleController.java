package deim.urv.cat.homework2.controller;

import deim.urv.cat.homework2.model.Article;
import deim.urv.cat.homework2.service.ArticleService;

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
@Path("articles")
public class ArticleController {

    @Inject ArticleService articleService;
    @Inject Models models;
    @Inject Logger log;


        @GET
    public String showArticlesPage() {
        try {
            // Cargar los primeros artículos (página inicial)
            List<Article> articles = articleService.findArticleByTopicAuthor(null, 0); // Vacío en lugar de null
            if(articles == null) System.out.print("ESTOY VACIO OSTIAAA");
            models.put("articles", articles);
            models.put("page", 0); // Página inicial
        } catch (Exception e) {
            // Manejo de errores: agregar un mensaje de error al modelo
            models.put("error", "No se pudieron cargar los artículos. Por favor, inténtelo de nuevo más tarde.");
            return "error.jsp"; // Mostrar página de error
        }
        return "article_page.jsp";
    }

}
