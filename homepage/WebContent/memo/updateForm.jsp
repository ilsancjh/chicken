<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="memo.MemoDAO" />


<%
 int memono=Integer.parseInt(request.getParameter("memono")); 
 
 MemoDTO dto=dao.read(memono);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link href="../css/style.css" rel="stylesheet" />

<script type="text/javascript">

function incheck() {
	var f=document.frm;
	
	if (f.title.value == "") {
		alert("제목을 입력하세요");
		f.title.focus();
		return ;
	}
	if (f.content.value == "") {
		alert("내용을 입력하세요.");
		f.content.focus();
		return ;
	}
	f.submit();

}

	function mlist() {
		var url = "list.jsp";
		location.href = url;
	}
</script>
</head>
<body>
<jsp:include page="/menu/top.jsp"/>
<div class="title"></div>

	<form name="frm" action="updateProc.jsp" method="post">
		<!-- 폼 직접호출하면 안된다 -->
		<input type="hidden" name="memono" value="<%=dto.getMemono()%>">
		 <input type="hidden" name="word" value="<%=request.getParameter("word") %>">
          <input type="hidden" name="col" value="<%=request.getParameter("col") %>">

		<table>

			<tr>
				<th>제목</th>
				<td><input type="text" name="title" size="30" value="<%=dto.getTitle()%>"></td>
			</tr>

			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="30" name="content"><%=dto.getContent()%></textarea></td>
			</tr>

		</table>

		<div class="bottom">
			<input type="button" onclick="incheck()" value="전송">
			<input type="button" onclick="mlist()" value="목록">
		</div>
	</form>
<jsp:include page="/menu/bottom.jsp"/>
</body>
</html>
