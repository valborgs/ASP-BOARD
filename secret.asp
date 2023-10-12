<!-- #include file="include_header.asp"-->
<%

userid=userid 'include_header.asp에 있음
u_grade=u_grade 'include_header.asp에 있음

pw=request("pw")
idx=request("idx")
st=request("st")

If u_grade="3" Then
	response.redirect "detail.asp?idx="&idx
End If

Set DBHelper = new clsDBHelper
strSQL="select b_uid,b_pw from tblS45340ms_board where idx='"&idx&"' "
Set QtnRS = DBHelper.ExecSQLReturnRS(strSQL, Nothing, Nothing)
If Not QtnRS.Eof Then
	b_uid=QtnRS("b_uid")
	b_pw=QtnRS("b_pw")
End If
QtnRS.Close : Set QtnRS = Nothing
DBHelper.Dispose : Set DBHelper=Nothing

If b_uid<>"" and b_uid=userid Then
	response.redirect "detail.asp?idx="&idx
End If

If st="enter" Then
	
	If pw=b_pw Then
		response.redirect "detail.asp?idx="&idx
	Else
		response.write "<script>alert('비밀번호가 맞지 않습니다.'); window.location.href = 'secret.asp?idx="&idx&"';</script>"
	End If
	
End If
%>

<div class="container" align="center">
	<div class="col s12 m7" style="width:500px;padding:20px;">
    <div class="card horizontal">
      <div class="card-stacked">
        <div class="card-content">
        	<form method="post" action="secret.asp" id="frm" name="frm">
          <h2 class="header">비밀글 확인</h2>
          <br>
          <input type="hidden" id="idx" name="idx" value="<%=idx%>">
          <input type="hidden" id="st" name="st" value="enter">
          <div class="row">
          <div class="input-field col s4 offset-s4">
          <input type="password" id="pw" name="pw" maxlength="4" autocomplete="one-time-code">
          <label for="pw" id="pwl">비밀번호</label>
          </div>
          </div>
         </form>
        </div>
        <div class="card-action">
          <span class="btn" id="submitbtn">확인</span>
          <br><br>
          <a class="btn" href="index.asp">게시판으로 돌아가기</a>
        </div>
      </div>
    </div>
	</div>
</div>
<script type="text/javascript">
var subbtn=document.getElementById("submitbtn");
var pwl=document.getElementById("pwl");
pwl.style.paddingLeft='25px';
var pww=document.getElementById("pw");
pww.style.fontSize='36px';
pww.style.width='70px';
subbtn.onclick = function(){
	if(pww.value==""){
		alert("비밀번호를 입력해주십시오.");
		pww.focus();
		return;
	}
	//폼 submit
	document.getElementById("frm").submit();	
};
</script>
<!-- #include file="include_footer.asp"-->