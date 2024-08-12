package com.hrd.app;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Enumeration;

import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class Write {	
	
	@RequestMapping(value="/login/writeProcess")
	public String writer(Note note, Model model) {
		//유효성 검사 코드
		if(!isValid(note)) {
			String error_msg;
			try {
				error_msg = URLEncoder.encode("오류발생","UTF-8");
				model.addAttribute("msg",error_msg);
				return "forward:/login/writeplace";
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		insert_to_NOTE(note);
		
		return "writeProcess";
	}	
	
	
	private boolean isValid(Note note) {
		// TODO Auto-generated method stub
		return true;
	}
	
	
	private void insert_to_NOTE(Note note) {		
		
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
		final String insert_sql = "INSERT INTO note (num, log, head, id) VALUES (?,?,?,?)";
		try {
			Connection connection = ds.getConnection();
			final PreparedStatement preparedStatement = connection.prepareStatement(insert_sql);
			preparedStatement.setInt(1,note.getNum());
			preparedStatement.setString(2,note.getLog());
			preparedStatement.setString(3,note.getHead());
			preparedStatement.setString(4,note.getId());		
			int row = preparedStatement.executeUpdate();
			System.out.println("입력된 사용자 : " + row);
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
	
	/*private void count_num(Note note) {
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
		Connection connection = ds.getConnection();
		final PreparedStatement preparedStatement = connection.prepareStatement(count_num_sql);
		
	}*/
	
	@RequestMapping(value="/login/lookpage{num}")
	public String idcheck(@PathVariable int num) {
		
		return "lookpage";
	}
	
	
	
	
	
	
	
	
	
	

}
