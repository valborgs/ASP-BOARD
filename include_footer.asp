	            
            </div>
        	</div>
        </div>
    </div>
<!-- Page specific script -->
<script type="text/javascript" src="./materialize/js/materialize.min.js" charset="utf-8"></script>
<script type="text/javascript">

//새로그인 여부 체크
function usercheck(uid){
	//XMLHttpRequest 객체 생성 
	let xhr = new XMLHttpRequest(); 
	let rresult=""
	//서버와 통신 되었을때 설정
	xhr.onreadystatechange = function(){
		if(xhr.readyState === 4){
			if(xhr.status === 200){
				let result=xhr.response;
				if(result=="success"){
					rresult="통신 성공"
				}else{
					alert("로그인 정보가 변경되었습니다.");
					window.location.href = 'index.asp';
				}
			}else{
				alert("통신 실패, 잠시후 다시 시도하여주십시오.");
				rresult="failed"
			}
		}
	}
	//요청을 보낼 방식, 주소, 비동기여부 설정 
	xhr.open('GET', './usercheck.asp?uid='+uid, false); 
	//요청 전송
	xhr.send();
	
	return rresult;
}

</script>
</body>
</html>

