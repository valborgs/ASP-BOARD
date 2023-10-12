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
  
  If userid="" Then
  	response.redirect "login.asp?adm=adm"
  Else
  	Set DBHelper = new clsDBHelper
	  strSQL = "Select u_grade"
	  strSQL = strSQL &" From dbo.tblS45340ms_usertbl "
	  strSQL = strSQL &" Where u_id= '"& userid &"'"
	  Set QtnRS = DBHelper.ExecSQLReturnRS(strSQL, Nothing, Nothing)
	  If Not QtnRS.Eof Then
	   u_grade  = QtnRS("u_grade")
	  End If
	  QtnRS.Close : Set QtnRS = Nothing
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

  <title>Admin</title>
  <meta name="viewport" content="width=device-width,height=device-height,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<!-- Required styles for Material Web -->
  <link href="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<!-- Required Material Web JavaScript library -->
	<script src="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js"></script>
	<!-- Instantiate single textfield component rendered in the document -->
  <style>
  
  </style>
</head>

<body>
<div class="container" align="center">
<h2> 관리자 페이지 </h2>
<%
If u_grade="3" Then '3등급일때 admin 리스트 불러오기
  	Set DBHelper = new clsDBHelper
	  strSQL = "Select u_id, u_pw, u_grade"
	  strSQL = strSQL &" From dbo.tblS45340ms_usertbl "
	  Set QtnRS = DBHelper.ExecSQLReturnRS(strSQL, Nothing, Nothing)
%>
<div class="mdc-data-table">
  <div class="mdc-data-table__table-container">
    <table class="mdc-data-table__table" aria-label="Dessert calories">
      <thead>
        <tr class="mdc-data-table__header-row">
          <th class="mdc-data-table__header-cell mdc-data-table__header-cell--checkbox" role="columnheader" scope="col">
            <div class="mdc-checkbox mdc-data-table__header-row-checkbox mdc-checkbox--selected">
              <input type="checkbox" class="mdc-checkbox__native-control" aria-label="Toggle all rows"/>
              <div class="mdc-checkbox__background">
                <svg class="mdc-checkbox__checkmark" viewBox="0 0 24 24">
                  <path class="mdc-checkbox__checkmark-path" fill="none" d="M1.73,12.91 8.1,19.28 22.79,4.59" />
                </svg>
                <div class="mdc-checkbox__mixedmark"></div>
              </div>
              <div class="mdc-checkbox__ripple"></div>
            </div>
          </th>
          <th class="mdc-data-table__header-cell" role="columnheader" scope="col">아이디</th>
          <th class="mdc-data-table__header-cell" role="columnheader" scope="col">패스워드</th>
          <th class="mdc-data-table__header-cell" role="columnheader" scope="col">등급</th>
        </tr>
      </thead>
      <tbody class="mdc-data-table__content">
      
<%
	Do Until QtnRS.Eof
		
	u_id=QtnRS("u_id")
	u_pw=QtnRS("u_pw")
	u_grade=QtnRS("u_grade")
%>
        <tr data-row-id="u0" class="mdc-data-table__row">
          <td class="mdc-data-table__cell mdc-data-table__cell--checkbox">
            <div class="mdc-checkbox mdc-data-table__row-checkbox">
              <input type="checkbox" class="mdc-checkbox__native-control" aria-labelledby="u0"/>
              <div class="mdc-checkbox__background">
                <svg class="mdc-checkbox__checkmark" viewBox="0 0 24 24">
                  <path class="mdc-checkbox__checkmark-path" fill="none" d="M1.73,12.91 8.1,19.28 22.79,4.59" />
                </svg>
                <div class="mdc-checkbox__mixedmark"></div>
              </div>
              <div class="mdc-checkbox__ripple"></div>
            </div>
          </td>
          <th class="mdc-data-table__cell" scope="row" id="u0"><%=u_id%></th>
          <td class="mdc-data-table__cell"><%=u_pw%></td>
          <td class="mdc-data-table__cell"><%=u_grade%></td>
        </tr>
<%
	QtnRS.MoveNext
	Loop
%>

				<tr>
				<td class="mdc-data-table__cell" colspan="4">
					<button id="deletebtn" class="mdc-button mdc-button--raised">
						<span class="mdc-button__label">삭제</span>
					</button>
				</td>
				</tr>
				
				<tr>
				<td class="mdc-data-table__cell" colspan="4">
					<label class="mdc-text-field mdc-text-field--outlined">
					  <span class="mdc-notched-outline">
					    <span class="mdc-notched-outline__leading"></span>
					    <span class="mdc-notched-outline__notch">
					      <span class="mdc-floating-label" id="uid-label">ID</span>
					    </span>
					    <span class="mdc-notched-outline__trailing"></span>
					  </span>
					  <input type="text" name="u_id" class="mdc-text-field__input" aria-labelledby="uid-label">
					</label>
					<br>
					<label class="mdc-text-field mdc-text-field--outlined">
					  <span class="mdc-notched-outline">
					    <span class="mdc-notched-outline__leading"></span>
					    <span class="mdc-notched-outline__notch">
					      <span class="mdc-floating-label" id="upw-label">PW</span>
					    </span>
					    <span class="mdc-notched-outline__trailing"></span>
					  </span>
					  <input type="text" name="u_pw" class="mdc-text-field__input" aria-labelledby="upw-label">
					</label>
					<br>
					<button id="newbtn" class="mdc-button mdc-button--raised">
						<span class="mdc-button__label">신규등록</span>
					</button>
				</td>
				</tr>

      </tbody>
    </table>
  </div>
  <button class="mdc-button foo-button">
	  <div class="mdc-button__ripple"></div>
	  <span class="mdc-button__label">Button</span>
	</button>
</div>
<%
QtnRS.Close : Set QtnRS = Nothing
End If  '3등급일때 admin 리스트 불러오기 끝
%>


</div>

<script>
mdc.ripple.MDCRipple.attachTo(document.querySelector('.mdc-text-field'));

const textField = new MDCTextField(document.querySelector('.mdc-text-field'));
const dataTable = new MDCDataTable(document.querySelector('.mdc-data-table'));
</script>
</body>
</html>