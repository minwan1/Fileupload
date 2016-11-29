<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.fileDrop {
		width:100%;
		height: 200px;
		border: 1px dotted blue;
	}
	
	small {
		margin-left: 3px;
		font-weight: bold;
		color: gray;
	}

</style>

</head>
<body>

	<h3>Ajax File Upload</h3>
	<div class="fileDrop"></div>
	<div class="uploadedList"></div>
	
	<button type="button" id="zxcv">zxcv</button>
	
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
 	<script type="text/javascript">
		$('.fileDrop').on("dragenter dragover",function(event){
			event.preventDefault();//파일올리면 사진으로 브라우저가 변경되니까 막귀위한것
			
		});
		
		$('.fileDrop').on("drop",function(event){
			event.preventDefault();  //파일올리면 사진으로 브라우저가 변경되니까 막귀위한것
			
			var files = event.originalEvent.dataTransfer.files; //파일이 화면올려졌을떄 파일정보를 가지고옴
			var file = files[0];
			
			console.log(file);
			var formData = new FormData();
			formData.append("file", file);
			
			$.ajax({
				url: '/uploadAjax',
				data: formData,
				dataType:'text',
				processData:false,
				contentType:false,
				type: 'POST',
				  success: function(data){
					 	
					  alert(data);
					 
				  }
				
			});
			
		}); 
		

	</script>



</body>
</html>