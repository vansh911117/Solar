
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String mobile = request.getParameter("mobile");
    String service = request.getParameter("service");
    String message = request.getParameter("message");
    String time = request.getParameter("time");

    Connection conn = null;
    PreparedStatement ps = null;

    try {
       
        Class.forName("com.mysql.jdbc.Driver"); // Use the appropriate driver class for your database
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spr440", "root", "vansh");

        String query = "INSERT INTO quote (name, email, mobile, service, message, time) VALUES (?, ?, ?, ?, ?, ?)";
        ps = conn.prepareStatement(query);
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, mobile);
        ps.setString(4, service);
        ps.setString(5, message);
        ps.setString(6, time);
        ps.executeUpdate();
        request.getSession().setAttribute("successMessage", "Request has been successfully sent.");
        response.sendRedirect("index.jsp"); // Redirect back to the index page
   
    } catch (Exception e) {
        e.printStackTrace();
        request.getSession().setAttribute("errorMessage", "Time Slot Already Booked Choose Another Time");
        response.sendRedirect("index.jsp"); // Redirect back to the index page
   
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
