<!-- #include file="include_header.asp"-->

<div class="frmwrapper">
	<form id="frm" name="frm" action="data.asp" method="post">
		<input type="hidden" name="b_uid" id="b_uid" class="hidden" value="<%=userid%>">
		<input type="hidden" name="b_grade" id="b_grade" class="hidden" value="<%=u_grade%>">
		<input type="hidden" name="st" id="st" class="hidden" value="board">
		<table class="normaltable">
			<tr>
				<td>
					<div class="row">
					<div class="input-field col s6">
					<input type="text" name="b_title" id="b_title" class="validate" maxlength="64">
					<label class="active" for="b_title">제목 입력</label>
					</div>
					<div class="input-field col s6">
					<label>
					<input type="checkbox" name="b_secret" id="b_secret" class="filled-in">
					<span>비밀 글 체크</span>
					</label>
					</div>
					</div>
					<div class="row">
					<div class="input-field col s2">
					<input type="text" name="b_author" id="b_author" class="validate" maxlength="64">
					<label class="active" for="b_author">작성자 입력</label>
					</div>
					</div>
					<div class="row">
					<div class="input-field col s12">
					<label class="active" for="b_content">본문 입력</label><br>
					<textarea name="b_content" id="b_content" rows="10" cols="100" style="width:100%; max-width:400px;">에디터에 기본으로 삽입할 글(수정 모드)이 없다면 이 value 값을 지정하지 않으시면 됩니다.</textarea>
					</div>
					</div>
					<div class="row">
					<div class="input-field col s2 right">
					<input type="password" name="b_pw" id="b_pw" class="validate" maxlength="4" style="width:85px;">
					<label class="active" for="b_pw">글 비밀번호</label>
					</div>
					</div>
				</td>
			</tr>
			<tr>
				<td style="text-align:right;">
					<input type="button" class="btn" id="submitbtn" value="서버전송" />
				</td>
			</tr>
		</table>
	</form>
</div>

<!-- Page specific script -->
<script type="text/javascript" src="./se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
<%

st=request("st")
If st="" Then st="w" End If
	
If st="m" Then
		idx=request("idx")
		Set DBHelper = new clsDBHelper
	  dbname = "tblS45340ms_board"
	  strSQL="select * from tblS45340ms_board where idx='"&idx&"' "
	  Set QtnRS = DBHelper.ExecSQLReturnRS(strSQL, Nothing, Nothing)
	  If Not QtnRS.Eof Then
	  	b_title=QtnRS("b_title")
	  	b_content=QtnRS("b_content")
	  	b_secret=QtnRS("b_secret")
	 	End If
	 	QtnRS.Close : Set QtnRS = Nothing
	 	DBHelper.Dispose : Set DBHelper=Nothing
End If
%>
<% If userid <>"" Then %>
document.getElementById("b_author").value="<%=userid%>";
document.getElementById("b_author").readOnly=true;
<% End If %>


  document.addEventListener('DOMContentLoaded', function() {
  	M.updateTextFields();
  });


	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "b_content",
	 sSkinURI: "./se2/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});


	var subbtn=document.getElementById("submitbtn");
  //전송버튼 클릭이벤트
	subbtn.onclick = async function(){
		
		//id가 smarteditor인 textarea에 에디터에서 대입
		oEditors.getById["b_content"].exec("UPDATE_CONTENTS_FIELD", []);
		// 이부분에 에디터 validation 검증
		
		if(document.getElementById("b_title").value==""){
    	alert("제목을 입력해주세요.");
    	document.getElementById("b_title").focus();
    	return;
    }
    
    if(document.getElementById("b_author").value==""){
    	alert("작성자명을 입력해주세요.");
    	document.getElementById("b_author").focus();
    	return;
    }
    
    if(document.getElementById("b_content").value==""){
    	alert("본문을 입력해주세요.");
    	document.getElementById("b_content").focus();
    	return;
    }
    
    if(document.getElementById("b_pw").value==""){
    	alert("글 비밀번호를 설정해주세요.");
    	document.getElementById("b_pw").focus();
    	return;
    }else{
    	
    	if(document.getElementById("b_pw").value.length<4){
    		alert("비밀번호는 4자리의 숫자를 입력해주세요.");
    		document.getElementById("b_pw").focus();
    		return;
    	}
    	if(isNaN(Number(document.getElementById("b_pw").value))==true){
    		alert("비밀번호는 4자리의 숫자를 입력해주세요.");
    		document.getElementById("b_pw").focus();
    		return;
    	}
    	
    }
    
    
		let resultt = await usercheck("<%=userid%>");
		
  	if(resultt=="통신 성공"){
			if(window.confirm("정말 등록하시겠습니까?")){
				//폼 submit
	    	document.getElementById("frm").submit();
			}else{
				console.log("등록취소");
			}		
		};
    
	};
	
<% If st="m" Then %>
document.addEventListener('DOMContentLoaded', function() {
	document.getElementById("frm").action="data.asp?idx=<%=idx%>"
	document.getElementById("st").value="boardup"
	document.getElementById("b_title").value="<%=b_title%>"
<% If b_secret="on" Then %>
document.getElementById("b_secret").checked=true
<% End If %>
	document.getElementById("b_content").value="<%=b_content%>"
	document.getElementsByClassName("se2_inputarea")[0].innerHTML="<%=b_content%>";
});
<% End If %>
</script>
<!-- #include file="include_footer.asp"-->