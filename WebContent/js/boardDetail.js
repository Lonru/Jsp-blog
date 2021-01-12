//js파일로 스크립트를 옮겨야 벡틱을 쓸 수 있다.
function addReply(data) {
	var replyItem = `<li id="reply-${data.id}" class="media">`;
	replyItem += `<div class="media-body">`;
	replyItem += `<strong class="text-primary">${data.userId}</strong>`;
	replyItem += `<p>${data.content}.</p></div>`;
	replyItem += `<div class="m-2">`;

	replyItem += `<i onclick="deleteReply(${data.id})" class="material-icons">delete</i></div></li>`;
	console.log("addReply : "+ replyItem);
	$("#reply__list").prepend(replyItem);
}
function deleteReply(id){
	// 세션의 유저의 id와 reply의 userId를 비교해서 같을때만!!
	$.ajax({
		type : "post", //get은 공격을 당할 수 있다.
		url : "/blog/reply?cmd=delete&id="+id,
		dataType : "json"
	}).done(function(result)  {	
		if  (result.statusCode  ==  1) {
//			addReply(result.data);
			location.reload();
	} else {
		alert("댓글삭제 실패");
	}
});
}

function replySave(userId, boardId)  {
if(userId==null){
	alert("로그인이 필요합니다");
	return;
}

	var data = {
		userId: userId,
		boardId: boardId,
		content: $("#content").val()
	}

		//jsp 코드에 ${session}적으면 나중에 스크립트만 빼서 js파일 만들 때 힘들어짐.
	$.ajax({
		type : "post",
		url : "/blog/reply?cmd=save",
		data : JSON.stringify(data),
		contentType : "application/json; charset=utf-8",
		dataType : "json"
	}).done(function(result)  {	
		if  (result.statusCode  ==  1) {
//			addReply(result.data);
			$("#content").val("");
			location.reload();
	} else {
		alert("댓글쓰기 실패");
	}
});
}
//요청과 응답을 json으로 통일
function deleteById(boardId) {
	// 요청과 응답	을 json
	var data = {
		boardId: boardId
	}
	$.ajax({
		type: "post",
		url: "/blog/board?cmd=delete",
		data: JSON.stringify(data),
		contentType: "application/json; charset=utf-8",
		dataType: "json"
	}).done(function(result) {
		console.log(result);
		if (result.status == "ok") {
			location.href = "index.jsp";
		} else {
			alert("삭제에 실패하였습니다.");
		}
	});
}