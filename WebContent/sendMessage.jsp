 <%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.google.android.gcm.server.*"%>
<%@ page import="" %>


 
<%
    ArrayList<String> token = new ArrayList<String>();    //token값을 ArrayList에 저장
    String MESSAGE_ID = String.valueOf(Math.random() % 100 + 1);    //메시지 고유 ID
    boolean SHOW_ON_IDLE = false;    //옙 활성화 상태일때 보여줄것인지
    int LIVE_TIME = 1;    //옙 비활성화 상태일때 FCM가 메시지를 유효화하는 시간입니다.
    int RETRY = 2;    //메시지 전송에 실패할 시 재시도 횟수입니다.
 
    
    String simpleApiKey = "AIzaSyDIHLM2c__vRlZTBh5bvMMrUD7b5hGPGL8 ";
    String gcmURL =" https://console.firebase.google.com/project/smarthelmet-202703/overview" ;   //주의요망
    Connection conn = null; 
    PreparedStatement stmt = null; 
    ResultSet rs = null;



    try {

    	String jdbcUrl = "jdbc:mysql://localhost/wbkim11"; // MySQL 계정
    	String dbId = "wbkim11"; // MySQL 계정
    	String dbPw = "q1w2e3r4"; // 비밀번호        
        String sql = "sql문"; // 등록된 token을 찾아오도록 하는 sql문
	
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
        stmt = conn.prepareStatement(sql);    
        rs = stmt.executeQuery();
        
        //모든 등록ID를 리스트로 묶음
        while(rs.next()){
              token.add(rs.getString("token"));
        }
        conn.close();
        request.setCharacterEncoding("utf-8");
    	String title = new String("Notification 타이틀".getBytes("UTF-8"),"UTF-8");    
        String msg = new String(request.getParameter("message").getBytes("UTF-8"), "UTF-8");   //메시지 한글깨짐 처리  // msg.jsp 에서 전달받은 메시지

        out.print(msg);
        Sender sender = new Sender(simpleApiKey);
        Message message = new Message.Builder()
        .collapseKey(MESSAGE_ID)
        .delayWhileIdle(SHOW_ON_IDLE)
        .timeToLive(LIVE_TIME)
        .addData("message",msg)
        .addData("title",title)
        .build();
    
        @Override
        public void onMessageReceived( RemoteMessage remoteMessage) {
            String message = remoteMessage.getData().get("message");
            String title = remoteMessage.getData().get("title");

            sendNotification(message, title);
        }
            MulticastResult result1 = sender.send(message,token,RETRY);
            if (result1 != null) {
                List<Result> resultList = result1.getResults();
                for (Result result : resultList) {
                    System.out.println(result.getErrorCodeName()); 
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
        }


%>

<script src="https://www.gstatic.com/firebasejs/4.13.0/firebase.js"></script>
<script>
  // Initialize Firebase
  var config = {
    apiKey: "AIzaSyDIHLM2c__vRlZTBh5bvMMrUD7b5hGPGL8",
    authDomain: "smarthelmet-202703.firebaseapp.com",
    databaseURL: "https://smarthelmet-202703.firebaseio.com",
    projectId: "smarthelmet-202703",
    storageBucket: "smarthelmet-202703.appspot.com",
    messagingSenderId: "483521819633"
  };
  firebase.initializeApp(config);
</script>
