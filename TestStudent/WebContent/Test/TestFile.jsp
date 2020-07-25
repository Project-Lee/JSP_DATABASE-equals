<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import= "java.util.*" %>
<%@ page import= "com.jy.test.StudentVO" %>

<%!
	public Connection getCon() throws Exception {
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String username = "hr";
		String password = "orcl";
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con = DriverManager.getConnection(url, username, password);
		System.out.println("Sever login!!");
		return con;
	}
%>

<%
	List<StudentVO> studentList = new ArrayList();
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String sql = "SELECT a_number, a_name, a_age FROM a_student";
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
		
		while(rs.next()) {
			int a_number = rs.getInt("a_number");
			String a_name = rs.getNString("a_name");
			int a_age = rs.getInt("a_age");
			
			StudentVO vo = new StudentVO();
			vo.setA_number(a_number);
			vo.setA_name(a_name);
			vo.setA_age(a_age);
			
			studentList.add(vo);			
			
		}
		
	} catch(Exception e) {
		System.out.println("Sever Error!!");
		e.printStackTrace();
		
	} finally {
		if(rs != null) {try {rs.close();} catch(Exception e) {} }
		if(ps != null) {try {ps.close();} catch(Exception e) {} }
		if(con != null) {try {con.close();} catch(Exception e) {} }
	}
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학생 이름표</title>
<style>
	table { width: 300px; border:1px solid black; border-collapse: collapse;}
	td { border: 1px solid black; text-aligh: center;}
	tr { height: 60px;}
</style>
</head>
<body>
	<table>
		<tr>
			<th>순번</th>
			<th>이름</th>
			<th>나이</th>
				
			<% for(StudentVO vo : studentList) { %>
			<tr>
				<td><%=vo.getA_number() %></td>
				<td><%=vo.getA_name() %></td>
				<td><%=vo.getA_age() %></td>
			</tr>
			<% }%>		
	</table>	
</body>
</html>