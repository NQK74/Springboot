package com.example.laptopshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.laptopshop.domain.User;

// query xuống database
@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // Tìm kiếm user theo email hoặc fullName
    @Query("SELECT u FROM User u WHERE LOWER(u.email) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(u.fullName) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    Page<User> searchUsers(@Param("keyword") String keyword, Pageable pageable);
    User save(User khanhUser);

    List<User> findByEmail(String email);

    User findFirstByEmail(String email);

    boolean existsByEmail(String email);

    List<User> findAll();

    User findById(long id);

    void deleteById(long id);
}
