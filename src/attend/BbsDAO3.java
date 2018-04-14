package attend;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BbsDAO3 {

	private Connection conn;
	private ResultSet rs;

	public BbsDAO3() {
		try {
			String dbURL = "jdbc:mysql://localhost/wbkim11";
			String dbID = "wbkim11";
			String dbPassword = "q1w2e3r4";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	public int getNext() {
		String SQL = "SELECT bbsID2 FROM commuteinfo ORDER BY bbsID2 DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1; 
	}


	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM commuteinfo WHERE userID < ?; ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public ArrayList<Bbs3> getList(int pageNumber) {
		String SQL = "SELECT * FROM commuteinfo;";
		ArrayList<Bbs3> list = new ArrayList<Bbs3>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			
			//pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs3 bbs = new Bbs3();
				bbs.setUserID2(rs.getString(1));
				bbs.setAttendTime(rs.getString(3));
				bbs.setCloseTime(rs.getString(4));
				
				System.out.println("?òÎÉê");
				list.add(bbs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}
