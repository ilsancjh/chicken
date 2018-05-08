<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>

<jsp:useBean id="dao" class="memo.MemoDAO" />
<jsp:useBean id="dto" class="memo.MemoDTO" />
<jsp:setProperty property="*" name="dto"/>

<%
	boolean flag = dao.update(dto);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript">
function mlist() {
	var url='./list.jsp';
	url+="?col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	location.href=url;
}
</script>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 12px;
}

div {
	text-align: center;
	margin-top: 20px;
	margin-bottom: 20px;
}
</style>
</head>
<body>

	<div>
		<%
			if (flag) {
				out.print("메모를 수정하였습니다.");
			} else {
				out.print("메모수정을 실패했습니다.");
			}
		%>
		<br> 
		<input type="button" value="목록" onclick="mlist()">
	</div>

</body>
</html>
