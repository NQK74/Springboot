package com.example.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.laptopshop.domain.User;
import java.util.List;

// query xuống database
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User save(User khanhUser);

    List<User> findByEmail(String email);

    List<User> findAll();

    User findById(long id);

    void deleteById(long id);

}
