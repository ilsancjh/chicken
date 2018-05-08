<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %> 
 <jsp:useBean id="dao" class="image.ImageDAO"/>
 <jsp:useBean id="dto" class="image.ImageDTO"/>
 
<%
UploadSave upload=new UploadSave(request,-1,-1,tempDir);

dto.setMname(UploadSave.encode(upload.getParameter("mname")));
dto.setTitle(UploadSave.encode(upload.getParameter("title")));
dto.setContent(UploadSave.encode(upload.getParameter("content")));
dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));

dto.setIno(Integer.parseInt(upload.getParameter("ino")));

String nowPage=upload.getParameter("nowPage");
String col=upload.getParameter("col");
String word=UploadSave.encode(upload.getParameter("word"));
String oldfile=UploadSave.encode(upload.getParameter("oldfile"));

FileItem fileitem =upload.getFileItem("fname");
int size=(int)fileitem.getSize();

String fname=null;

if(size>0){
	UploadSave.deleteFile(upDir, oldfile);
	fname=UploadSave.saveFile(fileitem, upDir);
}

dto.setFsize(size);
dto.setFname(fname);


Map map = new HashMap();
map.put("passwd", dto.getPasswd());
map.put("ino", dto.getIno());

boolean pflag = dao.passCheck(map);
boolean flag = false;
if (pflag) {
	flag = dao.update(dto);
}
 
 
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function imglist() {
	var url='./list.jsp';
	url+="?col=<%=col%>";
	url+="&word=<%=word%>";
	url+="&nowPage=<%=nowPage%>";		
	
	location.href=url;
}

</script>

<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">수정확인</DIV>
 
<div class="content">
		<%
			if (pflag == false) {
				out.print("잘못된 비밀번호 입니다");
				out.print("<button type='button' onclick='history.back()'>다시</button>");
			} else if (flag) {
				out.print("글 수정을 했습니다.");
			} else {
				out.print("글 수정을 실패 했습니다.");
			}
		%>
</div>
  
  <DIV class='bottom'>
		<input type='button' value='목록' onclick="imglist()">
</DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 