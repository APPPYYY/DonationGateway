package com.razorpay.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "payment_info")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PaymentInfo {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "uuid")
	private int uuId;
	
	@Column(name = "order_id")
	private String orderId;
	private String amount;
	private String receipt;
	private String status;
	@Column(name="payment_id")
	private String paymentId;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private UserEntity user;
}
