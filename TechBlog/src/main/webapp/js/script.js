function doLike(pid, uid, e1) {
	const d = {
		uid: uid,
		pid: pid,
		operation: 'like',
	}

	$.ajax({
		url: 'LikesServlet',
		data: d,
		success: function(data) {
			console.log(data);
			if (data.trim() === 'true') {
				let c = parseInt($(e1).find('.like-count').html());
				if (!isNaN(c)) {
					console.log(data);
					c++;
					$(e1).find('.like-count').html(c);
				}
			}
		},
		error: function() {
			console.log("error");
		}
	});
}
function doComment(pid, uid, commentMessage) {
	const d = {
		pid: pid,
		uid: uid,
		message: commentMessage,
		operation: 'comment',
	}
	$.ajax({
		url: 'CommentServlet',
		data: d,
		type: 'POST',
		success: function(data) {
			if (data.trim() == "true") {
				Swal.fire({
					title: "Comment added successfully!",
					icon: "success",
					draggable: true
				}).then(() => {
					location.reload();
				});;

			} else {
				Swal.fire({
					title: "Something went wrong!",
					icon: "error",
					draggable: true
				});
			}

		}
	})
}
function doEditComment(pid, uid, cid, commentMessage) {
	const d = {
		postId: pid,
		userId: uid,
		commentId: cid,
		commentMessage: commentMessage,
		operation:"commentEdit",
	}
	$.ajax({
		url: 'EditComment',
		data: d,
		type: 'POST',
		success: function(data) {
			if (data.trim() == "true") {
				resetCommentForm();
				Swal.fire({
					title: "Comment Edit successfully!",
					icon: "success",
					draggable: true
				}).then(() => {
					location.reload();
				});
			} else {
				Swal.fire({
					title: "Something went wrong!",
					icon: "error",
					draggable: true
				});
			}
		}
	})
}
function resetCommentForm() {
	$('#commentMessage').val("");
	$('#commentId').val("");
	$('#submitCommentBtn').text("Post Comment");
	$('#addComment').attr("action", "CommentServlet");
}

function doReply(commentId, replyMessage, postId, userId) {
	const d = {
		commentId: commentId,
		replyMessage: replyMessage,
		postId: postId,
		userId: userId,

		operation: "reply",
	}
	$.ajax({
		url: 'RepliesOnComment',
		type: 'POST',
		data: d,
		success: function(data) {
			if (data.trim() == "true") {
				Swal.fire({
					title: "Reply added successfully!",
					icon: "success",
					draggable: true
				}).then(() => {
					location.reload();
				});

			} else {
				Swal.fire({
					title: "Something went wrong!",
					icon: "error",
					draggable: true
				})
			}
		}
	})
}
function doReply2(commentId, replyMessage, postId, userId, parent_reply_id) {
	const d = {
		commentId: commentId,
		replyMessage: replyMessage,
		postId: postId,
		userId: userId,
		parent_reply_id: parent_reply_id,
		operation: "reply2",
	}
	console.log(parent_reply_id)
	$.ajax({
		url: 'RepliesOnComment',
		type: 'POST',
		data: d,
		success: function(data) {
			if (data.trim() == "true") {
				Swal.fire({
					title: "Reply added successfully!",
					icon: "success",
					draggable: true
				}).then(() => {
					location.reload();
				})

			}
		}
	})
}

function doDeletePost(postId, userId, event) {
	if (event) event.preventDefault();
	const d = {
		postId: postId,
		userId: userId,
		operation: 'delete',
	}
	$.ajax({
		url: 'Delete',
		type: 'POST',
		data: d,
		success: function(data) {
			if (data.trim() == "true") {
				Swal.fire({
					title: "Post deleted successfully!",
					icon: "success",
					draggable: true
				}).then(() => {
					location.reload();
				});
			} else {
				Swal.fire({
					title: data,
					icon: "error",
					draggable: true
				})
			}
		}
	})
}
function pleaseGoToPostPage() {
	Swal.fire({
		title: "Please go to post page for edit the posts!",
		icon: "success",
		draggable: true
	})
}
function doEditPost(postId, userId, event) {
	if (event) event.preventDefault();
	const d = {
		postId: postId,
		userId: userId,
		operation: 'edit',
	}
	$.ajax({
		url: 'Edit',
		type: 'POST',
		data: d,
		success: function(data) {
			if (data.trim() == "true") {
				Swal.fire({
					title: "Post edited successfully!",
					icon: "success",
					draggable: true
				}).then(() => {
					location.reload();
				});
			} else {
				Swal.fire({
					title: data,
					icon: "error",
					draggable: true
				})
			}
		}
	})
}
function deleteChildReply(event, replyId, commentId, postId, userId) {
	event.preventDefault();
	const d = {
		replyId: replyId,
		commentId: commentId,
		postId: postId,
		userId: userId,
		operation: "childCommentDelete",
	}
	$.ajax({
		url: 'Delete',
		data: d,
		type: 'POST',
		success: function(data) {
			if (data.trim() == "true") {
				Swal.fire({
					title: "Reply deleted successfully!",
					icon: "success",
					draggable: true,
				}).then(() => {
					location.reload();
				})
			} else {
				Swal.fire({
					title: "Something went wrong!",
					icon: "error",
					draggable: true,
				})
			}
		}
	})

}
$(document).on('click', '.childReply2', function() {
	let parent=$(this).closest('#parentContainer');
	let message=parent.find('#messageForEditBox').data('messageforedit');
	parent.find('.replyeditMessage').val(message);
	parent.find('.reply-edit-form3').toggle();
})
function EditChildReply(event,replyId,commentId,postId,userId) {
	let editedmessage=$('.replyeditMessage').val();
	event.preventDefault();
	const d={
		replyId:replyId,
		commentId:commentId,
		postId:postId,
		userId:userId,
		message:editedmessage,
		operation:"editChildReply",
	};
	$.ajax({
		url:'EditComment',
		type:"POST",
		data:d,
		success:function(data){
			if(data.trim()=="true"){
				Swal.fire({
					title:"Reply edited successfully!",
					icon:"success",
					draggable:true,
				}).then(()=>{
					location.reload();
				})
			}else{
				Swal.fire({
					title:data,
					icon:"error",
					draggable:true,
				})
			}
		}
	})
}