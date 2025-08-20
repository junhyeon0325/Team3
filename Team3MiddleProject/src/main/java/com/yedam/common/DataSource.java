package com.yedam.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataSource { // 여러분의 맞춤형 DataSource 클래스

    private static String driver = "oracle.jdbc.driver.OracleDriver"; // 또는 사용하는 DB 드라이버
    private static String url = "jdbc:oracle:thin:@localhost:1521:xe"; // 여러분의 DB URL
    private static String user = "dev"; // 여러분의 DB 사용자 이름
    private static String password = "dev"; // 여러분의 DB 비밀번호

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }
}
