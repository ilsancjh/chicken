<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 24px; 
} 
table,th,td{
margin:auto;
border:1px solid black;
padding: 30px;
border-spacing: 5px;
}
</style> 
</head> 
<body> 

<table>
<tr>
<th> </th>
<th> </th>
<th> </th>
<th> </th>
<th> </th>
<th rowspan='5' bgcolor='#AAFFAA'> 6% </th>
</tr>

<tr>
<th> </th>
<th> </th>
<th> </th>
<th> </th>
<th rowspan='4' bgcolor='#aaffaa'>5% </th>
</tr>

<tr>
<th> </th>
<th> </th>
<th rowspan='3' bgcolor='#aaffaa'> 3% </th>
<th> </th>
</tr>

<tr>
<th> </th>
<th rowspan='2' bgcolor='#aaffaa'> 2%</th>
<th rowspan='2' bgcolor='#aaffaa'> 4%</th>
</tr>

<tr>
<th rowspan='1' bgcolor='#aaffaa'> 1%</th>
</tr>
</table>

</body> 
</html> 