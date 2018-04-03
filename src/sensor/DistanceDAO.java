package sensor;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DistanceDAO {
Connection conn;
	
	//연결하는 작업
	public DistanceDAO() {
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
	
	
	public void joinDistance(Distance dis) throws SQLException {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("insert into sensordistance values(?,?)");
			
			ps.setString(1, dis.getUserID());
			ps.setInt(2, dis.getInputDistanceMeasure());
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
	public void deleteDistance(Distance dis) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("delete from sensordistance where userID =?");
			
			ps.setString(1, dis.getUserID());
			ps.executeUpdate();
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//변경
	public void updateDistance(String id, int value, String where) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("update sensordistance set userID = ?, InputDistanceMeasure = ?" + "where userID = ?");
			
			ps.setString(1, id);
			ps.setInt(2, value);
			ps.setString(3, where); //요 where에 userID 값 삽입
			ps.executeUpdate();
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//전체 선택
	public ArrayList<Distance> selectAllDistance() {
		ArrayList<Distance> list = new ArrayList<Distance>();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from sensordistance");
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				/////여기서부터
				Distance dis = new Distance();
				dis.setUserID(rs.getString("userID"));
				dis.setInputDistanceMeasure(rs.getInt("InputDistanceMeasure"));
				
				list.add(dis);
			}
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//부분 선택
	public sensor.Distance selectLed(String where) {
		
		sensor.Distance dis = new sensor.Distance();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from sensordistance where userID = ?");
			ps.setString(1, where);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			dis.setUserID(rs.getString("userID"));
			dis.setInputDistanceMeasure(rs.getInt("InputDistanceMeasure"));
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return dis;
	}
}
