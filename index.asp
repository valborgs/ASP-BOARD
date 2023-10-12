<!-- #include file="include_header.asp"-->
<%
  Set DBHelper = new clsDBHelper
  
  dbname = "tblS45340ms_board"
  
  pagesize = 10 '한 페이지에 나오는 게시글 수 지정
  
  whereplus="" '쿼리 조건 추가용
  selbx=request("selbx") '검색항목
  sc=request("sc") '검색내용
  
  If sc<>"" Then '검색내용이 있을 때 조건절 추가
  	whereplus="and " & selbx & " like '%" & sc & "%' "
  End If
  
  '페이지 불러오기 없으면 1페이지로
  If request("page")="" Then
		nowpage = 1
	Else
		nowpage = Cint(request("page"))
	End If
	
	prevcnt = (nowpage-1) * pagesize '여태 까지 나온 게시글 수
  
  strSQL="select count(*) cnt from "& dbname &" where b_removed is null "& whereplus
  Set QtnRS1 = DBHelper.ExecSQLReturnRS(strSQL, Nothing, Nothing)
  totrecord = Cint(QtnRS1("cnt")) '전체 레코드 수
  QtnRS1.Close : Set QtnRS1 = Nothing

  If userid="" Then '어드민계정일때만 비밀글 보여주기
  	'whereplus="and b_secret<>'on'"
  End If

	If nowpage = 1 Then
		'게시글 쿼리
		'strSQL = "select top "& pagesize &" * from "& dbname &" where (b_removed is null or b_removed<>'rmv') "&whereplus&" order by idx desc "
		
		'게시글 + 댓글 수 쿼리
		strSQL=""
		strSQL="select c.idx,c.b_title,c.b_content,c.b_author,c.b_uid,c.b_pw,c.b_cdate,c.b_mdate,c.b_grade,c.b_secret,c.b_removed,d.b_rcnt from"
		strSQL=strSQL&" (select top 10 * from tblS45340ms_board where (b_removed is null or b_removed<>'rmv') "& whereplus &" order by idx desc) c"
		strSQL=strSQL&" left outer join"
		strSQL=strSQL&" (select a.idx,count(b.idx) b_rcnt"
		strSQL=strSQL&" from"
		strSQL=strSQL&" (select top 10 * from tblS45340ms_board where (b_removed is null or b_removed<>'rmv') "& whereplus &" order by idx desc) a"
		strSQL=strSQL&" left outer join"
		strSQL=strSQL&" (select idx,r_bidx from tblS45340ms_reply where (r_removed is null or r_removed<>'rmv')) b"
		strSQL=strSQL&" on a.idx=b.r_bidx"
		strSQL=strSQL&" group by a.idx"
		strSQL=strSQL&" ) d"
		strSQL=strSQL&" on c.idx=d.idx"
		strSQL=strSQL&" order by c.idx desc"
		
		
	Else '첫페이지 이후부터
		'게시글 쿼리
		'strSQL = "select top "& pagesize &" * from "& dbname &" where idx not in (select top "& prevcnt &" idx from "& dbname &" where (b_removed is null or b_removed<>'rmv') "&whereplus&" order by idx desc) and (b_removed is null or b_removed<>'rmv') "&whereplus&" order by idx desc "
		
		'게시글 + 댓글 수 쿼리
		strSQL=""
		strSQL="select c.idx,c.b_title,c.b_content,c.b_author,c.b_uid,c.b_pw,c.b_cdate,c.b_mdate,c.b_grade,c.b_secret,c.b_removed,d.b_rcnt from"
		strSQL=strSQL&" (select top "& pagesize &" * from "& dbname &" where idx not in (select top "& prevcnt &" idx from "& dbname &" where (b_removed is null or b_removed<>'rmv') "&whereplus&" order by idx desc) and (b_removed is null or b_removed<>'rmv') "&whereplus&" order by idx desc) c"
		strSQL=strSQL&" left outer join"
		strSQL=strSQL&" (select a.idx,count(b.idx) b_rcnt"
		strSQL=strSQL&" from"
		strSQL=strSQL&" (select top "& pagesize &" * from "& dbname &" where idx not in (select top "& prevcnt &" idx from "& dbname &" where (b_removed is null or b_removed<>'rmv') "&whereplus&" order by idx desc) and (b_removed is null or b_removed<>'rmv') "&whereplus&" order by idx desc) a"
		strSQL=strSQL&" left outer join"
		strSQL=strSQL&" (select idx,r_bidx from tblS45340ms_reply where (r_removed is null or r_removed<>'rmv')) b"
		strSQL=strSQL&" on a.idx=b.r_bidx"
		strSQL=strSQL&" group by a.idx"
		strSQL=strSQL&" ) d"
		strSQL=strSQL&" on c.idx=d.idx"
		strSQL=strSQL&" order by c.idx desc"
		
	End If
  Set QtnRS = DBHelper.ExecSQLReturnRS(strSQL, Nothing, Nothing)
  
  totpage = -(Int(-(totrecord/10))) '전체 페이지 수
  maxpage = 10 '최대 보여줄 페이지 수
