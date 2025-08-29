package org.example.testjsp.web;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.testjsp.domain.BaseResponse;
import org.example.testjsp.domain.Student;
import org.example.testjsp.service.IStudentService;
import org.example.testjsp.service.impl.StudentServiceImpl;

import java.io.IOException;

@WebServlet("/student/detail")
public class StudentDetailServlet extends HttpServlet {
    private final IStudentService service = new StudentServiceImpl();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String id = req.getParameter("id");
        System.out.println(id);

        Student student = service.getById(id);
        if (student != null) {
            BaseResponse body = new BaseResponse<Student>(true, "Successfully get student", student);
            resp.getWriter().print(gson.toJson(body));
        } else {
            BaseResponse body = new BaseResponse<>(false, "Student not found", null);
            resp.getWriter().print(gson.toJson(body));
        }
    }
}
