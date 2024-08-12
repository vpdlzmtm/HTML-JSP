package com.hrd.app;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.DriverPropertyInfo;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RegisterController {
	
	
		
	@GetMapping(value="/register/add")
	public String register() {
		return "registerForm";
	}
	
	
	@RequestMapping(value="/register/check")
	public String idcheck() {
		return "idcheck";
	}
	
	
	@RequestMapping(value="/register/success")
	public String save(User user, Model model) {
		//유효성 검사 코드
		if(!isValid(user)) {
			String error_msg;
			try {
				error_msg = URLEncoder.encode("오류발생","UTF-8");
				model.addAttribute("msg",error_msg);
				return "forward:/register/add";
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		insert_to_SPRING_TBL(user);
		return "registerSuccess";
	}
	
	
	private void insert_to_SPRING_TBL(User user) {
		// TODO Auto-generated method stub
		final String CONNECTION_URL = 
				"jdbc:oracle:thin:@192.168.0.4:1521/xe";
		final String DB_USER = "CAFEJW";
		final String DB_PASSWORD = "cafejw";
		final String DB_DRIVER = "oracle.jdbc.OracleDriver";
		DriverManagerDataSource ds = new DriverManagerDataSource();
		ds.setDriverClassName(DB_DRIVER);
		ds.setUrl(CONNECTION_URL);
		ds.setUsername(DB_USER);
		ds.setPassword(DB_PASSWORD);
		final String insert_sql = "INSERT INTO cafejw (id, pwd, name, email, birth) VALUES (?,?,?,?,?)";
		try {
			Connection connection = ds.getConnection();
			final PreparedStatement preparedStatement = connection.prepareStatement(insert_sql);
			preparedStatement.setString(1,user.getId());
			preparedStatement.setString(2,user.getPassword());
			preparedStatement.setString(3,user.getName());
			preparedStatement.setString(4,user.getEmail());			
			preparedStatement.setDate(5,java.sql.Date.valueOf(user.getBirth()));
			int row = preparedStatement.executeUpdate();
			System.out.println("입력된 사용자 : " + row);
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}


	private boolean isValid(User user) {
		// TODO Auto-generated method stub
		return true;
	}
	
	private void bringID() {
		final String CONNECTION_URL = 
				"jdbc:oracle:thin:@192.168.0.4:1521/xe";
		final String DB_USER = "cafejw";
		final String DB_PASSWORD = "cafejw";		
		final String select_sql = 
				"SELECT id FROM CAFEJW where id = ?";
		Connection connection = null;
		String user_id =  null;
		try {
			connection = DriverManager.getConnection(CONNECTION_URL, DB_USER, DB_PASSWORD);
			final PreparedStatement preparedstatement = connection.prepareStatement(select_sql);
			final ResultSet rs = preparedstatement.executeQuery();
			preparedstatement.setString(1, user_id );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
