<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs2.BbsDAO2"%>
<%@ page import="bbs2.Bbs2"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<title>SmartHelmet</title>

<script src="https://code.jquery.com/jquery-3.2.1.js"></script>

<link rel="stylesheet" href="/css/jquery-ui.min.css">

<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />

<script
   src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>




<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">

<script type='text/javascript'
   src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>

<script src="/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>




<script type='text/javascript'>
   $(function() {

      $('.input-group.date').datepicker({

         calendarWeeks : false,

         todayHighlight : true,

         autoclose : true,

         format : "yyyy/mm/dd",

         language : "kr"

      });

   });
</script>


<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">




<style type="text/css">
a, a:hover {
   color: #000000;
   text-decoration: none;
}

#helmet {
   text-align: center;
   border-color: #eeeeee;
   border-style: solid;
   margin-bottom: 20px;
}

#helmet2 {
   font-size: 15px;
   border-image-slice: 30;
   border-color: #eeeeee;
   text-align: center;
   padding: 10px;
}



#cal1 {

   


}
</style>

</head>
<body>
   <%
      String userID = null;
      if (session.getAttribute("userID") != null) {
         userID = (String) session.getAttribute("userID");
      }
      int pageNumber = 1;
      if (request.getParameter("pageNumber") != null) {
         pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
      }
   %>
   <nav class="navbar navbar-default">
      <div class="container-fluid">
         <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed"
               data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
               aria-expanded="false">
               <span class="icon-bar"></span> <span class="icon-bar"></span> <span
                  class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="main.jsp">중고거래 사이트</a>
         </div>
         <div class="collapse navbar-collapse"
            id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
               <li><a href="main.jsp">메인</a></li>
               <li><a href="bbs.jsp">관리자게시판</a></li>
               <li><a href="bbs2.jsp">근로자게시판</a></li>
            </ul>
            <%
               if (userID == null) {
            %>
            <ul class="nav navbar-nav navbar-right">
               <li class="dropdown"><a href="#" class="dropdown-toggle"
                  data-toggle="dropdown" role="button" aria-haspopup="true"
                  aria-expanded="false">접속하기<span class="caret"></span></a>
                  <ul class="dropdown-menu">
                     <li><a href="login.jsp">로그인</a></li>
                     <li><a href="join.jsp">회원가입</a></li>
                  </ul></li>
            </ul>
            <%
               } else {
            %>
            <ul class="nav navbar-nav navbar-right">
               <li class="dropdown"><a href="#" class="dropdown-toggle"
                  data-toggle="dropdown" role="button" aria-haspopup="true"
                  aria-expanded="false">회원관리<span class="caret"></span></a>
                  <ul class="dropdown-menu">
                     <li><a href="logoutAction.jsp">로그아웃</a></li>
                  </ul></li>
            </ul>
            <%
               }
            %>
         </div>
      </div>
   </nav>
   <h1>출근부</h1>





   <div id="helmet" class="table table-striped">

      <span id="helmet2"> <span> 사용자 정보 : </span> <span>
            kimjoongsoo </span>

      </span> 
      
      <span> 조회 날짜 : </span>  
      
   <div id = cal1 >
       <span id = "cal" class="input-group date">
      
            <input type="text" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
            
        </span>
        
        
        <span id = "cal" class="input-group date">
      
            <input type="text" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
            
        </span>
      
      </div>


   </div>

   <div class="container">
      <div class="row">



         <table class="table table-striped"
            style="text-align: center; border: 1px solid #dddddd">
            <thead>
               <tr>
                  <th style="background-color: #eeeeee; text-align: center;">일자</th>
                  <th style="background-color: #eeeeee; text-align: center;">인정출근</th>
                  <th style="background-color: #eeeeee; text-align: center;">인정퇴근</th>
                  <th style="background-color: #eeeeee; text-align: center;">근무시간</th>
               </tr>
            </thead>
            <tbody>
               <%
                  BbsDAO2 bbsDAO2 = new BbsDAO2();
                  ArrayList<Bbs2> list = bbsDAO2.getList(pageNumber);
                  for (int i = 0; i < list.size(); i++) {
               %>
               <tr>
                  <td><%=list.get(i).getBbsID2()%></td>
                  <td><a href="view2.jsp?bbsID2=<%=list.get(i).getBbsID2()%>"><%=list.get(i).getBbsTitle2()%></a></td>
                  <td><%=list.get(i).getUserID2()%></td>
                  <td><%=list.get(i).getBbsDate2().substring(0, 11) + list.get(i).getBbsDate2().substring(11, 13)
                  + "시 " + list.get(i).getBbsDate2().substring(14, 16) + "분"%></td>
               </tr>
               <%
                  }
               %>
            </tbody>
         </table>
         <%
            if (pageNumber != 1) {
         %>
         <a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>"
            class="btn btn-success btn-arrow-left">이전</a>
         <%
            }
         %>
         <%
            if (bbsDAO2.nextPage(pageNumber)) {
         %>
         <a href="bbs2.jsp?pageNumber=<%=pageNumber + 1%>"
            class="btn btn-success btn-arrow-right">다음</a>
         <%
            }
         %>
         <a href="write2.jsp" class="btn btn-primary pull-right">글쓰기</a>
      </div>
   </div>








</body>
</html>