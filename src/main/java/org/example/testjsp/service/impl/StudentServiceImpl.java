package org.example.testjsp.service.impl;

import org.example.testjsp.domain.Student;
import org.example.testjsp.domain.StudentGroup;
import org.example.testjsp.repository.IStudentRepository;
import org.example.testjsp.repository.impl.StudentRepositoryImpl;
import org.example.testjsp.service.IStudentService;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collector;
import java.util.stream.Collectors;

public class StudentServiceImpl implements IStudentService {
    private final IStudentRepository repository = new StudentRepositoryImpl();

    @Override
    public List<StudentGroup> getAll() {
        List<Student> students = repository.findAll();
        return students.stream()
                .collect(Collectors.groupingBy(val -> val.getDepartment().getDepartmentId()))
                .entrySet().stream()
                .map(val -> new StudentGroup(val.getKey(), val.getValue()))
                .sorted(Comparator.comparing(StudentGroup::getDepartmentId))
                .collect(Collectors.toList());
    }

    @Override
    public Student getById(String id) {
        Optional<Student> student = repository.findById(id);
        return student.orElse(null);
    }
}
