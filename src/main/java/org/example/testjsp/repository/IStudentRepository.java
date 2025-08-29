package org.example.testjsp.repository;

import org.example.testjsp.domain.Student;

import java.util.List;
import java.util.Optional;

public interface IStudentRepository {
    List<Student> findAll();
    Optional<Student> findById(String id);
}
