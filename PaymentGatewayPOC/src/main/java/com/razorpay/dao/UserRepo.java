package com.razorpay.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.razorpay.entities.UserEntity;

public interface UserRepo extends JpaRepository<UserEntity, Integer> {

}
