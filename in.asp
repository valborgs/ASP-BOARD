<%@Language="VBScript" CODEPAGE="65001" %>
<%
  Response.CharSet="utf-8"
  Session.codepage="65001"
  Response.codepage="65001"
  Response.ContentType="text/html;charset=utf-8"
  
  id=request("id")
  pw=request("pw")
  adm=request("adm")
  
%>
<!-- #include virtual="/sp2pub/DBHelper.asp"-->

<%
 	Set DBHelper = new clsDBHelper
  
  strSQL = "Select u_id,u_pw"
  strSQL = strSQL &" From dbo.tblS45340ms_usertbl "
  strSQL = strSQL &" Where u_id= '"& id &"'"
  Set QtnRS = DBHelper.ExecSQLReturnRS(strSQL, Nothing, Nothing)
  If Not QtnRS.Eof Then
   uid  = QtnRS("u_id")
   upw  = QtnRS("u_pw")
  End If
  QtnRS.Close : Set QtnRS = Nothing
  
  loginresult=""
  
  If id=uid Then
  	If pw=upw Then
			loginresult="success"
  	Else
  		loginresult="pw"
  	End If
  Else
  	loginresult="id"
  End If
  
  strSQL = "Select s_uid,s_sid"
  strSQL = strSQL &" From dbo.tblS45340ms_loginsession "
  strSQL = strSQL &" Where s_sid= '"& Session.SessionID &"'"
  Set QtnRS = DBHelper.ExecSQLReturnRS(strSQL, Nothing, Nothing)
  If Not QtnRS.Eof Then
		QtnRS.Close : Set QtnRS = Nothing
		strSQL2 = "update tblS45340ms_loginsession set s_uid='"&id&"', s_time=getdate() where s_sid='"&Session.SessionID&"' "
		DBHelper.ExecSQL strSQL2, Nothing, Nothing
  Else
  	QtnRS.Close : Set QtnRS = Nothing
  	strSQL2 = "Insert tblS45340ms_loginsession(s_uid,s_sid,s_time) values('"&id&"','"&Session.SessionID&"',getdate()) "
  	DBHelper.ExecSQL strSQL2, Nothing, Nothing
  End If
  
  If loginresult="success" Then
  	Session("tblS45340ms_usertbl_userid")=id
  	Session.Timeout=1440
  	response.write "로그인 성공"
  	If adm="adm" Then
  		response.redirect "admin.asp"
  	Else
  		response.redirect "index.asp"
  	End If
  ElseIf loginresult="id" Then
  	response.write "없는 아이디입니다."
  ElseIf loginresult="pw" Then
  	response.write "비밀번호가 맞지 않습니다."
  End If
  
%>