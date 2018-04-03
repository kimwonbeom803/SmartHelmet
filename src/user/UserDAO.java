package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDAO {

	private Connection conn;
	private ResultSet rs;

	public UserDAO() {
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
			
//¿¬°á
//--------------------------------------------------------------------------------
	
	public int login(String userID, String userPassword) {
		String SQL = "select userPassword from user where userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1;
				else
					return 0;
			}
			return -1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public void joinUser(User user) throws SQLException {
	
		try {
			PreparedStatement pstmt = conn.prepareStatement("insert into user values (?, ?, ?, ?, ?, ?, ?)");
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			pstmt.setString(6, user.getUserBelong());
			pstmt.setString(7, user.getUserAuthority());
			
			pstmt.addBatch();
			pstmt.executeUpdate();
			pstmt.close();
			conn.commit();
			
		} catch (SQLException e) {
			conn.rollback();
			e.printStackTrace();
		}
	
	}
	
	public boolean check(String userID) {
		String sql = "select userID from user";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getString("userID").equals(userID)) {
					return true;
				}
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public void deleteUser(User user) {
		try {
			PreparedStatement ps
			= conn.prepareStatement("delete from user where userID=?");
			
			ps.setString(1, user.getUserID());
			ps.executeUpdate();
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void updateUser(String id, String passwd, String where) {
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("update user set id = ?, passwd = ?" + "where id = ?");
			
			ps.setString(1, id);
			ps.setString(2, passwd);
			ps.setString(3, where);
			ps.executeUpdate();
			ps.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<User> selectAllUser() {
		ArrayList<User> list = new ArrayList<User>();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from user");
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString("userID"));
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserName(rs.getString("userName"));
				user.setUserGender(rs.getString("userGender"));
				user.setUserEmail(rs.getString("userEmail"));
				user.setUserBelong(rs.getString("userBelong"));
				user.setUserAuthority(rs.getString("userAuthority"));
				
				list.add(user);
			}
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public User selectUser(String where) {
		
		User user = new User();
		
		try {
			PreparedStatement ps
			= conn.prepareStatement("select * from user where id = ?");
			ps.setString(1, where);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			user.setUserID(rs.getString("userID"));
			user.setUserPassword(rs.getString("userPassword"));
			user.setUserName(rs.getString("userName"));
			user.setUserGender(rs.getString("userGender"));
			user.setUserEmail(rs.getString("userEmail"));
			user.setUserBelong(rs.getString("userBelong"));
			user.setUserAuthority(rs.getString("userAuthority"));
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return user;
	}
	
	
	
	
	public void MyCommit() {
		try {
			conn.commit();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	protected void finalize() throws Throwable {
		conn.close();
		super.finalize();
	}
}
