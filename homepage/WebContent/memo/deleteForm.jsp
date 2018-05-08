<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); %> 
<jsp:useBean id="dao" class="memo.MemoDAO" />

<%
int memono=Integer.parseInt(request.getParameter("memono"));

boolean flag=dao.checkRefnum(memono);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="stylesheet">

<script type="text/javascript">
	function mlist() {
		var url = "list.jsp";
		location.href = url;
	}
</script>
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div class="title"></div>

<%if(flag){ %>
<div class="content">
상위 게시글이므로 삭제할 수 없습니다.
<br><br>
<button type="button" onclick="mlist()">목록</button>
<%}else{ %>
<form method="post" action="deleteProc.jsp">
<input type="hidden" name="memono" value="<%=memono%>">
 <input type="hidden" name="word" value="<%=request.getParameter("word") %>">
  <input type="hidden" name="col" value="<%=request.getParameter("col") %>">

삭제하시겠습니까?<br>
왜죠?<br>

<br><br>


<button type="submit" >삭제</button>
<button type="button" onclick="mlist()">목록</button>
</form>

</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 
<%}%>