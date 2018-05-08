<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="memo.*" %>
<%@ page import="image.*" %>

<%@ page import="java.util.*" %> 
<%@ page import="utility.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>

<%  request.setCharacterEncoding("utf-8");
    String root = request.getContextPath();
  
    String tempDir="/image/temp"; //메모리 임시폴더 상주
    String upDir="/image/storage"; //실제 원하는 전송파일들 변환
    
    tempDir=application.getRealPath(tempDir);
    upDir=application.getRealPath(upDir);
   
%> 