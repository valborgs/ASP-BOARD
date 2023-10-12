<% @Language="VBScript" CODEPAGE="65001" %>
<!-- #include virtual="/sp2pub/DBHelper.asp"-->

<%
function checkword(checkvalue)
	'checkvalue = replace(checkvalue, "&", "&#38;")
  'checkvalue = replace(checkvalue, """", "&#34;")
  'checkvalue = replace(checkvalue, "'", "&#39;")
	'checkvalue = replace(checkvalue, ",", "&#44;")
	'checkvalue = replace(checkvalue, ".", "&#46;")
	'checkvalue = replace(checkvalue, ":", "&#58;")
	'checkvalue = replace(checkvalue, ";", "&#59;")
  'checkvalue = replace(checkvalue, chr(13),"<br>"+chr(13))
  checkword = checkvalue
end function

  Response.CharSet="utf-8"
  Session.codepage="65001"
  Response.codepage="65001"
  Response.ContentType="text/html;charset=utf-8"
  
  st=request("st")
  
  Set DBHelper = new clsDBHelper
  
  If st="board" Then '게시글 업로드
		b_title=request("b_title")
		b_content=request("b_content")
		b_author=request("b_author")
		b_uid=request("b_uid")
		
		if b_uid<>Session("tblS45340ms_usertbl_userid") then
			response.redirect "index.asp"
		end if
		
		b_pw=request("b_pw")
		b_grade=request("b_grade")
		b_secret=request("b_secret")
  	strSQL="Insert into tblS45340ms_board(b_title,b_content,b_author,b_uid,b_pw,b_cdate,b_grade,b_secret) OUTPUT INSERTED.idx values('"&b_title&"','"&b_content&"','"&b_author&"','"&b_uid&"','"&b_pw&"',getdate(),'"&b_grade&"','"&b_secret&"') "
  	Set QtnRS = DBHelper.ExecSQLReturnRS(strSQL, Nothing, Nothing)
  	idx=QtnRS("idx")
  	QtnRS.Close : Set QtnRS = Nothing
  	redirectpage="detail.asp?idx="&idx
  	
  Elseif st="boardup" Then '게시글 수정
  	idx=request("idx")
		b_title=request("b_title")
		b_content=request("b_content")
		b_author=request("b_author")
		b_uid=request("b_uid")
		b_pw=request("b_pw")
		b_grade=request("b_grade")
		b_secret=request("b_secret")
		
		if b_uid<>Session("tblS45340ms_usertbl_userid") then
			response.redirect "index.asp"
		end if
		
  	strSQL="update tblS45340ms_board set b_title='"&b_title&"',b_content='"&b_content&"',b_author='"&b_author&"',b_uid='"&b_uid&"',b_pw='"&b_pw&"',b_grade='"&b_grade&"',b_secret='"&b_secret&"',b_mdate=getdate() where idx='"&idx&"' "
  	DBHelper.ExecSQL strSQL, Nothing, Nothing
  	
  	redirectpage="detail.asp?idx="&idx
  	
  	
  Elseif st="boarddel" Then
  	b_idx=request("b_idx")
  	b_uid=request("b_uid")
  	
  	if b_uid<>Session("tblS45340ms_usertbl_userid") and Session("tblS45340ms_usertbl_userid")<>"admin" then
			response.redirect "index.asp"
		end if
  	
  	response.write b_idx&"<br>"
  	response.write b_uid
		strSQL="update tblS45340ms_board set b_removed='rmv' where idx='"&b_idx&"' and b_uid='"&b_uid&"' "
  	DBHelper.ExecSQL strSQL, Nothing, Nothing
  	
		redirectpage="index.asp"
  	
  	
  	
  Elseif st="reply" Then
  	r_uid=request("r_uid")
  	r_content=checkword(request("r_content"))
  	r_bidx=request("r_bidx")
  	
		if r_uid<>Session("tblS45340ms_usertbl_userid") then
			response.redirect "index.asp"
		end if
  	
  	strSQL="Insert into tblS45340ms_reply(r_content,r_author,r_uid,r_cdate,r_bidx) OUTPUT INSERTED.idx values('"&r_content&"','"&r_uid&"','"&r_uid&"',getdate(),'"&r_bidx&"') "
  	Set QtnRS = DBHelper.ExecSQLReturnRS(strSQL, Nothing, Nothing)
  	idx=QtnRS("idx")
  	QtnRS.Close : Set QtnRS = Nothing
  	
  	redirectpage="detail.asp?idx="&r_bidx
  	
  Elseif st="delrply" Then
  	r_idx=request("r_idx")
  	r_uid=request("r_uid")
  	r_bidx=request("r_bidx")
  	
  	if r_uid<>Session("tblS45340ms_usertbl_userid") then
			response.redirect "index.asp"
		end if
  	
		strSQL="update tblS45340ms_reply set r_removed='rmv' where idx='"&r_idx&"' and r_bidx='"&r_bidx&"' "
  	DBHelper.ExecSQL strSQL, Nothing, Nothing
  	
		redirectpage="detail.asp?idx="&r_bidx
  	
  End If
  
  DBHelper.Dispose : Set DBHelper=Nothing
  
  response.redirect redirectpage
%>