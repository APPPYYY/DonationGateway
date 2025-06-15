package com.razorpay.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.razorpay.entities.PaymentInfo;

public interface PaymentInfoRepo extends JpaRepository<PaymentInfo	, Integer> {

	PaymentInfo findByOrderId(String orderId);
}
