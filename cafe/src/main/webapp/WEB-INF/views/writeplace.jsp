<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%> 

<% 
	String id = request.getParameter("id");

	session.getAttribute("sessionid");
	String login_id = (String) session.getAttribute("sessionid");

	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt1 = null;
	ResultSet rs = null;
	ResultSet rs1 = null;
	
	String DB_DRIVER = "oracle.jdbc.OracleDriver";
	String CONNECTION_URL = 
			"jdbc:oracle:thin:@192.168.0.4:1521/xe";
	String DB_USER = "CAFEJW";
	String DB_PASSWORD = "cafejw";
	
	
	Class.forName(DB_DRIVER);
	
	conn = DriverManager.getConnection(CONNECTION_URL,DB_USER,DB_PASSWORD);
	String sql = "SELECT * FROM NOTE";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();	
	
	
	
	ArrayList<String> list = new ArrayList<>();
	while (rs.next()) {
		list.add(rs.getString("id"));
	}
	
	
	String find_num = "SELECT num FROM NOTE";
	pstmt1 = conn.prepareStatement(find_num);
	rs1 = pstmt1.executeQuery();
	int checknum = 0;
	while(rs1.next()){
		checknum =  rs1.getInt(1) + 1;
	}
%>  
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    table {
        margin: auto;
    }
    input[type="text"] {
        border: 1.5px rgb(68, 136, 244) solid;
        width: 500px;
        height: 30px;
        border-radius: 5px;
        padding-left: 10px;
    }
    textarea {
        border: 1.5px rgb(68, 136, 244) solid;
        width: 500px;
        height: 400px;
        border-radius: 5px;
        padding-left: 10px;
        padding-top: 10px;
        resize: none;
    }
    .header {
        height: 30px;
    }
    input[type="submit"] {
        width: 100px;
        height: 40px;
        font-size: 15px;
        border: 0;
        outline: 1.5px rgb(68, 136, 244) solid;
        border-radius: 5px;
        padding-left: 10px;
        background-color: rgb(164, 199, 255);
    }
    input[type="submit"]:active {
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


<form action="/app/login/writeProcess" method="post">
<table> 
	<% %>
    <tr><td><h2>글쓰기</h2></td></tr>
    <tr><td class="header" name = "num" th:text="${note.num}"><%=checknum %></td></tr>
    <tr><td><input type="text" placeholder="위 숫자를 입력하세요." name="num"></td></tr>   
    <tr><td class="header">Title</td></tr>
    <tr><td><input type="text" placeholder="제목을 입력하세요" name="head"></td></tr>
    <tr><td class="header">Comment</td></tr>
    <tr><td><textarea placeholder="내용을 입력하세요" name="log"></textarea></td></tr>
    <tr><td class="header" name = "id<%=login_id%>"><%= login_id %></td></tr>    
    <tr><td><input type="submit" value="등록" onclick="alert('작성 완료!')"></td></tr>
</table>

</form>


</body>
</html>