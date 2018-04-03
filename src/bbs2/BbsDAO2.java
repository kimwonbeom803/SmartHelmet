package bbs2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BbsDAO2 {

	private Connection conn;
	private ResultSet rs;

	public BbsDAO2() {
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

	public String getDate() {
		String SQL = "SELECT now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ""; 
	}

	public int getNext() {
		String SQL = "SELECT bbsID2 FROM bbs2 ORDER BY bbsID2 DESC";
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

	public int write(String bbsTitle2, String userID2, String bbsContent2) {
		String SQL = "INSERT INTO bbs2 VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle2);
			pstmt.setString(3, userID2);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent2);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM bbs2 WHERE bbsID2 < ? AND bbsAvailable2 = 1;";
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
	
	public ArrayList<Bbs2> getList(int pageNumber) {
		String SQL = "SELECT * FROM bbs2 WHERE bbsID2 < ? AND bbsAvailable2 = 1 ORDER BY bbsID2 DESC LIMIT 10";
		ArrayList<Bbs2> list = new ArrayList<Bbs2>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs2 bbs = new Bbs2();
				bbs.setBbsID2(rs.getInt(1));
				bbs.setBbsTitle2(rs.getString(2));
				bbs.setUserID2(rs.getString(3));
				bbs.setBbsDate2(rs.getString(4));
				bbs.setBbsContent2(rs.getString(5));
				bbs.setBbsAvailable2(rs.getInt(6));
				list.add(bbs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Bbs2 getBbs(int bbsID) {
		String SQL = "SELECT * FROM bbs2 WHERE bbsID2 = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs2 bbs = new Bbs2();
				bbs.setBbsID2(rs.getInt(1));
				bbs.setBbsTitle2(rs.getString(2));
				bbs.setUserID2(rs.getString(3));
				bbs.setBbsDate2(rs.getString(4));
				bbs.setBbsContent2(rs.getString(5));
				bbs.setBbsAvailable2(rs.getInt(6));
				return bbs;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null; 
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE bbs2 SET bbsTitle2 = ?, bbsContent2 = ? WHERE bbsID2 = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE bbs2 SET bbsAvailable2 = 0 WHERE bbsID2 = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1; 
	}
}
