package com.zn.stdc.dao;

import com.zn.stdc.pojo.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserDAO extends JpaRepository<User,Integer> {

    User findByUsername(String username);

    User getByUsernameAndPassword(String username,String password);

    User findByUserId(int userId);
}
