<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*"%>

<%
	String id = request.getParameter("id");	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String CONNECTION_URL = 
			"jdbc:oracle:thin:@192.168.0.4:1521/xe";
	String DB_USER = "CAFEJW";
	String DB_PASSWORD = "cafejw";
	String DB_DRIVER = "oracle.jdbc.OracleDriver";
	
	Class.forName(DB_DRIVER);
	
	conn = DriverManager.getConnection(CONNECTION_URL,DB_USER,DB_PASSWORD);
	String sql = "SELECT * FROM CAFEJW WHERE id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%if(rs.next()) { %>
	<script>
	alert('중복입니다.')
	location.href = "/app/register/add";	
	</script>
	<% } else { %>
	<script>
	alert('사용가능한 아이디 입니다.')
	location.href = "/app/register/add";	
	</script>
	<% } %>

</body>
</html>