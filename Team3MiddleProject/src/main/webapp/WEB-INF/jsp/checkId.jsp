<%@ page language="java" contentType="text/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.HashMap, com.google.gson.Gson" %>

<%
    // HTTP 요청으로부터 "id" 파라미터 값 가져오기
    String userId = request.getParameter("id");
    boolean isDuplicate = false;

    // JDBC 관련 변수들을 선언합니다.
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 1. JDBC 드라이버 로드
        //    사용하는 DB에 따라 드라이버 클래스 이름이 다릅니다. (예: Oracle, MySQL)
        Class.forName("com.mysql.cj.jdbc.Driver"); // ⭐MySQL 드라이버⭐
        
        // 2. 데이터베이스 연결
        //    ⭐아래 DB_URL, USER, PASSWORD를 자신의 정보로 바꿔주세요!⭐
        String dbURL = "jdbc:mysql://localhost:3306/your_database_name";
        String dbUser = "your_db_username";
        String dbPassword = "your_db_password";
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        
        // 3. SQL 쿼리 준비 (PreparedStatement 사용)
        //    ?를 사용하면 SQL 인젝션을 막을 수 있어 안전합니다.
        String sql = "SELECT COUNT(*) FROM user_table WHERE user_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        
        // 4. 쿼리 실행 및 결과 받기
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            // 결과의 첫 번째 값(COUNT(*))이 0보다 크면 중복입니다.
            if (rs.getInt(1) > 0) {
                isDuplicate = true;
            }
        }
        
    } catch (Exception e) {
        // DB 연결 또는 쿼리 실행 중 오류가 발생하면 isDuplicate를 true로 설정
        // 사용자에게 오류가 발생했음을 알리기 위함입니다.
        e.printStackTrace();
        isDuplicate = true;
    } finally {
        // 5. 사용한 자원(리소스) 해제
        //    메모리 누수를 막기 위해 사용한 객체들을 반드시 닫아줍니다.
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 6. 결과 데이터를 JSON 형태로 생성
    HashMap<String, Object> result = new HashMap<>();
    result.put("isDuplicate", isDuplicate);

    Gson gson = new Gson();
    String jsonOutput = gson.toJson(result);

    // HTTP 응답 헤더 설정 및 데이터 전송
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    out.print(jsonOutput);
    out.flush();
%>