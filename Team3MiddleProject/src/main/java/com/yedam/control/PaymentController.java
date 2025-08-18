package com.yedam.control;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet({"/payment/success", "/payment/fail", "/payment/confirm", "/payment/detail"})
public class PaymentController extends HttpServlet {
    private static final String SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6"; // 1단계에서 발급받은 시크릿 키

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/detail".equals(path)) {
            // 결제 상세 내역 조회
            showPaymentDetail(req, resp);
        } else if ("/fail".equals(path)) {
            // 결제 실패 페이지로 이동
            req.getRequestDispatcher("/WEB-INF/views/fail.jsp").forward(req, resp);
        } else if ("/success".equals(path)) {
            // 결제 성공 페이지로 이동
            req.getRequestDispatcher("/WEB-INF/views/success.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/confirm".equals(path)) {
            // 결제 승인
            confirmPayment(req, resp);
        }
    }

    // 결제 승인 메서드
    private void confirmPayment(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode payload = objectMapper.readTree(req.getReader());

        String paymentKey = payload.get("paymentKey").asText();
        String orderId = payload.get("orderId").asText();
        long amount = payload.get("amount").asLong();

        // 토스페이먼츠 결제 승인 API 호출
        String url = "https://api.tosspayments.com/v1/payments/confirm";
        String encodedSecret = Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes(StandardCharsets.UTF_8));
        
        HttpURLConnection conn = null;
        try {
            conn = (HttpURLConnection) new URL(url).openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Basic " + encodedSecret);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            String requestBody = String.format("{\"paymentKey\":\"%s\",\"orderId\":\"%s\",\"amount\":%d}", paymentKey, orderId, amount);
            
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = requestBody.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // 결제 성공
                try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
                    String responseJson = br.readLine();
                    JsonNode successNode = objectMapper.readTree(responseJson);

                    // 성공 정보를 세션에 저장 (나중에 상세 내역 페이지에서 사용)
                    req.getSession().setAttribute("paymentDetail", successNode);
                    
                    // 클라이언트에게 성공 응답
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    resp.getWriter().write(responseJson);
                }
            } else {
                // 결제 실패
                try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8))) {
                    String errorJson = br.readLine();
                    resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    resp.getWriter().write(errorJson);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"code\":\"SERVER_ERROR\",\"message\":\"서버 오류가 발생했습니다.\"}");
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }

    // 결제 상세 내역 조회 메서드 (세션에서 정보 가져와서 JSP로 전달)
    private void showPaymentDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JsonNode paymentDetail = (JsonNode) req.getSession().getAttribute("paymentDetail");
        if (paymentDetail != null) {
            // 결제 정보를 request 속성에 저장
            req.setAttribute("paymentKey", paymentDetail.get("paymentKey").asText());
            req.setAttribute("orderId", paymentDetail.get("orderId").asText());
            req.setAttribute("orderName", paymentDetail.get("orderName").asText());
            req.setAttribute("totalAmount", paymentDetail.get("totalAmount").asLong());
            req.setAttribute("method", paymentDetail.get("method").asText());
            req.setAttribute("requestedAt", paymentDetail.get("requestedAt").asText());
            
            // 상세 내역 페이지로 이동
            req.getRequestDispatcher("/WEB-INF/views/paymentDetail.jsp").forward(req, resp);
        } else {
            // 정보가 없으면 실패 페이지로 리디렉션
            resp.sendRedirect("/WEB-INF/views/fail.jsp");
        }
    }
}