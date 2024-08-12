<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*"%>

<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pwd");
	
	if(id.equals("") || id.equals(null)) {
		response.sendRedirect("/app/loginFrom");
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
		
		String sql = "SELECT * FROM CAFEJW WHERE id = ?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		rs = pstmt.executeQuery();
		
		if(rs.next() && pass.equals(rs.getString("pwd"))) { //데이터베이스에 데이터가 있고 비밀번호와 데이터베이스에서 받아온 비밀번호가 같을 경우
			session.setAttribute("sessionid", id); // id를 sessionid로 세션으로 받음
			//session.setAttribute("level", rs.getInt("level")); //level을 세션으로 받아서 memList에서 처리
			response.sendRedirect("memList"); //memList.jsp로 이동
			return;
		} else {
			out.print("<script>alert('id또는 비밀번호가 틀립니다.'); location.href = '/app/login';</script>"); //아이디 비밀번호가 다를 시 script로 alert창을 띄우고 login.jsp로 이동
			return;
		}
		
	}catch(ClassNotFoundException e) {
		e.printStackTrace();
	}catch(SQLException e) {
		e.printStackTrace();
	}catch(Exception e) {
		e.printStackTrace();
	}finally {
		try {
			pstmt.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
%>