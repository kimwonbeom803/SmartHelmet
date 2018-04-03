<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs2.BbsDAO2"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="bbs2" class="bbs2.Bbs2" scope="page" />
<jsp:setProperty name="bbs2" property="bbsTitle2" />
<jsp:setProperty name="bbs2" property="bbsContent2" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>중고거래 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.');");
			script.println("location.href='login.jsp'");
			script.println("</script>");
			script.close();
		} else {
			if (bbs2.getBbsTitle2() == null || bbs2.getBbsContent2() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.');");
				script.println("history.back();");
				script.println("</script>");
				script.close();
			} else {
				BbsDAO2 bbsDAO2 = new BbsDAO2();
				int result = bbsDAO2.write(bbs2.getBbsTitle2(), userID, bbs2.getBbsContent2());
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