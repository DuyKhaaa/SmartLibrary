/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package smartlibrarydb;
import Base.Login;
//import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import java.sql.*;
/**
 *
 * @author ADMIN
 */
public class SmartLibraryDB {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        MyConnection con = new MyConnection();
        if (con.getConnection() != null) {
            System.out.println("Kết nối thành công");
            Login fm = new Login();
            fm.show();
        } else {
            System.out.println("Kết nối thất bại !!");
        }
    }
    
}
