<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String mobile = request.getParameter("mobile");
String service = request.getParameter("service");
String message = request.getParameter("message");
String time = request.getParameter("time");

Connection conn = null;
PreparedStatement pstmt = null;

try {
    String url = "jdbc:mysql://localhost:3306/spr440"; // Replace with your database URL
    String username = "root"; // Replace with your database username
    String password = "vansh"; // Replace with your database password

    Class.forName("com.mysql.cj.jdbc.Driver"); // Use the appropriate driver class for your database
    conn = DriverManager.getConnection(url, username, password);

    // Check if there's a reservation within the next 30 minutes
    String checkQuery = "SELECT * FROM quote WHERE time >= NOW() AND time <= DATE_ADD(NOW(), INTERVAL 30 MINUTE)";
    pstmt = conn.prepareStatement(checkQuery);
    ResultSet resultSet = pstmt.executeQuery();

    if (resultSet.next()) {
        // Reservation exists within the next 30 minutes
        request.getSession().setAttribute("errorMessage", "A reservation already exists within the next 30 minutes. Please choose a different time.");
    } else {
        // No reservation within the next 30 minutes, proceed with the insertion
        String insertQuery = "INSERT INTO quote (name, email, mobile, service, message, time) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(insertQuery);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, mobile);
        pstmt.setString(4, service);
        pstmt.setString(5, message);
        pstmt.setString(6, time);
        pstmt.executeUpdate();
        request.getSession().setAttribute("successMessage", "Data has been successfully inserted into the database.");
    }

    response.sendRedirect("demo.jsp"); // Redirect back to the index page
} catch (Exception e) {
    e.printStackTrace();
    request.getSession().setAttribute("errorMessage", "An error occurred while inserting data into the database.");
    response.sendRedirect("demo.html"); // Redirect back to the index page
} finally {
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
}
%>
