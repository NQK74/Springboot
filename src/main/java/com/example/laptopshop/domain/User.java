package com.example.laptopshop.domain;

import jakarta.persistence.*;

import java.util.List;

// Tạo table thông qua entity
@Entity
@Table(name = "users")
public class User {
    // Chỉ ứng cho thằng đầu tiên
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String fullName;
    private String email;
    private String password;
    private String address;
    private String phone;

    private String avatar;

    // roleId
    //User many -> to one Role
    @ManyToOne
    @JoinColumn(name = "role_id") // foreign key
    private Role role;

    @OneToMany(mappedBy = "user")
    private List<Order> order;

    public User() {
    }

    public User(long id, String fullName, String email, String password, String address, String phone) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.address = address;
        this.phone = phone;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", fullName=" + fullName + ", email=" + email + ", password=" + password
                + ", address=" + address + ", phone=" + phone + ", avatar=" + avatar + "]";
    }

}
