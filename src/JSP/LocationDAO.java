package JSP;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class LocationDAO {
Connection conn;
	
	//연결하는 작업
	public LocationDAO() {
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
	
	public void joinLocation(JSP.Location user) throws SQLException {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("insert into locationinfo values(?,?,?,?,?)");
			
			ps.setInt(1, user.getNum());
			ps.setString(2, user.getUserID());
			ps.setString(3, user.getName());
			ps.setDouble(4, user.getLocationx());
			ps.setDouble(5, user.getLocationy());
			
			ps.addBatch();
			ps.executeBatch();
			ps.close();
			conn.commit();
		}catch(SQLException e) {
			conn.rollback();
			e.printStackTrace();
		}
	}
	//갱신(변경)
	public void updateLocation(String userID, double locationX, double locationY) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("update locationinfo set locationx = ? and locationy = ?" + "where userID = ?");
			
			ps.setDouble(1, locationX);
			ps.setDouble(2, locationY);
			ps.setString(3, userID);
			ps.executeUpdate();
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//전체선택
	public ArrayList<JSP.Location> selectAllLocation() {
		ArrayList<JSP.Location> list = new ArrayList<JSP.Location>();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from locationinfo");
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Location user = new Location();
				user.setUserID(rs.getString("userID"));
				user.setName(rs.getString("name"));
				user.setLocationx(rs.getDouble("locationx"));
				user.setLocationy(rs.getDouble("locationy"));
				
				list.add(user);
			}
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	//부분선택
	public JSP.Location selectLocation(String userID) {
		
		JSP.Location user = new JSP.Location();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from locationinfo where userID = ?");
			ps.setString(1, userID);
			
			ResultSet rs = ps.executeQuery();
			rs.next();

			user.setUserID(rs.getString("userID"));
			user.setName(rs.getString("name"));
			user.setLocationx(rs.getDouble("locationx"));
			user.setLocationy(rs.getDouble("locationy"));
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return user;
	}	
}
