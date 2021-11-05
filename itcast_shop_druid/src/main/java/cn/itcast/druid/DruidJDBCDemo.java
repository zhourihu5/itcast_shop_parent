package cn.itcast.druid;

import java.sql.*;
import java.util.Properties;

/**
 * 使用jdbc的方式连接Druid
 */
public class DruidJDBCDemo {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        //1：加载Druid的JDBC驱动
        Class.forName("org.apache.calcite.avatica.remote.Driver");

        //2：获取Druid的JDBC连接方式
        Connection connection = DriverManager.getConnection("jdbc:avatica:remote:url=http://node1:8888/druid/v2/sql/avatica/", new Properties());

        //3：创建statement
        Statement statement = connection.createStatement();

        //4：执行sql查询
//        ResultSet resultSet = statement.executeQuery("select * from \"metrics-kafka\"");
        ResultSet resultSet = statement.executeQuery("SELECT\n" +
                "  TABLE_NAME,\n" +
                "  COUNT(*) AS \"Count\"\n" +
                "FROM INFORMATION_SCHEMA.TABLES\n" +
                "GROUP BY 1\n" +
                "ORDER BY 2 DESC");

        //5：遍历查询结果
        while (resultSet.next()){
//            String user = resultSet.getString("url");
            String user = resultSet.getString("TABLE_NAME");
            System.out.println(user);
        }

        //6：关闭连接
        resultSet.close();
        statement.close();
        connection.close();
    }
}
