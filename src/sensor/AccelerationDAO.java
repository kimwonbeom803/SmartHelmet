package sensor;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AccelerationDAO {
Connection conn;
	
	//연결하는 작업
	public AccelerationDAO() {
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
	
	
	public void joinAcceleration(Acceleration acc) throws SQLException {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("insert into sensoracceleration values(?,?)");
			
			ps.setString(1, acc.getUserID());
			ps.setInt(2, acc.getInputAccelerationMeasure());
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
	public void deleteAcceleration(Acceleration acc) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("delete from sensoracceleration where userID =?");
			
			ps.setString(1, acc.getUserID());
			ps.executeUpdate();
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//변경
	public void updateAcceleration(String id, int value, String where) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("update sensoracceleration set userID = ?, InputAccelerationMeasure = ?" + "where userID = ?");
			
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
	public ArrayList<Acceleration> selectAllAccelerationd() {
		ArrayList<Acceleration> list = new ArrayList<Acceleration>();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from sensoracceleration");
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				/////여기서부터
				Acceleration acc = new Acceleration();
				acc.setUserID(rs.getString("userID"));
				acc.setInputAccelerationMeasure(rs.getInt("InputAccelerationMeasure"));
				
				list.add(acc);
			}
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//부분 선택
	public sensor.Acceleration selectAcceleration(String where) {
		
		sensor.Acceleration acc = new sensor.Acceleration();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from sensoracceleration where userID = ?");
			ps.setString(1, where);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			acc.setUserID(rs.getString("userID"));
			acc.setInputAccelerationMeasure(rs.getInt("InputAccelerationMeasure"));
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return acc;
	}

}
