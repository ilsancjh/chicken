<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="image.ImageDAO" />
<jsp:useBean id="dto" class="image.ImageDTO" />

<%
UploadSave upload=new UploadSave(request,-1,-1,tempDir);

dto.setMname(UploadSave.encode(upload.getParameter("mname")));
dto.setTitle(UploadSave.encode(upload.getParameter("title")));
dto.setContent(UploadSave.encode(upload.getParameter("content")));
dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));

FileItem fileitem =upload.getFileItem("fname");
int size=(int)fileitem.getSize();

String fname=null;

if(size>0){
	fname=UploadSave.saveFile(fileitem, upDir);
}

dto.setFsize(size);
dto.setFname(fname);

boolean flag = dao.create(dto);


%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function ilist() {
	var url="./list.jsp";
	location.href=url;
}

</script>

<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="content">

	<%
	if(flag){
		out.print("게시글 등록 완료");
	}else{
		out.print("글 등록에 실패하였습니다.");
	}
	
	%>
</DIV>
 

  
<DIV class='bottom'>
	<input type='button' value='목록' onclick="ilist()">
</DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 