package JSP;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ScheduleDAO {
	Connection conn;
	
	//연결하는 작업
	public ScheduleDAO() {
		System.setProperty("jdbc.drivers", "com.mysql.jdbc.Driver");
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		String strUrl = "jdbc:mysql://localhost/wbkim11";
		
		try {
			conn = DriverManager.getConnection(strUrl ,"wbkim11","q1w2e3r4");
			conn.setAutoCommit(false);
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	//추가
		public void joinSchedule(JSP.Schedule user) throws SQLException {
			
			try {
				PreparedStatement ps
				= conn.prepareStatement("insert into scheduleinfo values(?,?,?,?)");
				ps.setInt(1, user.getNum());
				ps.setString(2, user.getUserID());
				ps.setString(3, user.getDate());
				ps.setString(4, user.getSchedule());
				
				ps.addBatch();
				ps.executeBatch();
				ps.close();
				conn.commit();
			}catch(SQLException e) {
				conn.rollback();
				e.printStackTrace();
			}
		}
		//삭제
		public void deleteSchedule(JSP.Schedule user) {
			
			try {
				PreparedStatement ps
				= conn.prepareStatement("delete from scheduleinfo where userID = ?");
				
				ps.setString(1, user.getUserID());
				ps.executeUpdate();
				ps.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		//변경
		public void updateSchedule(String userID, String date, String schedule) {
			
			try {
				PreparedStatement ps
				= conn.prepareStatement("update scheduleinfo set date = ?, schedule = ?" + "where userID = ?");
				
				ps.setString(1, date);
				ps.setString(2, schedule);
				ps.setString(3, userID);
				ps.executeUpdate();
				ps.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		//전체 선택
		public ArrayList<JSP.Schedule> selectAllSchedule() {
			ArrayList<JSP.Schedule> list = new ArrayList<JSP.Schedule>();
			
			try {
				PreparedStatement ps
				= conn.prepareStatement("select * from scheduleinfo");
				ResultSet rs = ps.executeQuery();
				
				while(rs.next()) {
					Schedule user = new Schedule();
					user.setUserID(rs.getString("userID"));
					user.setDate(rs.getString("date"));
					user.setSchedule(rs.getString("schedule"));
					
					list.add(user);
				}
				rs.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
			return list;
		}
		//부분 선택
		public JSP.Schedule selectSchedule(String userID) {
			
			JSP.Schedule user = new JSP.Schedule();
			
			try {
				PreparedStatement ps
				= conn.prepareStatement("select * from scheduleinfo where userID = ?");
				ps.setString(1, userID);
				
				ResultSet rs = ps.executeQuery();
				rs.next();
				user.setUserID(rs.getString("userID"));
				user.setDate(rs.getString("date"));
				user.setSchedule(rs.getString("schedule"));
			}catch(SQLException e) {
				e.printStackTrace();
			}
			return user;
		}	
}
