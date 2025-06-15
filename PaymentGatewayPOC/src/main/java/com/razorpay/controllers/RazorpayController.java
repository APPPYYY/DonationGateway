package com.razorpay.controllers;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.dao.PaymentInfoRepo;
import com.razorpay.dao.UserRepo;
import com.razorpay.entities.PaymentInfo;
import com.razorpay.entities.UserEntity;

@RestController
@RequestMapping("/razorpay/")
public class RazorpayController {

	private static final String RAZORPAY_TEST_CLIENT_ID = "";
	private static final String RAZORPAY_TEST_CLIENT_SECRET = "";

	@Autowired
	private PaymentInfoRepo paymentInfoRepo;

	@Autowired
	private UserRepo userRepo;

	@PostMapping("createOrder")
	public ResponseEntity<Map<String, Object>> createOrder(@RequestBody Map<String, Object> payload) {
		String txnId = UUID.randomUUID().toString();
		Map<String, Object> response = new HashMap<>();
		try {
			int amt = Integer.parseInt(payload.get("amount").toString());

			RazorpayClient client = new RazorpayClient(RAZORPAY_TEST_CLIENT_ID, RAZORPAY_TEST_CLIENT_SECRET);

			JSONObject options = new JSONObject();
			options.put("amount", amt * 100);
			options.put("currency", "INR");
			options.put("receipt", "txn_" + txnId);

			Order order = client.orders.create(options);

			response.put("id", order.get("id"));
			response.put("amount", order.get("amount"));
			response.put("currency", order.get("currency"));
			response.put("status", order.get("status"));
			order.get("amount");
			UserEntity user = userRepo.findById(3).get();
			PaymentInfo paymentInfo = PaymentInfo.builder().orderId(order.get("id").toString()).user(user)
					.amount(String.valueOf(amt)).receipt(order.get("receipt").toString())
					.status(order.get("status").toString()).build();
			paymentInfoRepo.save(paymentInfo);

			return ResponseEntity.ok(response);

		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "FAILED");
			response.put("error", e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}

	@PostMapping("/updateOrder")
	public ResponseEntity<?> updateOrder(@RequestBody Map<String, Object> payload) {
	    String orderId = String.valueOf(payload.get("orderId"));
	    String paymentId = String.valueOf(payload.get("paymentId"));
	    String status = String.valueOf(payload.get("status"));

	    try {
	        PaymentInfo paymentInfo = paymentInfoRepo.findByOrderId(orderId);
	        if (paymentInfo == null) {
	            return ResponseEntity.status(HttpStatus.NOT_FOUND)
	                    .body(Map.of("error", "Order not found with orderId: " + orderId));
	        }

	        paymentInfo.setPaymentId(paymentId);
	        paymentInfo.setStatus(status);
	        paymentInfoRepo.save(paymentInfo);

	        return ResponseEntity.ok(Map.of("msg", "Order updated successfully"));
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body(Map.of(
	                    "error", "Something went wrong while updating order",
	                    "details", e.getMessage()
	                ));
	    }
	}


}
