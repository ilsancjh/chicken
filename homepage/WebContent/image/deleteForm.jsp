<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="image.ImageDAO"/>

<%
int ino=Integer.parseInt(request.getParameter("ino")); 

%>

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function ilist() {
	var url="./list.jsp"
	location.href=url;
}
</script>
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<FORM name='frm' 
      method='POST' 
      action='./deleteProc.jsp'>
<input type="hidden" name="ino" value="<%=ino %>">
<input type="hidden" name="oldfile" value="<%=request.getParameter("oldfile") %>">
<input type="hidden" name="word" value="<%=request.getParameter("word") %>">
<input type="hidden" name="col" value="<%=request.getParameter("col") %>">
<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage") %>">
 <TABLE>
    <TR>
      <TH>패스워드</TH>
      <TD><input type="password" name="passwd" placeholder="비번을 입력하세요" required></TD>
    </TR>
  </TABLE>
  
   <DIV class='bottom'>
    <input type="submit" value="삭제">  
    <input type='button' value='목록' onclick="ilist()">
    <input type='button' value='뒤로가기' onclick="history.back()">
  </DIV>
</FORM>

 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 