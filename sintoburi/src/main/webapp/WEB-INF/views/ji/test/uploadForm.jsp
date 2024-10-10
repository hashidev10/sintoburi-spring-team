<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>uploadFormAction</title>
</head>
<body>
	<form action="/uploadFormAction" method="post"
		enctype="multipart/form-data">
	
		<input type="file" name="uploadFile" multiple>
		<button type="submit">전송</button>	
	</form>
</body>
</html>