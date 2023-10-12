<%@Language="VBScript" CODEPAGE="65001" %>
<%
  Response.CharSet="utf-8"
  Session.codepage="65001"
  Response.codepage="65001"
  Response.ContentType="text/html;charset=utf-8"
%>
<!-- #include virtual="/sp2pub/DBHelper.asp"-->
<%
  userid=Session("tblS45340ms_usertbl_userid")
  st=Request("st")
  adm=Request("adm")
  
  If st="out" Then
  	If userid<>"" Then
	  	Set DBHelper = new clsDBHelper
	  	strSQL2 = "delete tblS45340ms_loginsession where s_uid='"&userid&"' "
	  	DBHelper.ExecSQL strSQL2, Nothing, Nothing
	  	Session.Contents.Remove("tblS45340ms_usertbl_userid")
	  	DBHelper.Dispose : Set DBHelper=Nothing
  	End If
  Else
  	If userid<>"" Then
  		response.redirect "index.asp"
  	End If
  End If
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="Expires" content="Mon, 06 Jan 1990 00:00:01 GMT">
  <meta http-equiv="Expires" content="-1">
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv="Cache-Control" content="no-cache">
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />

  <title>Board</title>
  <meta name="viewport" content="width=device-width,height=device-height,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
  <link type="text/css" rel="stylesheet" href="materialize/css/materialize.min.css"  media="screen,projection"/>
  
</head>

<body>
<div class="container" align="center">
	<div class="col s12 m7" style="width:500px;">
    <div class="card horizontal">
      <div class="card-stacked">
        <div class="card-content">
        	<form action="in.asp" id="frm" name="frm">
        	<input type="hidden" name="adm" id="adm" value="<%=adm%>">
        	<% If st="out" Then %>
        		<span style="color:red;font-weight:bold;">로그아웃되었습니다.</span>
        	<% End If %>
          <h2 class="header">로그인</h2>
          <div class="input-field">
	          <input type="text" id="id" name="id">
	          <label for="id">아이디</label>
          </div>
          <div class="input-field">
          <input type="password" id="pw" name="pw">
          <label for="pw">패스워드</label>
          <br>로그인 하지 않아도 게시판 이용이 가능합니다.
          </div>
         </form>
        </div>
        <div class="card-action">
          <span class="btn" id="submit">로그인</span>
          <br><br>
          <a class="btn" href="index.asp">게시판으로 돌아가기</a>
        </div>
      </div>
    </div>
	</div>
</div>
<script type="text/javascript" src="./materialize/js/materialize.min.js" charset="utf-8"></script>
<script type="text/javascript">
	
  document.addEventListener('DOMContentLoaded', function() {
  	document.getElementById("id").value=""
		document.getElementById("pw").value=""
    M.updateTextFields();
    var subbtn=document.getElementById("submit");
		subbtn.onclick = function(){
	    //폼 submit
	    id=document.getElementById("id").value
			pw=document.getElementById("pw").value
			if(id==""){
				document.getElementById("id").focus();
				alert("아이디를 입력해주십시오.");
				return;
			}else if(pw==""){
				document.getElementById("pw").focus();
				alert("패스워드를 입력해주십시오.");
				return;
			}
	    document.getElementById("frm").submit();
		};
  });
</script>
</body>
</html>