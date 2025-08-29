package org.example.testjsp.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.testjsp.domain.StudentGroup;
import org.example.testjsp.service.IStudentService;
import org.example.testjsp.service.impl.StudentServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet("/")
public class DashboardServlet extends HttpServlet {
    private final IStudentService service = new StudentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<StudentGroup> studentGroups = service.getAll();

        if (session != null && session.getAttribute("userId") != null) {
            req.setAttribute("userId", session.getAttribute("userId"));
            req.setAttribute("students", studentGroups);
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
        }
    }
}
