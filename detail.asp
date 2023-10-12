<!-- #include file="include_header.asp"-->
<%

userid=userid 'include_header.asp에 있음
u_grade=u_grade 'include_header.asp에 있음

  Set DBHelper = new clsDBHelper
  
  dbname = "tblS45340ms_board"
  
 idx=request("idx")
  
  strSQL="select * from tblS45340ms_board where idx='"&idx&"' "
  Set QtnRS = DBHelper.ExecSQLReturnRS(strSQL, Nothing, Nothing)
  If Not QtnRS.Eof Then
  b_uid=QtnRS("b_uid")
  b_author=QtnRS("b_author")
  b_title=QtnRS("b_title")
  b_content=QtnRS("b_content")
  b_cdate=QtnRS("b_cdate")
  b_mdate=QtnRS("b_mdate")
 	End If
  QtnRS.Close : Set QtnRS = Nothing
%>

<div class="frmwrapper">
	<table class="normaltable">
		<thead>
			<tr><th colspan="3"><h2><%=b_title%></h2></th></tr>
			<tr style="font-size:0.9em"><th>작성자 <%=b_author%></th><th></th><th style="text-align:right;">
				<% If (userid<>"" AND userid=b_uid) or u_grade="3" Then %>
				<input type='button' class='btn red' id='delpostbtn' value="글 삭제" data-b_idx="<%=idx%>" data-b_uid="<%=b_uid%>" />
				<% End If %>
				<% If (userid<>"" AND userid=b_uid) Then %>
				<input type='button' class='btn red' id='modpostbtn' value="글 수정" data-b_idx="<%=idx%>" data-b_uid="<%=b_uid%>" />
				<% End If %>
				</th>
			</tr>
		</thead>
		<tbody>
			<tr><td colspan="3" style="height:250px;">본문<br><%=b_content%></td></tr>
			<tr><td></td><td colspan="2" style="text-align:right;">작성일 : <%=b_cdate%>　　<% If b_mdate<>"" Then %>수정일 : <%=b_mdate%><% End If %></td></tr>
		</tbody>
	</table>
	<br>
<%
	
  strSQL="select idx, r_content, r_author, r_uid, r_cdate, r_mdate from tblS45340ms_reply where r_bidx='"&idx&"' and r_removed is null or r_removed<>'rmv' "
  Set QtnRS = DBHelper.ExecSQLReturnRS(strSQL, Nothing, Nothing)
  
  If QtnRS.Eof Then
%>
	<table class="normaltable" id="replylist">
		<tbody>
			<tr><td><b>댓글이 없습니다.</b></td></tr>
		</tbody>
	</table>
<% Else %>
	<table class="normaltable" id="replylist">
		<tbody>
			<tr><td style="width:15%;"><b>댓글작성자</b></td><td style="width:63%;"><b>댓글내용</b></td><td style="width:12%;"><b>작성일</b></td><% If userid<>"" Then %><td style="width:10%;"><b>삭제버튼</b></td><% End If %></tr>
			<%
				Do Until QtnRS.Eof
					r_idx=QtnRS("idx")
					content=QtnRS("r_content")
					author=QtnRS("r_author")
					r_uid=QtnRS("r_uid")
					r_cdate=QtnRS("r_cdate")
					r_mdate=QtnRS("r_mdate")
					r_date=""
					
					If r_mdate<>"" Then
						r_date=r_mdate
					Else
						r_date=r_cdate
					End If
					
					replyy="<tr><td>"&author&"</td><td>"&content&"</td><td>"&r_date&"</td>"
					If (userid<>"" and userid=r_uid) or u_grade="3" Then '해당 댓글작성자 또는 최고등급 유저인 경우에만 삭제 버튼 
						replyy=replyy&"<td><input type='button' class='deletebtn btn red' value='삭제' data-b_idx='"&idx&"' data-r_idx='"&r_idx&"' data-r_uid='"&r_uid&"' /></td>"
					End If
					replyy=replyy&"</tr>"
					response.write replyy
					
				QtnRS.MoveNext
				Loop
				
				QtnRS.Close : Set QtnRS = Nothing
				
  			DBHelper.Dispose : Set DBHelper=Nothing
			%>
		</tbody>
	</table>
	<br>
<% End If %>

	<% If userid<>"" Then %>
		<div class="rply-wrapper">
		<form id="frm" name="frm" action="data.asp" method="post">
		<input type="hidden" name="r_bidx" id="r_bidx" class="hidden" value="<%=idx%>">
		<input type="hidden" name="r_uid" id="r_uid" class="hidden" value="<%=userid%>">
		<input type="hidden" name="st" id="st" class="hidden" value="reply">
		<div class="row">
		<div class="input-field col s3" style="text-align:right;"><b>댓글 작성 : </b></div>
		<div class="input-field col s6">
		<textarea id="r_content" name="r_content">댓글작성</textarea>
		</div>
		<div class="input-field col s3" style="text-align:left;"><input type="button" id="submitbtn" class="btn" value="등록" /></div>
		</div>
		</form>
		</div>
	</div>
	<% End If %>



<script type="text/javascript">


<% If (userid<>"" AND userid=b_uid) or u_grade="3" Then %>
//글 삭제
var delpostbtn=document.getElementById("delpostbtn");
delpostbtn.addEventListener("click",async function(){
	let b_idx=this.dataset.b_idx
	let b_uid=this.dataset.b_uid
  let resultt = await usercheck("<%=userid%>");
  if(resultt=="통신 성공"){
		if(window.confirm("정말 삭제하시겠습니까?")){
			window.location.href = 'data.asp?st=boarddel&b_uid='+b_uid+'&b_idx='+b_idx;
		}else{
			console.log("삭제취소");
		}
	}
});
<% End If %>


<% If userid<>"" AND userid=b_uid Then %>
//글 삭제
var modpostbtn=document.getElementById("modpostbtn");
modpostbtn.addEventListener("click",async function(){
  let resultt = await usercheck("<%=userid%>");
  if(resultt=="통신 성공"){
		window.location.href = 'create.asp?st=m&idx=<%=idx%>';
	}
});
<% End If %>


<% If userid<>"" Then %>
 //댓글 등록
var subbtn=document.getElementById("submitbtn");
var r_uid=document.getElementById("r_uid");
subbtn.onclick = async function(){
	let resultt = await usercheck("<%=userid%>");
  if(resultt=="통신 성공"){
	  //폼 submit
		document.getElementById("frm").submit();
  }
};


//댓글 삭제
var deletebtns=document.getElementsByClassName("deletebtn");
for(i=0;i<deletebtns.length;i++){
	deletebtns[i].onclick = async function(){
		let r_bidx=this.dataset.b_idx
		let r_idx=this.dataset.r_idx
		let r_uid=this.dataset.r_uid
	  let resultt = await usercheck("<%=userid%>");
	  if(resultt=="통신 성공"){
		  //폼 submit
			if(window.confirm("정말 삭제하시겠습니까?")){
				window.location.href = 'data.asp?st=delrply&r_uid='+r_uid+'&r_bidx='+r_bidx+'&r_idx='+r_idx+'';
			}else{
				console.log("삭제취소");
			}	
	  };
	};
}

<% End If %>
</script>
<!-- #include file="include_footer.asp"-->