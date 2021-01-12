<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<div class="container">
	<!-- 	삭제는 하이퍼링크로 x 자바스크립트로 해결  폼에서 버튼으로 안하는 이유는 delete요청은 form태그로 할 수 없다. -->
	<!-- 폼태그는 delete요청이 안되니 ajax로 해결해야된다. 그렇게 되니 결국 모든 요청을 ajax로 한다.  -->
	<c:if test="${sessionScope.principal.id==dto.userId }">
		<a class="btn btn-warning"
			href="/blog/board?cmd=updateForm&id=${dto.id}">수정</a>
		<button class="btn btn-danger" onClick="deleteById(${dto.id})">삭제</button>
	</c:if>
	<!-- 	스크립트는 자바스크립트 파일로 분리할것이기 때문에 onclick에서 넘긴다. -->
	<!-- delete와 get은 바디가 없기때문에 나중에 바디에 넣으면 안되고 param에 넣어야한다. -->


	<br /> <br />
	<h6 class="m-2">
		작성자 : <i>${dto.username}</i> 조회수 : <i>${dto.readCount}</i>
	</h6>
	<br />
	<h3 class="m-2">
		<b>${dto.title}</b>
	</h3>
	<hr />
	<div class="form-group">
		<div class="m-2">${dto.content}</div>
	</div>

	<hr />

	<!-- 댓글 박스 -->
	<div class="row bootstrap snippets">
		<div class="col-md-12">
			<div class="comment-wrapper">
				<div class="panel panel-info">
					<div class="panel-heading m-2">
						<b>Comment</b>
					</div>
					<div class="panel-body">
						<input type="hidden" name="userId"
							value="${sessionScope.principal.id}" /> <input type="hidden"
							name="boardId" value="${dto.id}" />
						<textarea id="content" id="reply__write__form"
							class="form-control" placeholder="write a comment..." rows="2"></textarea>
						<br>

						<button
							onClick="replySave(${sessionScope.principal.id}, ${dto.id})"
							class="btn btn-primary pull-right">댓글쓰기</button>

						<div class="clearfix"></div>
						<hr />

						<!-- 댓글 리스트 시작-->
						<ul id="reply__list" class="media-list">
							<c:forEach var="reply" items="${replys }">
								<!-- 댓글 아이템 -->
								<li id="reply-${reply.id }" class="media">
									<div class="media-body">
										<strong class="text-primary">${reply.userId }</strong>
										<p>${ reply.content}</p>
									</div>
									<div class="m-2">
										<c:if test="${sessionScope.principal.id == reply.userId }">
											<i onclick="deleteReply(${reply.id})" class="material-icons">delete</i>
										</c:if>
									</div>
								</li>
							</c:forEach>
						</ul>
						<!-- 댓글 리스트 끝-->
					</div>
				</div>
			</div>

		</div>
	</div>
	<!-- 댓글 박스 끝 -->
</div>
<script src="/blog/js/boardDetail.js"></script>
</body>
</html>