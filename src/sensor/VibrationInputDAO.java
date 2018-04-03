package sensor;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class VibrationInputDAO {
Connection conn;
	
	//�����ϴ� �۾�
	public VibrationInputDAO() {
		System.setProperty("jdbc.drivers", "com.mysql.jdbc.Driver");
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		String strUrl = "jdbc:mysql://localhost/wkbim11";
		
		try {
			conn = DriverManager.getConnection(strUrl ,"wbkim11","q1w2e3r4");
			conn.setAutoCommit(false);
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void joinVibrationInput(VibrationInput vib) throws SQLException {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("insert into sensorinvibration values(?,?)");
			
			ps.setString(1, vib.getUserID());
			ps.setInt(2, vib.getInputVibrationMeasure());
			ps.addBatch();
			ps.executeBatch();
			ps.close();
			conn.commit();
		}catch(SQLException e) {
			conn.rollback();
			e.printStackTrace();
		}
	}
	//����
	public void deleteVibrationInput(VibrationInput vib) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("delete from sensorinvibration where userID =?");
			
			ps.setString(1, vib.getUserID());
			ps.executeUpdate();
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//����
	public void updateVibration(String id, int value, String where) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("update sensorinvibration set userID = ?, InputVibrationMeasure = ?" + "where userID = ?");
			
			ps.setString(1, id);
			ps.setInt(2, value);
			ps.setString(3, where); //�� where�� userID �� ����
			ps.executeUpdate();
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//��ü ����
	public ArrayList<VibrationInput> selectAllVibrationInput() {
		ArrayList<VibrationInput> list = new ArrayList<VibrationInput>();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from sensorinvibration");
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				/////���⼭����
				VibrationInput vib = new VibrationInput();
				vib.setUserID(rs.getString("userID"));
				vib.setInputVibrationMeasure(rs.getInt("InputVibrationMeasure"));
				
				list.add(vib);
			}
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//�κ� ����
	public sensor.VibrationInput selectVibration(String where) {
		
		sensor.VibrationInput vib = new sensor.VibrationInput();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from sensorinvibration where userID = ?");
			ps.setString(1, where);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			vib.setUserID(rs.getString("userID"));
			vib.setInputVibrationMeasure(rs.getInt("inputVibrationMeasure"));
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return vib;
	}
	
}
