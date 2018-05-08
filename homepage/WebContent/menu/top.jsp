<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<%
	String id = (String) session.getAttribute("id");
	String grade = (String) session.getAttribute("grade");
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
body,h1 {font-family: "Montserrat", sans-serif}
img {margin-bottom: -7px}
.w3-row-padding img {margin-bottom: 12px}
</style>

<!-- ul#menu li{
display : inline;
}
ul#menu li a{

color:black;
pading : 10px 20px;
text-decoration:none;
border-radius:4px 4px 0 0;

}
ul#menu li a:hover{
background-color: orange;

}

.table {
	width: 100%;
}

.table, .td {
	font-family: cursive;
	border-style: none;
	text-align: center;
	margin: auto;
}
 -->

<!-- Latest compiled and minified CSS -->
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->

<!-- jQuery library -->
<!-- <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<!-- Latest compiled JavaScript -->
<!-- <script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->



</head>
<body>

	<!-- 상단 메뉴 -->
	<div>
		<table class="table">
			<tr>
				<td class="td">
<!-- Sidebar -->
<nav class="w3-sidebar w3-black w3-animate-top w3-xxlarge" style="display:none;padding-top:150px" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-button w3-black w3-xxlarge w3-padding w3-display-topright" style="padding:6px 24px">
    <i class="fa fa-remove"></i>
  </a>
  <div class="w3-bar-block w3-center">
    <a href="<%=root %>/index.jsp" class="w3-bar-item w3-button w3-text-grey w3-hover-black">Home</a>
    <!-- <a href="#" class="w3-bar-item w3-button w3-text-grey w3-hover-black">게시판</a> -->
    <a href="<%=root %>/memo/list.jsp" class="w3-bar-item w3-button w3-text-grey w3-hover-black">Memo</a>
    <a href="<%=root %>/image/list.jsp" class="w3-bar-item w3-button w3-text-grey w3-hover-black">Image</a>
  </div>
</nav>

<%-- <nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="<%=root%>"> <span class="glyphicon glyphicon-home"></span></a>
      
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="<%=root%>">집으로</a></li>
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">커뮤니티 <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="<%=root %>/bbs/list.jsp">게시판</a></li>
          <li><a href="<%=root %>/memov3/list.jsp">메모</a></li>
          <li><a href="<%=root %>/guest/list.jsp">방명록</a></li>
        </ul>
      </li>
      <%if(id!=null){ %>
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">회원공간 <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="<%=root %>/member/deleteForm.jsp">회원탈퇴</a></li>
        </ul>
      </li>
    <%} %>
    </ul>
    
    <%if(id==null){ %>    
    <ul class="nav navbar-nav navbar-right">
      <li><a href="<%=root %>/member/agreement.jsp"><span class="glyphicon glyphicon-user"></span> 회원가입</a></li>
      <li><a href="<%=root %>/member/loginForm.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
    </ul>
   
    <%}else{ %>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="<%=root %>/member/read.jsp"><span class="glyphicon glyphicon-user"></span>내정보</a></li>
      <li><a href="<%=root %>/member/logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
   
    <%} %>    
    <%if(id!=null && grade.equals("A")){ %>
      <li><a href="<%=root %>/admin/list.jsp"><span class="glyphicon glyphicon-lock"></span> 회원목록</a></li>
      <%} %>
      </ul>
  </div>
</nav> --%>
					
<%-- <ul id="menu">
     <li><a href="<%=root %>/index.jsp">[홈]</a></li>
     <%if(id==null){ %>    
     <li><a href="<%=root %>/member/createForm.jsp">[회원가입]</a></li>
     <li><a href="<%=root %>/member/loginForm.jsp">[로그인]</a></li>    
     <%}else{ %>
     <li><a href="<%=root %>/member/read.jsp">[정보확인]</a></li>
     <li><a href="<%=root %>/member/logout.jsp">[로그아웃]</a></li>
     <li><a href="<%=root %>/member/list.jsp">[회원목록]</a></li>
     <li><a href="<%=root %>/member/deleteForm.jsp">[회원탈퇴]</a></li>
     <%} %>
     <li><a href="<%=root %>/bbs/list.jsp">[게시판]</a></li>
     <li><a href="<%=root %>/memov3/list.jsp">[메모]</a></li>
     <li><a href="<%=root %>/guest/list.jsp">[방명록]</a></li>

    </ul> --%>
    </td>
			</tr>

		</table>
	</div>
	<!-- 상단 메뉴 끝 -->

	<!-- 내용 시작 -->
	<div style="width: 100%; padding-top: 10px;">
</body>
</html>
