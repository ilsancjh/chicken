<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp"%>

<jsp:useBean id="dao" class="memo.MemoDAO" />


<%
//검색관련 ---------------
String col=Utility.checkNull(request.getParameter("col"));
String word=Utility.checkNull(request.getParameter("word"));

if(col.equals("total")) {
	word="";
}
//페이징 관련--------------
int nowPage=1;
int recordPerPage=15;

if(request.getParameter("nowPage")!=null){
	nowPage=Integer.parseInt(request.getParameter("nowPage"));
}
int sno = ((nowPage-1)*recordPerPage)+1;
int eno = nowPage*recordPerPage;


Map map=new HashMap();
map.put("col", col);
map.put("word", word);
map.put("sno", sno);
map.put("eno", eno);

List<MemoDTO> list=dao.list(map);
//Iterator<MemoDTO> itr=list.iterator();


int totalRecord=dao.total(map);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 

<title></title> 
<style type="text/css">
.search{
width:100%;
text-align: center;
margin: 2px auto;
}
</style>
<!-- <link href="../css/style.css" rel="stylesheet"> -->

<script type="text/javascript">
function read(memono){
	//alert(memono);
	var url="read.jsp?memono="+memono;
	//url+= "?memono="+memono;
	
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
	url+="&nowPage=<%=nowPage%>";
	location.href=url;
}
function mcreate() {
	var url = "memoCreate.jsp";
	location.href = url;
}

function w3_open() {
    document.getElementById("mySidebar").style.width = "100%";
    document.getElementById("mySidebar").style.display = "block";
}

function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
}

</script>
</head> 
<body>
<jsp:include page="/menu/top.jsp"/>

<!-- 상단바 시작 -->
<div class="w3-opacity">
<span class="w3-button w3-xxlarge w3-white w3-right" onclick="w3_open()"><i class="fa fa-bars"></i></span>
</div>

<div class="container">
<h2><span class="glyphicon glyphicon-list">메모목록</span></h2>

<br>

<table class="table table-hover">
<thead>
<tr>
<th>번호</th>
<th>제목</th>
<th>날짜</th>
<th>조회수</th>
<th>grpno</th>
<th>indent</th>
<th>ansnum</th>
</tr>
</thead>
<!-- itr.hasNext()==false -->

<%if(list.size()==0){ %>
    <tbody>
	<tr>
	<td colspan="7">등록된 메모가 없습니다.</td>
	</tr>
	</tbody>
<%}else{
	//do{MemoDTO dto=itr.next();
	for(int i=0; i<list.size();i++){
		MemoDTO dto=list.get(i);
	%>
	<tbody>
	<tr>
	<td><%=dto.getMemono() %></td>
	<td>
	<%if(dto.getIndent()>0){
	for(int r=0; r<dto.getIndent(); r++){
		out.print("&nbsp;");
	    }
	    out.print("<img src='../images/14.png' width='25px'>");
	} %>
	<a href="javascript:read('<%=dto.getMemono() %>')"><%=dto.getTitle() %></a>
	<%
	if(Utility.compareDay(dto.getWdate().substring(0,10))){%>
	<img src="../images/new.gif">
	<%} %>
	
	</td>
	<td><%=dto.getWdate() %></td>
	<td><%=dto.getViewcnt() %></td>
	<td><%=dto.getGrpno() %></td>
	<td><%=dto.getIndent() %></td>
	<td><%=dto.getAnsnum() %></td>
	
	</tr>
	</tbody>
	<% }//for-end   //while(itr.hasNext());
	}//if-end
	%>
</table>


<div class="bottom">
<!-- <button type="button" onclick="location.href='../address/createForm.jsp'">등록</button> -->
<!-- <button type="button" onclick="mcreate()">새게시글</button> -->

<%=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word) %>  <!-- 여기서 페이징3 호출 -->

<div class="search">

<form action="./list.jsp" method="post">
<select name="col">
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
<button type="button" onclick="location.href='memoCreate.jsp'">등록</button>

</form>
</div>
</div>
</div>


<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 