package org.example.testjsp.web;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.testjsp.domain.BaseResponse;
import org.example.testjsp.domain.User;
import org.example.testjsp.service.IAuthService;
import org.example.testjsp.service.impl.AuthServiceImpl;

import java.io.IOException;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {

    private IAuthService authService = new AuthServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        if (session != null && session.getAttribute("userId") != null) {
            resp.sendRedirect(req.getContextPath() + "/");
        } else {
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String userId = req.getParameter("userId");
        String password = req.getParameter("password");

        User user = authService.login(userId, password);

        System.out.println("user:" + user);
        System.out.println("userId:" + userId);
        System.out.println("password:" + password);
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("userId", userId);
            var baseResponse = new BaseResponse<>(true, "Login successfully", null);
            resp.getWriter().print(gson.toJson(baseResponse));
        } else {
            var baseResponse = new BaseResponse<>(false, "Invalid userId or password", null);
            resp.getWriter().print(gson.toJson(baseResponse));
        }
    }
}
