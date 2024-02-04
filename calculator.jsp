<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
String streetAddress = request.getParameter("street_address");
String city = request.getParameter("city");
String pincode = request.getParameter("pincode");
String state = request.getParameter("state");
String homeSquareFeet = request.getParameter("home_square_feet");
String numberOfStories = request.getParameter("number_of_stories");

if (streetAddress != null && city != null && pincode != null && state != null && homeSquareFeet != null && numberOfStories != null) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/spr440","root", "vansh");

        String qr = "INSERT INTO calculator (street_address, city, pincode, state, home_square_feet, number_of_stories) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(qr);
        ps.setString(1, streetAddress);
        ps.setString(2, city);
        ps.setString(3, pincode);
        ps.setString(4, state);
        ps.setString(5, homeSquareFeet);
        ps.setString(6, numberOfStories);
        
        ps.executeUpdate();

        ps.close();
        con.close();

        response.sendRedirect("showcalculator.jsp"); // Redirect to a success page
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
}
%>
