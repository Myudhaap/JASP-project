package org.example.testjsp.repository.impl;

import org.example.testjsp.domain.Department;
import org.example.testjsp.domain.Student;
import org.example.testjsp.repository.IStudentRepository;

import java.time.Instant;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

public class StudentRepositoryImpl implements IStudentRepository {
    Department department1 = new Department("dep1", "Dep 1");
    Department department2 = new Department("dep2", "Dep 2");
    Department department3 = new Department("dep3", "Dep 3");

    List<Student> students = List.of(
            new Student("S1", "John Doe", true, new Date(), department1, 35),
            new Student("S2", "Example 1", true, new Date(), department1, 70),
            new Student("S3", "Example 2", false, new Date(), department1, 60),
            new Student("S4", "Example 3", true, new Date(), department1, 90),
            new Student("S5", "Example 4", false, new Date(), department2, 30),
            new Student("S6", "Example 5", true, new Date(), department3, 32),
            new Student("S7", "Example 6", false, new Date(), department3, 70),
            new Student("S8", "Example 7", true, new Date(), department3, 20)
    );

    @Override
    public List<Student> findAll() {
        return students;
    }

    @Override
    public Optional<Student> findById(String id) {
        return students.stream()
                .filter(val -> Objects.equals(val.getStudentId(), id))
                .findFirst();
    }
}
