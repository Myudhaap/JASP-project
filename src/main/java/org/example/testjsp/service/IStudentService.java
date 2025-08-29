package org.example.testjsp.service;

import org.example.testjsp.domain.Student;
import org.example.testjsp.domain.StudentGroup;

import java.util.List;

public interface IStudentService {
    List<StudentGroup> getAll();
    Student getById(String id);
}
