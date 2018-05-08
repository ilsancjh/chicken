<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %> 
<jsp:useBean id="dao" class="image.ImageDAO"/>

<%
//검색관련-----------------------------------------------
String col = Utility.checkNull(request.getParameter("col"));
String word = Utility.checkNull(request.getParameter("word"));

if(col.equals("total")) word="";



//검색관련 end-------------------------------------------
int nowPage =1; //현재 보고있는 페이지
if(request.getParameter("nowPage")!=null)
    nowPage=Integer.parseInt(request.getParameter("nowPage"));

int recordPerPage=5; //한페이지당 보여줄 레코드 갯수

int sno=((nowPage-1)*recordPerPage)+1;
int eno=nowPage*recordPerPage;
//-----------------------------------------------------


Map map=new HashMap();
map.put("col", col);
map.put("word",word);

map.put("sno",sno);
map.put("eno",eno);


List<ImageDTO> list=dao.list(map);

//전체 레코드 갯수 가져오기
int totalRecord=dao.total(map);

//페이징출력메소드 호출
String paging=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function fileDown(fname) {
	var url="<%=root%>/download";
	url+="?filename="+fname;
	url+="&dir=/image/storage";
	location.href=url;
}
function read(ino){
	var url="./read.jsp"
	url+="?ino="+ino; //js변수
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
	url+="&nowPage=<%=nowPage%>";
	location.href=url;
}
function w3_open() {
    document.getElementById("mySidebar").style.width = "100%";
    document.getElementById("mySidebar").style.display = "block";
}

function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
}
</script>
<style type="text/css">
.search{
width: 100%;
text-align: center;
}
</style>

<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp"/>

<!-- 상단바 시작 -->
<div class="w3-opacity">
<span class="w3-button w3-xxlarge w3-white w3-right" onclick="w3_open()"><i class="fa fa-bars"></i></span>
</div>
<!-- 상단바 끝 -->
 
<div class="container">
<h2><span class="glyphicon glyphicon-list"></span>이미지게시판</h2>



  <TABLE>
    <TR>
      <TH>No.</TH>
      <TH>제목</TH>
      <TH>이름</TH>
      <TH>내용</TH>
      <TH>날짜</TH>
      <TH>이미지</TH>
    </TR>
    
    
    
    <%if(list.size()==0){ %>
    
    <tr>
      <td colspan="6">
       등록된 게시글이 없습니다.
      </td>
    </tr>
    
    <%}else{ 
    for(int i=0; i<list.size(); i++){
    	ImageDTO dto=list.get(i);
    %>
    
    
    
    <!-- 번호주석 -->
    <tr>
    <td><%=dto.getIno() %></td>
    
    <!-- 타이틀 주석 -->
    <td>
    <a href="javascript:read('<%=dto.getIno() %>')"><%=dto.getTitle() %></a>
    <%
    if(Utility.compareDay(dto.getWdate().substring(0,10))){%>
    <img src="../images/new.gif">
    <%} %>
    </td>
    
    <!-- 닉네임 주석 -->
    <td><%=dto.getMname() %></td>
    
    <!-- 내용 주석 -->
    <td><%=dto.getContent() %></td>
    
    <!-- 날짜 주석 -->
    <td><%=dto.getWdate() %></td>
    
    <!-- 이미지 주석 -->
    <td>
    <a href="javascript:fileDown('<%=dto.getFname() %>')"><img src="<%=root %>/image/storage/<%=dto.getFname() %>" width="200px" height="210px" align="middle"></a>
    </td>
    
    </tr>
  
    <%}  //for-end
    } //if-end
    %>
  </TABLE>
  
  <br>
<DIV class="search" align="center">
<FORM method="POST"
      action="./list.jsp">
      
      <br>
      <select name="col">
      <option value="mname"
      <%if(col.equals("mname")) out.print("selected"); %>
      >이름</option>
      <option value="title"
      <%if(col.equals("title")) out.print("selected"); %>
      >제목</option>
      <option value="content"
      <%if(col.equals("content")) out.print("selected"); %>
      >내용</option>
      <option value="total"
      <%if(col.equals("total")) out.print("selected"); %>
      >전체</option>
      </select>
      
      
<input type="search" name="word" value="<%=word%>" required>
<button>검색</button>
<button type="button" onclick="location.href='./createForm.jsp'">등록</button>
</FORM>


<div class='bottom'>
	<%=paging %>
</div>
</div>
</div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 