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
	

	If userid<>"" Then
		Set DBHelper = new clsDBHelper
		strSQL3="select u_grade from tblS45340ms_usertbl where u_id='"&userid&"' "
	  Set QtnRS3 = DBHelper.ExecSQLReturnRS(strSQL3, Nothing, Nothing)
	  If Not QtnRS3.Eof Then
	  	u_grade = QtnRS3("u_grade")
	  End If
	  QtnRS3.Close : Set QtnRS3 = Nothing
	  DBHelper.Dispose : Set DBHelper=Nothing
	Else
		u_grade=""
	End If
	
	pnowpage=Split(request.servervariables("HTTP_url"),"/")
	nowpage=Replace(pnowpage(Ubound(pnowpage)),".asp","")
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
  <link type="text/css" rel="stylesheet" href="default.css"/>
  <link type="text/css" rel="stylesheet" href="materialize/css/materialize.min.css"  media="screen,projection"/>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  
  
	<style>
			html, body {
				margin: 0;
				height: 100%;
			}
	    * {margin: 0; padding: 0;}
	    #wrap {width: 100%; min-height: 100%; font-size: 16px; text-align: center; background-color: #ede9e8;}
	    #header-wrap {width: 100%; min-height:10%; background-color: #ede9e8; background-size: 100% auto;}
	    #content-wrap {width: 100%; min-height:90%; background-color: #ede9e8; background-size: 100% auto;}
	    
	    /* 자식이 height 값을 가지고 있으면 부모의 height 값은 없어도 된다.
	       width: 100%는 기본 값이기 때문에 없어도 된다.       
	    */
	    .container { height:100%; }
	    .header-container {width: 1000px; height:100%; line-height: 100px; margin: 0 auto; background-color: #3e2723; background-size: 100% auto;}
	    .content-container {width: 1000px; height:100%; text-align: center; margin: 0 auto; background-color: white; background-size: 100% auto;}
	    
	    .frmwrapper { height: 100%; text-align: center; }
	    
	    #frm { height: 100%; text-align: center;h }
	    #smart_editor2 { text-align: center; }
	    .normaltable { width: 100%; }
	    .normaltable td { text-align: left; padding: 15px; vertical-align: middle; }
	    .normaltable th { text-align: left; padding: 15px;4 vertical-align: middle; font-weight:bold; }
	    .rply { font-size:0.8em; color: red; font-weight: bold; }
	    .rply.cnt { color: red; }
	    a { color: black }
	    a:hover { text-decoration: underline; }
	</style>
</head>

<body>
    <div id="wrap">
        <div id="header-wrap">
        	<div class="container">
            <div class="header-container">
            <nav>
    					<div class="nav-content">
							<ul class="left">
							<li><a href="index.asp"><b>BOARD</b></a></li>
							</ul>
							<ul class="right">
							<% If userid<>"" Then %><li><b>ID : <span id="userid"><%=userid%></span></b></li><li><a href="login.asp?st=out">LOGOUT</a></li><% Else %><li><span id="userid"></span></li><li><a href="login.asp">LOGIN</a></li><% End If %>
							</ul>
							</div>
							</nav>
            </div>
         </div>
        </div>
        <!--div id="banner-wrap">
            <div class="banner-container">banner</div>
        </div-->
        <div id="content-wrap">
        	<div class="container">
            <div class="content-container">