%>

	            <div class="frmwrapper">
	            	<form id="frm" name="frm" action="data.asp" method="post">
	            	<table class="centered highlight boardlist">
	            	<thead>
	            		<tr><th style="width:10%">번호</th><th style="width:65%">제목</th><th style="width:10%">작성자</th><th style="width:15%">작성일</th></tr>
	            	</thead>
	            	<tbody>
	            	
								<%
									Do Until QtnRS.Eof
										idx=QtnRS("idx")
										content=QtnRS("b_title")
										author=QtnRS("b_author")
										rcnt=QtnRS("b_rcnt")
										
										secret=QtnRS("b_secret")
										If secret="on" Then
											secret="<i class='material-icons'>lock_outline</i> "
											href="secret.asp?idx="&idx
										Else
											secret=""
											href="detail.asp?idx="&idx
										End If
										
										If rcnt<>0 Then
											response.write "<tr><td>"&idx&"</td><td><a href='"&href&"'>"&secret&""&content&" <span class='rply'>["&rcnt&"]</span></a></td><td>"&author&"</td><td>2021.12.28</td></tr>"
										Else
											response.write "<tr><td>"&idx&"</td><td><a href='"&href&"'>"&secret&""&content&"</a></td><td>"&author&"</td><td>2021.12.28</td></tr>"
										End If
									QtnRS.MoveNext
									Loop
								%>
								
	            	</tbody>
	            	</table>
	            	<br>
	            	<div align="right" style="padding:10px;">
	            		<span id="b_write" class="btn-floating btn-large cyan"><i class="material-icons">edit</i></span>
	            	</div>
	            	<br>
	            	<div class="divider"></div>
	            	<br>
	            	</form>
	            </div>
	            
	            <div class="frmwrapper">
	            <form id="frm_search" name="frm_search" action="index.asp" method="post">
	            <input type="hidden" name="page">
	            <div class="row">
							<!--페이지네이션-->
								<ul class="pagination">
								<!--맨앞,앞페이지-->
								<% If nowpage<>1 Then %>
								<li class="waves-effect" data-page="1"><a href="?page=1"><i class="material-icons">first_page</i></a></li>
								<li class="waves-effect" data-page="<%=(nowpage-1)%>"><a href="?page=<%=(nowpage-1)%>"><i class="material-icons">chevron_left</i></a></li>
								<% Else %>	
								<li class="disabled" data-page="1"><a href="#!"><i class="material-icons">first_page</i></a></li>
								<li class="disabled" data-page="<%=(nowpage-1)%>"><a href="#!"><i class="material-icons">chevron_left</i></a></li>
								<% End If %>
									<!--페이지숫자-->
									<%
											If nowpage="1" or nowpage="2" or nowpage=totpage-1 or nowpage=totpage or totpage<5 Then
												If nowpage=1 Then '첫 번째 페이지일 경우
													i=0
													ed=4
												Elseif nowpage=2 Then '두 번째 페이지일 경우
													i=-1
													ed=3
												Elseif nowpage=(totpage-1) and totpage>=5 Then '마지막에서 한페이지 이전일 경우
													i=-3 
													ed=1
												Elseif nowpage=totpage and totpage>=5 Then '마지막 페이지일 경우
													i=-4 
													ed=0
												Else '5페이지가 안되는 경우
													i=-2
													ed=2
													if nowpage=4 Then
														i=-3
														ed=1
													End if
												End If
												
												cntt=0
												Do while i<ed+1
													cntt=cntt+1
													if i=0 Then cl="active" Else cl="waves-effect" End If
													response.write "<li class='"& cl &"' data-page='"& (nowpage+i) &"'><a href='?page="&(nowpage+i)&"'>"&(nowpage+i)&"</a></li>"
													i=i+1
													if cntt=totpage Then
														Exit Do
													End If
												Loop
												
											Else
												For i=-2 to 2
													if i=0 Then cl="active" Else cl="waves-effect" End If
													response.write "<li class='"& cl &"' data-page='"& (nowpage+i) &"'><a href='?page="&(nowpage+i)&"'>"&(nowpage+i)&"</a></li>"
													If nowpage=totpage and i=nowpage+i Then
														Exit For
													End If
												Next
											End If
									%>
									
									<!--맨뒤,뒤페이지-->
									<% If nowpage<>totpage Then %>
									<li class="waves-effect" data-page="<%=(nowpage+1)%>"><a href="?page=<%=(nowpage+1)%>"><i class="material-icons">chevron_right</i></a></li>
									<li class="waves-effect" data-page="<%=totpage%>"><a href="?page=<%=totpage%>"><i class="material-icons">last_page</i></a></li>
									<% Else %>
									<li class="disabled"><a href="#!"><i class="material-icons">chevron_right</i></a></li>
									<li class="disabled"><a href="#!"><i class="material-icons">last_page</i></a></li>
									<% End If %>
								</ul>
								</div>
	            <div class="row">
	            	<div class="col s2"></div>
	            	<div class="col s1">
	            	<select name="selbx" id="selbx">
	            	<option value="b_title" <% If selbx="b_title" or sc="" Then response.write "selected" End If %>>제목</option>
	            	<option value="b_content" <% If selbx="b_content" and sc<>"" Then response.write "selected" End If %>>본문</option>
	            	<option value="b_author" <% If selbx="b_author" and sc<>"" Then response.write "selected" End If %>>작성자</option>
	            	</select>
	            	</div>
	            	<div class="col s6">
	            	<input type="text" name="sc" id="sc" <% If sc<>"" Then response.write "value="&sc End If %>>
	            	</div>
	            	<div class="col s1">
	            	<input type="button" class="btn" id="submitsc" value="검색">
	            	</div>
	            	<div class="col s2"></div>
	            </div>
	            </form>
	            </div>

<%
	QtnRS.Close : Set QtnRS = Nothing
  DBHelper.Dispose : Set DBHelper=Nothing
%>


<script type="text/javascript">

//검색 이벤트
  document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('select');
    var instances = M.FormSelect.init(elems, );
  });
  
	var subbtn=document.getElementById("submitsc");
  //전송버튼 클릭이벤트
	subbtn.onclick = async function(){
    
		let resultt = await usercheck("<%=userid%>");
		
  	if(resultt=="통신 성공"){
			//폼 submit
    	document.getElementById("frm_search").submit();
		};
    
	};
  

  
	var writebtn=document.getElementById("b_write");
	var uid=document.getElementById("userid").innerHTML;
  //전송버튼 클릭이벤트
	writebtn.addEventListener("click",async function(){
	  let resultt = await usercheck(uid);
	  if(resultt=="통신 성공"){
			window.location.href = 'create.asp';
		}
	});
	
</script>
<!-- #include file="include_footer.asp"-->