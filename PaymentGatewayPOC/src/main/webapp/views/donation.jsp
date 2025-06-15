<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Donate with Love</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Razorpay -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- SweetAlert -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Animated background */
        .animated-bg {
            position: fixed;
            top: 0; left: 0;
            width: 100vw;
            height: 100vh;
            background: linear-gradient(270deg, #a1c4fd, #c2e9fb, #fddb92, #a1c4fd);
            background-size: 800% 800%;
            animation: gradientBG 15s ease infinite;
            z-index: -2;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Glowing particles */
        .particles {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .circle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255,255,255,0.2);
            animation: floatCircle 10s linear infinite;
        }

        @keyframes floatCircle {
            from { transform: translateY(0); opacity: 1; }
            to { transform: translateY(-100vh); opacity: 0; }
        }

        .donation-card {
            background: #ffffff;
            color: #333333;
            border-radius: 25px;
            padding: 40px 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            transition: all 0.5s ease;
        }

        .donation-card:hover {
            transform: scale(1.02) rotateX(3deg) rotateY(3deg);
        }

        .donation-title {
            font-weight: bold;
            color: #0069d9;
            font-size: 26px;
            animation: fadeInDown 1s ease-in-out;
        }

        .form-control {
            border-radius: 25px;
            padding: 10px 15px;
            font-size: 16px;
            animation: fadeInUp 1.2s ease-in-out;
        }

        .donation-btn {
    background-color: #e83e8c;
    color: white;
    border: none;
    border-radius: 30px;
    padding: 12px 20px;
    font-size: 16px;
    font-weight: bold;
    box-shadow: 0 4px 15px rgba(232, 62, 140, 0.4);
    transition: all 0.4s ease;
    animation: pulseHeart 2s infinite;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.donation-btn:hover {
    background: linear-gradient(135deg, #e83e8c, #ff6fa3);
    box-shadow: 0 6px 25px rgba(255, 105, 180, 0.5);
    transform: scale(1.05);
}

@keyframes pulseHeart {
    0% { transform: scale(1); }
    50% { transform: scale(1.03); }
    100% { transform: scale(1); }
}


        .logo {
            width: 90px;
            margin-bottom: 15px;
            animation: floatLogo 3s infinite ease-in-out;
        }

        @keyframes floatLogo {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>

    <script>
        function paymentStart() {
            let amount = $("#payment_field").val();
            if (!amount || isNaN(amount)) {
                swal("Error!", "Please enter a valid amount.", "error");
                return;
            }

            $.ajax({
                url: '/pay/razorpay/createOrder',
                data: JSON.stringify({ amount: amount, info: 'order_request' }),
                contentType: 'application/json',
                type: 'POST',
                dataType: 'json',
                success: function (response) {
                    if (response.status === 'created') {
                        var options = {
                            key: "",
                            amount: response.amount,
                            currency: "INR",
                            name: "Donation Drive",
                            description: "Support our cause",
                            image: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                            order_id: response.id,
                            handler: function (paymentResponse) {
                                updatePaymentStatusOnServer(paymentResponse.razorpay_payment_id, paymentResponse.razorpay_order_id, "paid");
                            },
                            prefill: {
                                name: "",
                                email: "",
                                contact: ""
                            },
                            theme: {
                                color: "#007bff"
                            }
                        };
                        let rzp = new Razorpay(options);
                        rzp.open();
                    }
                },
                error: function () {
                    swal("Error!", "Error creating Razorpay order.", "error");
                }
            });
        }

        function updatePaymentStatusOnServer(paymentId, orderId, status) {
            $.ajax({
                url: '/pay/razorpay/updateOrder',
                data: JSON.stringify({ paymentId: paymentId, orderId: orderId, status: status }),
                contentType: 'application/json',
                type: 'POST',
                dataType: 'json',
                success: function () {
                    swal("Thank you!", "Payment successful 🙌", "success");
                },
                error: function () {
                    swal("Error!", "Your payment was successful but not saved in our system. We will contact you.", "error");
                }
            });
        }

        // Floating particles
        $(document).ready(function () {
            for (let i = 0; i < 30; i++) {
                let size = Math.random() * 10 + 10;
                $('.particles').append(
                    `<div class="circle" style="
                        width: ${size}px;
                        height: ${size}px;
                        left: ${Math.random() * 100}%;
                        top: ${Math.random() * 100}%;
                        animation-duration: ${Math.random() * 10 + 10}s;
                        animation-delay: ${Math.random()}s;
                    "></div>`
                );
            }
        });
    </script>
</head>

<body>

    <div class="animated-bg"></div>
    <div class="particles"></div>

    <div class="container d-flex align-items-center justify-content-center vh-100">
        <div class="col-md-5">
            <div class="donation-card text-center">
                <img class="logo" src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="logo">
                <h3 class="donation-title mb-4">Support the Cause ❤️</h3>
                <input type="text" id="payment_field" class="form-control mb-3" placeholder="Enter amount (INR)">
                <button class="btn donation-btn w-100" onclick="paymentStart()">
									<i class="bi bi-heart-fill me-2"></i>Donate Now
								</button>
								

            </div>
        </div>
    </div>

</body>
</html>
