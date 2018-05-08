<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="image.ImageDAO" />

<% 
int ino=Integer.parseInt(request.getParameter("ino")); 
String passwd=request.getParameter("passwd");
String oldfile=request.getParameter("oldfile");

Map map=new HashMap();
map.put("ino", ino);
map.put("passwd", passwd);

boolean pflag=dao.passCheck(map);

boolean flag=false;
if(pflag){
	flag=dao.delete(ino);
}
if(flag){
	UploadSave.deleteFile(upDir, oldfile);
}

%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function ilist() {
	var url="./list.jsp";
	url+="?col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	
	location.href=url;
}

</script>

<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
  
  <div class="content">
 <%

  if (pflag == false) {
		out.print("잘못된 비밀번호 입니다");
		out.print("<br><br><button type='button' onclick='history.back()'>다시시도</button>");
  }else if(flag){
	  out.print("게시글 삭제하였습니다.");
	  out.print("<br><br><button type='button' onclick='ilist()'>목록</button>");
  }else{
	  out.print("게시글 삭제에 실패하였습니다.");
  }
  
 %>
 </div>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 