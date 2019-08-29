<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 자바 코드 작성
	// 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	// username, email, password, confirm-password
	String name 	 = request.getParameter("username");
	String email 	 = request.getParameter("email");
	String password  = request.getParameter("password");
	// 위 데이터를 데이터 베이스에 넣기
	Connection conn = null;			
	Boolean connect = false;
		
	try {	
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
		conn = ds.getConnection();
		
		String sql = "INSERT INTO users(NAME, PW, EMAIL) VALUES (?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, password);
		pstmt.setString(3, email);
		pstmt.executeUpdate();
		
		connect = true;
		conn.close();
	} catch (Exception e) {	
		connect = false;
		e.printStackTrace();
	}	
		
	if (connect == true) {	
		System.out.println("연결되었습니다.");
	} else {	
		System.out.println("연결실패.");
	}	

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register/process.</title>
</head>
<body>
회원가입 처리<br>
이름    : <%=name %><br>
이메일 : <%=email %><br>
회원 가입이 완료 되었습니다.<br>
<a href="../sign.jsp">로그인 하기</a>

</body>
</html>