<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>

<% 
	String id = request.getParameter("id");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String DB_DRIVER = "oracle.jdbc.OracleDriver";
	String CONNECTION_URL = 
			"jdbc:oracle:thin:@192.168.0.4:1521/xe";
	String DB_USER = "CAFEJW";
	String DB_PASSWORD = "cafejw";
	
	
	Class.forName(DB_DRIVER);
	
	conn = DriverManager.getConnection(CONNECTION_URL,DB_USER,DB_PASSWORD);
	String sql = "SELECT * FROM CAFEJW";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	ArrayList<String> list = new ArrayList<>();
	while (rs.next()) {
		list.add(rs.getString("id"));
	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <style>
        * { box-sizing:border-box; }

        form {
            width:400px;
            height:600px;
            display : flex;
            flex-direction: column;
            align-items:center;
            position : absolute;
            top:50%;
            left:50%;
            transform: translate(-50%, -50%) ;
            border: 1px solid rgb(89,117,196);
            border-radius: 10px;
        }

        .input-field {
            width: 300px;
            height: 40px;
            border : 1px solid rgb(89,117,196);
            border-radius:5px;
            padding: 0 10px;
            margin-bottom: 10px;
        }
        label {
            width:300px;
            height:30px;
            margin-top :4px;
        }

        button {
            background-color: rgb(89,117,196);
            color : white;
            width:300px;
            height:50px;
            font-size: 17px;
            border : none;
            border-radius: 5px;
            margin : 20px 0 30px 0;
        }

        .title {
            font-size : 50px;
            margin: 40px 0 30px 0;
        }

        .msg {
            height: 30px;
            text-align:center;
            font-size:16px;
            color:red;
            margin-bottom: 20px;
        }
        .sns-chk {
            margin-top : 5px; 
        }
        
        
        
    </style>
    <title>Register</title>
    <script>
	function submit2(frm) { //폼에서 액션 경로를 여러개 사용하기 위한 함수
		frm.action = 'check'; //두번째로 보낼 경로 아이디 중복 체크하는 부분
		frm.submit();
		return false;
	}
	</script>
</head>
<body>
   <form action="/app/register/success" method="post" name="frm" onsubmit="return formCheck(this)">
    <div class="title">Register</div>
	<div id="msg" class="msg">${URLDecoder.decode(param.msg, "UTF-8")}</div>
    <label for="">아이디</label>
    <input class="input-field" type="text" name="id" placeholder="8~12자리의 영대소문자와 숫자 조합"  maxlength="12" >
    <button onclick="return submit2(this.form);">아이디 중복체크</button>
    <label for="">비밀번호</label>
    <input class="input-field" type="password" name="password" placeholder="8~12자리의 영대소문자와 숫자 조합" maxlength="12">
    <label for="">이름</label>
    <input class="input-field" type="text" name="name" placeholder="KarL">
    <label for="">이메일</label>
    <input class="input-field" type="text" name="email" placeholder="karl@luxwaves.co.kr"> 
    <label for="">생일</label>
    <input class="input-field" type="text" name="birth" placeholder="2022-12-31">    
    <button>회원 가입</button>
   </form>
   
  
   
   <script>
       function formCheck(frm) {
            let msg =''; 
            
            let putid2 = frm.id.value.toLowerCase();
            let putid3 = frm.id.value.toUpperCase();
            let putid1 = frm.id.value;
            
            let putpwd1 = frm.password.value.toLowerCase();
            let putpwd2 = frm.password.value.toUpperCase();
            let putpwd3 = frm.password.value;
            
            var putname = frm.name.value;
            var putemail = frm.email.value;
            var putbirth = frm.birth.value;
            
            var checknull = null;
            var nullcheck = checknull;
            
            if(putid1 == putid2 ) {
                setMessage('id는 대소문자를 둘다 사용해야합니다.', frm.id);
                return false;                
            }
            
            if(putid1 == putid3 ) {
                setMessage('id는 대소문자를 둘다 사용해야합니다.', frm.id);
                return false;
                
            }
            
            
            if(frm.id.value.length<8 ) {
                setMessage('id의 길이는 8이상이어야 합니다.', frm.id);
                return false;
                
            } 
            
            
            if(putpwd1 == putpwd2) {
                setMessage('pwd는 대소문자를 둘다 사용해야합니다.', frm.password);
                return false;
                
            }
            
            if(putpwd1 == putpwd3) {
                setMessage('pwd는 대소문자를 둘다 사용해야합니다.', frm.password);
                return false;
                
            }  
           

            if(frm.password.value.length<8) {
                setMessage('pwd의 길이는 8이상이어야 합니다.', frm.password);
                return false;
                
            }    
            
            if(frm.name.value.length<1){
            	setMessage('이름을 입력하셔야 합니다.', frm.name);
                return false;
            }
            
            if(frm.email.value.length<1){
            	setMessage('이메일을 입력하셔야 합니다.', frm.email);
                return false;
            }
            
            if(frm.birth.value.length<1){
            	setMessage('생일을 입력하셔야 합니다.', frm.birth);
                return false;
            }
            
            
            
            
            
           
           return true;
       }

       function setMessage(msg, element){
            document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;

            if(element) {
                element.select();
            }
       }
       
       
		
		
       
       
       
   </script> 
 
</body>
</html>