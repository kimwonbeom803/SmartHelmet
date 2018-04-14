<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs2.BbsDAO2"%>
<%@ page import="bbs2.Bbs2"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Smart-Helmet</title>
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
		} else {
			if (request.getParameter("bbsTitle2") == null || request.getParameter("bbsTitle2").equals("") || 
					request.getParameter("bbsContent2") == null || request.getParameter("bbsContent2").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.');");
				script.println("history.back();");
				script.println("</script>");
				script.close();
			} else {
				BbsDAO2 bbsDAO2 = new BbsDAO2();
				int result = bbsDAO2.update(bbsID2, request.getParameter("bbsTitle2"), request.getParameter("bbsContent2"));
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패하였습니다.');");
					script.println("history.back();");
					script.println("</script>");
					script.close();
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs2.jsp';");
					script.println("</script>");
					script.close();
				}
			}
		}
	%>
</body>
</html>