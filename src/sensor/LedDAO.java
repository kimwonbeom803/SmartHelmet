package sensor;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class LedDAO {

Connection conn;
	
	//연결하는 작업
	public LedDAO() {
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
	
	
	public void joinLed(Led led) throws SQLException {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("insert into sensorled values(?,?)");
			
			ps.setString(1, led.getUserID());
			ps.setInt(2, led.getOutputLED());
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
	public void deleteLed(Led led) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("delete from sensorled where userID =?");
			
			ps.setString(1, led.getUserID());
			ps.executeUpdate();
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//변경
	public void updateLed(String id, int value, String where) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("update sensorled set userID = ?, OutputLED = ?" + "where userID = ?");
			
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
	public ArrayList<Led> selectAllLed() {
		ArrayList<Led> list = new ArrayList<Led>();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from sensorled");
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				/////여기서부터
				Led led = new Led();
				led.setUserID(rs.getString("userID"));
				led.setOutputLED(rs.getInt("OutputLED"));
				
				list.add(led);
			}
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//부분 선택
	public sensor.Led selectLed(String where) {
		
		sensor.Led led = new sensor.Led();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from sensorled where userID = ?");
			ps.setString(1, where);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			led.setUserID(rs.getString("userID"));
			led.setOutputLED(rs.getInt("OutputLED"));
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return led;
	}
}
