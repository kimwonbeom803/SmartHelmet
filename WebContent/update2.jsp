<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs2.Bbs2"%>
<%@ page import="bbs2.BbsDAO2"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<title>Smart-Helmet</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.');");
			script.println("location.href='login.jsp'");
			script.println("</script>");
			script.close();
		}
		int bbsID2 = 0;
		if (request.getParameter("bbsID2") != null) {
			bbsID2 = Integer.parseInt(request.getParameter("bbsID2"));
		}
		if (bbsID2 == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.');");
			script.println("location.href='bbs2.jsp';");
			script.println("</script>");
			script.close();
		}
		Bbs2 bbs2 = new BbsDAO2().getBbs(bbsID2);
		if (!userID.equals(bbs2.getUserID2())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.');");
			script.println("location.href='bbs2.jsp';");
			script.println("</script>");
			script.close();
		}
	%>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="main.jsp">Smart-Helmet</a>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="main.jsp">메인</a></li>
					<li><a href="bbs.jsp">판매자게시판</a></li>
					<li><a href="bbs2.jsp">구매자게시판</a></li>
					<li><a href="Attend.jsp">출근부</a></li>
					<li><a href="GoogleMap.jsp">근로자 위치 검색</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction2.jsp?bbsID2=<%= bbsID2 %>">
				<table class="table table-bordered" style="text-align: center;">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>
						</tr>
					</thead>
					<tbody>
							<tr>
								<td colspan="2"><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle2" maxlength="50" value="<%= bbs2.getBbsTitle2() %>"></td>
							</tr>
							<tr>
								<td colspan="2"><textarea class="form-control" name="bbsContent2" placeholder="글 내용" maxlength="2048" style="height: 350px;"><%= bbs2.getBbsContent2() %></textarea></td>
							</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글 수정">
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>