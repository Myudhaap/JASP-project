package org.example.testjsp.service;

import org.example.testjsp.domain.User;

public interface IAuthService {
    User login(String userId, String password);
}
