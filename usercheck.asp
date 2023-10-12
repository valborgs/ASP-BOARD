<% @Language="VBScript" CODEPAGE="65001" %>
<!-- #include virtual="/sp2pub/DBHelper.asp"-->

<%
uid=request("uid")

if uid<>Session("tblS45340ms_usertbl_userid") then
	response.write "failed"
else
	response.write "success"
end if
%>