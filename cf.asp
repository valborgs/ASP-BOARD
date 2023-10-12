<%@Language="VBScript" CODEPAGE="65001" %>
<%
  Response.CharSet="utf-8"
  Session.codepage="65001"
  Response.codepage="65001"
  Response.ContentType="text/html;charset=utf-8"

Dim Fso, strDir, objCsv, strCsv


Set Fso = Server.CreateObject("Scripting.FileSystemObject") '파일객체 생성
Set objCsv = Fso.OpenTextFile(Server.MapPath("./uploadxl/")&"\example.csv") 'csv파일 불러오기
'strCsv = objCsv.Readall 'csv 문서 전체를 읽어옴
'objCsv.Close()
'Set objCsv = Nothing

do while objCsv.AtEndOfStream <> True
	linetxt=objCsv.readLine
	response.write linetxt&"<br>"
	ckey=Split(objCsv.readLine,"\n")(0)
	cvalue=Split(objCsv.readLine,"\n")(1)
	response.write ckey&"<br>"
	response.write cvalue&"<br>"
	
	fn = "/"&ckey&"/" '폴더명 지정
	strDir = Server.MapPath("./images/")&fn '현재 경로 + 폴더명
	
	If Not Fso.FolderExists(strDir) Then '폴더가 존재하지 않으면
		strDir = Fso.CreateFolder(strDir) '폴더를 생성
		Response.Write strDir & " 폴더 생성에 성공하였습니다."&"<br>"
	Else
		Response.Write strDir & " 폴더가 존재합니다."&"<br>"
	End If
Loop



objCsv.Close()
Set objCsv = Nothing
Set Fso = nothing
%>