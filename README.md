# Donation Gateway with Razorpay & Spring Boot
A clean, elegant, and secure donation payment gateway built using Spring Boot, Razorpay API, and Bootstrap 5. This project demonstrates a modern, responsive UI combined with a robust backend to handle payments effortlessly.

**Features**

Simple and intuitive donation form

Responsive design with Bootstrap 5 and smooth animations

Razorpay payment integration for secure transactions

Real-time payment status updates and error handling

Spring Boot REST API for order creation and payment status updates

**Technology Stack**

Backend: Java, Spring Boot

Frontend: HTML, CSS, Bootstrap 5, JavaScript, jQuery

Payment Gateway: Razorpay

Build Tool: Maven/Gradle (specify which one you used)

**Getting Started**

Prerequisites

Java 11+

Maven/Gradle

Razorpay account (for API keys)

**Setup**

Clone the repository

git clone https://github.com/APPPYYY/DonationGateway.git

Navigate into the project directory

cd donation-gateway

Configure your Razorpay API keys in 

✅ Java File - RazorpayController (.java):

private static final String RAZORPAY_TEST_CLIENT_ID = "rzp_test_YourActualClientId";

private static final String RAZORPAY_TEST_CLIENT_SECRET = "YourActualClientSecret";

✅ JSP File (\src\main\webapp\views\donation.jsp at line 164):

key: "rzp_test_YourActualClientId",

Build and run the Spring Boot application

./mvnw spring-boot:run

Open your browser and go to http://localhost:8080/pay/donation

How it works

User enters donation amount

Frontend calls backend to create a Razorpay order

Razorpay checkout opens for payment

On successful payment, backend updates payment status

User receives confirmation alerts

Contributing

Feel free to open issues or submit pull requests. Your contributions are welcome!

Contact

Created by Subham Behera - comeflywithmes1999@gmail.com

LinkedIn: linkedin.com/in/subham1111


