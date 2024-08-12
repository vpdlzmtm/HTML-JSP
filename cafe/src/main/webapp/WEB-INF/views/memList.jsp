<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String sessionid = null;
if (session.getAttribute("sessionid") != null) { //세션에서 받아온 id가 null이 아니면
	sessionid = (String) session.getAttribute("sessionid"); //sessionid에 id값 저장
	out.println("id : <strong>" + sessionid + "</strong>님 반갑습니다."); 
} else {
	response.sendRedirect("/");
	return;
}




Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String DB_DRIVER = "oracle.jdbc.OracleDriver";
String CONNECTION_URL = 
		"jdbc:oracle:thin:@192.168.0.4:1521/xe";
String DB_USER = "CAFEJW";
String DB_PASSWORD = "cafejw";

try {
	Class.forName(DB_DRIVER);
	
	conn = DriverManager.getConnection(CONNECTION_URL,DB_USER,DB_PASSWORD);

	String sql = "SELECT * FROM cafejw";
	String find_admin = "Admin9909";
	pstmt = conn.prepareStatement(sql);

	rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인완료</title>
</head>
<body>	
	<%
	if (sessionid == find_admin) { //loginProcess에서 세션으로 받아온 level이 5라면 관리자모드 이므로 테이블 보여줌
	%>
	<table border="1">
		<caption>회원목록</caption>
		<thead>
			<tr>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>이름</th>
				<th>이메일</th>
				<th>생년월일</th>
				
			</tr>
		</thead>
		<tbody>
			<%
			while (rs.next()) {
				String id = rs.getString("id");
				String pass = rs.getString("pwd");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String birth = rs.getString("birth");
				
			%>
			<tr>
				<td><%=id%></td>
				<td><%=pass%></td>
				<td><%=name%></td>
				<td><%=email%></td>
				<td><%=birth%></td>
				
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	<%
	} else { //아니면 그냥 환영합니다 띄움
	%>
	<h3>환영합니다!</h3>
	<%
	}
	%>
	<a href="login_home">홈페이지로</a>
</body>
</html>

<%
}catch (ClassNotFoundException e) {
e.printStackTrace();
} catch (SQLException e) {
e.printStackTrace();
} catch (Exception e) {
e.printStackTrace();
} finally {
try {
	rs.close();
	pstmt.close();
	conn.close();
} catch (SQLException e) {
	e.printStackTrace();
}
}
%>