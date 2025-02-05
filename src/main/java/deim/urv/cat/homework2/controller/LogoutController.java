package deim.urv.cat.homework2.controller;

import jakarta.inject.Inject;
import jakarta.mvc.Controller;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Context;

import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;

@Path("Logout")
@Controller
public class LogoutController {
    @Inject Logger log;

    @Context
    private HttpServletRequest request;

    @POST
    public String invalidate() {
        // Invalidar la sesión HTTP
        HttpSession session = request.getSession();
        Enumeration<String> attributes = session.getAttributeNames();
        while (attributes.hasMoreElements()) {
            String key = attributes.nextElement();
            Object obj = session.getAttribute(key);
            log.log(Level.INFO, "Session attribute {0}:{1}", 
                    new Object[] { key, obj });
        }
        session.invalidate();
        return "redirect:/Articles"; // Redirigir a una página predeterminada si no hay Referer
    }
}

