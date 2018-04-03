package sensor;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class VibrationDAO {

Connection conn;
	
	//연결하는 작업
	public VibrationDAO() {
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
	
	
	public void joinVibration(Vibration vib) throws SQLException {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("insert into sensorvibration values(?,?)");
			
			ps.setString(1, vib.getUserID());
			ps.setInt(2, vib.getOutputVibration());
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
	public void deleteVibration(Vibration vib) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("delete from sensorvibration where userID =?");
			
			ps.setString(1, vib.getUserID());
			ps.executeUpdate();
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//변경
	public void updateVibration(String id, int value, String where) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("update sensorvibration set userID = ?, OutputVibration = ?" + "where userID = ?");
			
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
	public ArrayList<Vibration> selectAllVibration() {
		ArrayList<Vibration> list = new ArrayList<Vibration>();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from sensorvibration");
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				/////여기서부터
				Vibration vib = new Vibration();
				vib.setUserID(rs.getString("userID"));
				vib.setOutputVibration(rs.getInt("OutputVibration"));
				
				list.add(vib);
			}
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//부분 선택
	public sensor.Vibration selectVibration(String where) {
		
		sensor.Vibration vib = new sensor.Vibration();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from sensorvibration where userID = ?");
			ps.setString(1, where);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			vib.setUserID(rs.getString("userID"));
			vib.setOutputVibration(rs.getInt("OutputVibration"));
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return vib;
	}
	
}
