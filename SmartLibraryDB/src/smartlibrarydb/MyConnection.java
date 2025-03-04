/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package smartlibrarydb;
//import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import java.sql.*;
/**
 *
 * @author ADMIN
 */
public class MyConnection {
    public static Connection getConnection(){
       Connection con = null;
        try{
            // Load SQL Server JDBC driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // Thông tin kết nối
            //String url = "jdbc:sqlserver://LAPTOP-MQTM9T7O:1433;databaseName=SmartLibraryDB;encrypt=false";//tên server
            String url = "jdbc:sqlserver://MSI:1433;databaseName=SmartLibraryDB;encrypt=false";
            //String url = "jdbc:sqlserver://DESKTOP-KBL7R8G:1433;databaseName=SmartLibraryDB;encrypt=false";
            String user = "sa";
            String password = "123456";//pass
            // Kết nối
            con = DriverManager.getConnection(url, user, password);
           return con;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public static ResultSet executeQuery(String query) {
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            con = MyConnection.getConnection();
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);
            return rs;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
        
}
    //    var server = "MSI";
//        var user = "sa";
//        var password = "123456";
//        var db = "SmartLibraryDB";
//        var port = 1433;
//        SQLServerDataSource ds = new SQLServerDataSource();
//        ds.setUser(user);
//        ds.setServerName(server);
//        ds.setPassword(password);
//        ds.setDatabaseName(db);
//        ds.setPortNumber(port);
//        ds.setEncrypt(false);
//        try (Connection conn = ds.getConnection()) {
//            System.out.println("ket noi thanh cong");
//        } catch (Exception e) {
//            e.printStackTrace();
//        }


