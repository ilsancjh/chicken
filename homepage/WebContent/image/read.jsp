<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="image.ImageDAO"/>

<%

int ino = Integer.parseInt(request.getParameter("ino"));

ImageDTO dto = dao.read(ino);

String content = dto.getContent();
content = content.replaceAll("\r\n", "<br>");

%>

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
.curImg{
	margin-right:0;
	border-style:solid;
	border-width: 3px;
	border-color: red;
}
.td_padding{
	padding:5px 5px;
}

</style> 
<script type="text/javascript">
function iupdate(ino){
	var url="./updateForm.jsp";
	url+="?ino="+ino;
	url+="&col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	
	location.href=url;
}
function idel() {
	var url="./deleteForm.jsp"
	url+="?ino=<%=ino%>";
	url+="&oldfile=<%=dto.getFname()%>";
	url+="&col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	
	location.href=url;
}
function imglist(){
	var url="./list.jsp";
	url+="?col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	location.href=url;
}
function readGo(ino){
	var url = "./read.jsp";
	url +="?ino="+ino;
	url+="&col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	
	location.href=url;
}
function fileDown(fname) {
	var url="<%=root%>/download";
	url+="?filename="+fname;
	url+="&dir=/image/storage";
	location.href=url;
}

</script>
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">조회</DIV>
 
  <TABLE style="width: 50%">
    <TR>
       <TD colspan="2">
        <img src="./storage/<%=dto.getFname() %>" width="100%">
       </TD>
    </TR>
    
    <TR>
      <TH>제목</TH>
      <TD><%=dto.getTitle() %></TD>
    </TR>
    
    <TR>
      <TH>성명</TH>
      <TD><%=dto.getMname() %></TD>
    </TR>
    
    <TR>
      <TH>내용</TH>
      <TD><%=content %></TD>
      
    </TR>
    
    <TR>
      <TH>날짜</TH>
      <TD><%=dto.getWdate() %></TD>
    </TR>
    
    <TR>
      <TH>파일명</TH>
      <TD>
      <% if(dto.getFname()==null){
    	out.print("파일없음");
    	}else{
      %>
    	<a href="javascript:fileDown('<%=dto.getFname() %>')">
    	<%=dto.getFname() %>(<%=dto.getFsize()%>)</a>
     <%} %>
      </TD>
    </TR>
  </TABLE>
  
  <TABLE style="width: 50%">
  <TR>
  <%
  	List list = dao.imgRead(ino);
    String[] files = (String[])list.get(0);
    int[] noArr = (int[])list.get(1);
    for(int i=0;i<5;i++){
    	if(files[i]==null){  
  %>
  <td class="td_padding"><img src="./storage/default.jpg" width="100%"><td>
  <%
    	}else{
    		if(noArr[i]==ino){
  %> 	
  <td class="td_padding"><a href="javascript:readGo('<%=noArr[i]%>')">
  <img class="curImg" src="./storage/<%=files[i] %>" width="100%" border="0">
  </a></td>
  <%		
    		}else{
  %>
  <td class="td_padding"><a href="javascript:readGo('<%=noArr[i]%>')">
  <img src="./storage/<%=files[i] %>" width="100%" border="0">
  </a></td>
  			
  <%
    		}
    	 }   		
      }
  %>
  </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <button type="button" onclick="idel()">삭제</button>
    <input type='button' value='수정' onclick="iupdate('<%=dto.getIno() %>')">
    <input type='button' value='목록' onclick="imglist()">
  </DIV>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 