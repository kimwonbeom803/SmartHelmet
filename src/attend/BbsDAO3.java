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
                  bbs.setDate(rs.getString(2));
                  bbs.setAttendTime(rs.getString(3));
                  bbs.setCloseTime(rs.getString(4));
                  
               
                  list.add(bbs);
               }
            } catch (SQLException e) {
               e.printStackTrace();
            }
            return list;
         }
         
         public ArrayList<Bbs3> getSearchList(int pageNumber , String attendTime, String closeTime) {
            String SQL = "select * from commuteinfo where date between ? and ?  ";
            ArrayList<Bbs3> list = new ArrayList<Bbs3>();
                  try {
                     
                     PreparedStatement pstmt = conn.prepareStatement(SQL);
                     
                     pstmt.setString(1,attendTime);
                     
                     System.out.println("�����ϴµ� 1"+attendTime);
                     pstmt.setString(2,closeTime);
                     
                     System.out.println("�����ϴµ� 2"+closeTime);
                     
                     rs = pstmt.executeQuery();
                     
                     
                     while (rs.next()) {
                        Bbs3 bbs = new Bbs3();
                       bbs.setUserID2(rs.getString(1));
                     bbs.setDate(rs.getString(2));
                     bbs.setAttendTime(rs.getString(3));
                     bbs.setCloseTime(rs.getString(4));
                        
                        list.add(bbs);
                     }
                  }
                     
                  catch (Exception e) {
                  
                  e.printStackTrace();
                  }
            
                  
            return list;
            
         }
         
         public ArrayList<Bbs3> getManageSearchList(int pageNumber ,String userID, String attendTime, String closeTime) {
            String SQL = "select * from commuteinfo where userID = ? and date between ? and ?  ";
            
            ArrayList<Bbs3> list = new ArrayList<Bbs3>();
                  try {
                     
                     PreparedStatement pstmt = conn.prepareStatement(SQL);
                     
                     pstmt.setString(1,userID);
                     
                     System.out.println("�����ϴµ� "+userID);
                     
                     pstmt.setString(2,attendTime);
                     
                     System.out.println("�����ϴµ� "+attendTime);
                     pstmt.setString(3,closeTime);
                     
                     System.out.println("�����ϴµ� "+closeTime);
                     
                     rs = pstmt.executeQuery();
                     
                     
                     while (rs.next()) {
                        Bbs3 bbs = new Bbs3();
                        bbs.setUserID2(rs.getString(1));
                        bbs.setDate(rs.getString(2));
                        bbs.setAttendTime(rs.getString(3));
                        bbs.setCloseTime(rs.getString(4));
                        System.out.println("����ȴ� ���� ");
                        list.add(bbs);
                     }
                  }
                     
                  catch (Exception e) {
                  
                  e.printStackTrace();
                  }
            
                  
            return list;
            
         }
      }