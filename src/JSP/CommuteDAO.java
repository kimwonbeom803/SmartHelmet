package JSP;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CommuteDAO {
Connection conn;
	//연결하는 작업
	public CommuteDAO() {
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
	
	
	
public void joinCommute(JSP.Commute user) throws SQLException {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("insert into commuteinfo values(?,?,?,?,?,?)");
			
			ps.setInt(1, user.getNum());
			ps.setString(2, user.getUserID());
			ps.setString(3, user.getName());
			ps.setString(4, user.getDate());
			ps.setString(5, user.getAttendtime());
			ps.setString(6, user.getClosetime());
			
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
	public void deleteCommute(JSP.Commute user) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("delete from commuteinfo where userID = ?");
			
			ps.setString(1, user.getUserID());
			ps.executeUpdate();
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//변경
	public void updateCommute(String userID, String date, String attendTime, String closeTime) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("update commuteinfo set attendtime = ? and closetime = ?" + "where userID = ? and date = ?");
			
			ps.setString(1, attendTime);
			ps.setString(2, closeTime);
			ps.setString(3, userID);
			ps.setString(4, date);
			ps.executeUpdate();
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//전체선택
	public ArrayList<JSP.Commute> selectAllCommute() {
		ArrayList<JSP.Commute> list = new ArrayList<JSP.Commute>();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from commuteinfo");
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Commute user = new Commute();
				user.setUserID(rs.getString("userID"));
				user.setName(rs.getString("name"));
				user.setDate(rs.getString("date"));
				user.setAttendtime(rs.getString("attendtime"));
				user.setClosetime(rs.getString("closetime"));
	
				list.add(user);
			}
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	//부분선택
	public JSP.Commute selectCommute(String userID) {
		
		JSP.Commute user = new JSP.Commute();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from commuteinfo where userID = ?");
			ps.setString(1, userID);
			
			ResultSet rs = ps.executeQuery();
			rs.next();

			user.setUserID(rs.getString("userID"));
			user.setName(rs.getString("name"));
			user.setDate(rs.getString("date"));
			user.setAttendtime(rs.getString("attendtime"));
			user.setClosetime(rs.getString("closetime"));
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return user;
	}	

}
