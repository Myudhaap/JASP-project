package org.example.testjsp.service.impl;

import org.example.testjsp.domain.User;
import org.example.testjsp.service.IAuthService;

public class AuthServiceImpl implements IAuthService {
    @Override
    public User login(String userId, String password) {
        User user = new User("admin", "12345");

        if (userId.equals(user.getUserId()) && password.equals(user.getPassword())) {
            return user;
        } else {
            return null;
        }
    }
}
