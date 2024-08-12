<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*"%>
    
<%
	//String id = request.getParameter("id");	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	session.getAttribute("sessionid");
	String login_id = (String) session.getAttribute("sessionid");
	
	String CONNECTION_URL = 
			"jdbc:oracle:thin:@192.168.0.4:1521/xe";
	String DB_USER = "CAFEJW";
	String DB_PASSWORD = "cafejw";
	String DB_DRIVER = "oracle.jdbc.OracleDriver";
	
	Class.forName(DB_DRIVER);
	
	conn = DriverManager.getConnection(CONNECTION_URL,DB_USER,DB_PASSWORD);
	String sql = "SELECT * FROM NOTE";
	String find_name = "SELECT ID FROM CAFEJW";
	pstmt = conn.prepareStatement(sql);
	//pstmt.setString(1, id);
	rs = pstmt.executeQuery();

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    table {
        margin: auto;
        width: 700px;
        border-radius: 5px;
        border-collapse: collapse;
        border-top: none;
    }
    .header {
        background-color: rgb(218, 231, 255);
        text-align: center;
    }
    .table td, .table th {
        border-bottom: 1px lightgray solid; 
        height: 30px;
        font-size: 14px;
    }
    .num {
        width: 50px;
    }
    .title {
        width: 500px;
    }
    .body {
        text-align: center;
    }
    .body .title {
        text-align: left;
    }
    button {
        width: 100px;
        height: 40px;
        font-size: 15px;
        border: 0;
        outline: 1.5px rgb(68, 136, 244) solid;
        border-radius: 5px;
        padding-left: 10px;
        background-color: rgb(164, 199, 255);
    }
    button:active {
        width: 100px;
        height: 40px;
        font-size: 15px;
        border: 0;
        border-radius: 5px;
        outline: 1.5px rgb(27, 76, 155) solid;
        padding-left: 10px;
        background-color: rgb(68, 136, 244);
    }
</style>
</head>
<body>
<table class="table">
    <tr><td colspan="2"><h2>게시판</h2></td></tr>
    <tr class="header">
        <td class="num">번호</td>
        <td class="head">제목</td>
        <td class="id">작성자</td>        
    </tr>
    <%
    while(rs.next()) {
    	int num = rs.getInt("num");		
		String head = rs.getString("head");
		String id = rs.getString("id");
		
    	%>
    <script> 
        
            document.write("<tr class='body'>");
            document.write("<td>" + <%=num%> +"</td>");
            document.write("<td><a href=\"/app/login/lookpage"+<%=num%>+"\"><%=head%></a></td>");
            document.write("<td><%= id %></td>");            
            document.write("</tr>");
        
       </script>
       <%} %>
</table>
<br>
<table>
    <tr>
        <td><button onclick="location.href='writeplace'">글쓰기</button></td>
    </tr>
</table>

</body>
</html>