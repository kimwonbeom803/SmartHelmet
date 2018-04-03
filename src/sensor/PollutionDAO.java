package sensor;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PollutionDAO {

Connection conn;
	
	//연결하는 작업
	public PollutionDAO() {
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
	
	
	public void joinPollution(Pollution pol) throws SQLException {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("insert into sensorpollution values(?,?)");
			
			ps.setString(1, pol.getUserID());
			ps.setInt(2, pol.getInputPollutionMeasure());
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
	public void deletePollution(Pollution pol) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("delete from sensorpollution where userID =?");
			
			ps.setString(1, pol.getUserID());
			ps.executeUpdate();
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//변경
	public void updatePollution(String id, int value, String where) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("update sensorpollution set userID = ?, InputPollutionMeasure = ?" + "where userID = ?");
			
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
	public ArrayList<Pollution> selectAllPollution() {
		ArrayList<Pollution> list = new ArrayList<Pollution>();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from sensorpollution");
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				/////여기서부터
				Pollution pol = new Pollution();
				pol.setUserID(rs.getString("userID"));
				pol.setInputPollutionMeasure(rs.getInt("InputPollutionMeasure"));
				
				list.add(pol);
			}
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//부분 선택
	public sensor.Pollution selectPollution(String where) {
		
		sensor.Pollution pol = new sensor.Pollution();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from sensorpollution where userID = ?");
			ps.setString(1, where);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			pol.setUserID(rs.getString("userID"));
			pol.setInputPollutionMeasure(rs.getInt("InputPollutionMeasure"));
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return pol;
	}
}
