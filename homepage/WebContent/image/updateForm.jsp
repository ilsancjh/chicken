<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %> 
 <jsp:useBean id="dao" class="image.ImageDAO"/>
 <jsp:useBean id="dto" class="image.ImageDTO"/>

<%
int ino =Integer.parseInt(request.getParameter("ino"));
dto=dao.read(ino);

%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function incheck(){
	var f=document.frm;
	
	if(f.title.value==""){
		alert("제목을 입력하세요");
		f.title.focus();
		
		return ;
	}
	if(f.mname.value==""){
		alert("이름을 입력하세요");
		f.mname.focus();
		
		return ;
	}
	if(f.content.value==""){
		alert("내용을 입력하세요");
		f.content.focus();
		
		return ;
	}
	if(f.passwd.value==""){
		alert("비밀번호를 입력하세요");
		f.passwd.focus();
		
		return ;
	}
	f.submit();
}

</script>
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title"></DIV>
 
<FORM name='frm' 
      method='POST' 
      action='./updateProc.jsp'
      enctype="multipart/form-data"
      >
  <input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage") %>">
  <input type="hidden" name="word" value="<%=request.getParameter("word") %>">
  <input type="hidden" name="col" value="<%=request.getParameter("col") %>">
  <input type="hidden" name="ino" value="<%=ino %>">
  <input type="hidden" name="oldfile" value="<%=dto.getFname() %>">
      
      
  <TABLE>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" value="<%=dto.getTitle()%>"></TD>
    </TR>
    <TR>
      <TH>이름</TH>
      <TD><input type="text" name="mname" value="<%=dto.getMname()%>"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><textarea rows="10" cols="45" name="content"><%=dto.getContent() %></textarea></TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
    <TR>
      <TH>파일</TH>
      <TD>
      <input type="file" name="fname">
      (<%=Utility.checkNull(dto.getFname()) %>)
      </TD>
    </TR>
 
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='수정' onclick="incheck()">
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 