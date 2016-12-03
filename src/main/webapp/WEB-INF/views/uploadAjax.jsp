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
				url: '/uploadAjax', //여기로 파일을 저장하면 밑에서 displayFile로 요청해서받아올수잇음
				data: formData,
				dataType:'text',
				processData:false,
				contentType:false,
				type: 'POST',
				  success: function(data){
					 	
					  
					  var str="";
					 
					  console.log(data);
					  console.log(checkImageType(data));
					  
					  if(checkImageType(data)){ //년도/파일이름까지 다온다,
//					  	 var temp="asdasd/asdsadda////";
						  str="<div>" + "<a href='displayFile?fileName="+getImageLink(data)+"'><img src='displayFile?fileName="+data+"' />"+data+"</a><small data-src="+data+">X</small></div>"; //따로 서버로 요청하는부분
					  }else{
						  str="<div><a href='displayFile?fileName='"+data+"'>"+getOriginalName(data)+"</a><small data-src='"+data+"'>X</small></div>";
						  
					  }
					  $(".uploadedList").append(str);
					  alert(data);
					 
				  }
				
			});
			
		}); 
		
		$(".uploadedList").on("click", "small", function(event){
			
			var that = $(this);
			$.ajax({
				url:"deleteFile",
				type:"post",
				data: {fileName:$(this).attr("data-src")},
				datatype:"text",
				success:function(result){
					if(result == 'deleted'){
						alert("deleted");
						that.parent("div").remove();
					}
					
				}
				
			})
			
			
		});
		
		
		function checkImageType(fileName){ //정규식으로 이미지 확인여부
			var pattern = /jpg|gif|png|jpeg/i;
			
			return fileName.match(pattern); //ture/false여부
		}
		
		function getOriginalName(fileName){ //substr로 원래값만 뽑아내는부분
			if(checkImageType(fileName)){
				return;
			}
			
			var idx = fileName.indexOf("_") + 1;
			return fileName.substr(idx);
			
		}
		
		function getImageLink(fileName){
			if(!checkImageType(fileName)){
				return ;
			}
			console.log("1:"+fileName);
			var front = fileName.substr(0,12);
			var end = fileName.substr(14);
			console.log("2:"+front+end);
			return front + end;
			
		}
		

	</script>



</body>
</html>