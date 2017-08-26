
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> JSP Page</title>
    </head>
    <body>
       <%!
           public class DBConnection{
            String DB_URL_Aadhaar = "jdbc:mysql://192.168.137.1:3306/i4c";
            String user = "sharmada";
            String pass = "";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
 
            public int SubmitDocuments(String sender,String receiver, String link, String body) throws Exception{
                //int uid = Integer.parseInt(sender);
                int mgid=0;
                int result=0;
                int id=0;
               try{
                    System.out.println("Somethimg happening here...");
                    Class.forName("com.mysql.jdbc.Driver");
                    System.out.println("Somethimg happening here too...");
                    conn = DriverManager.getConnection(DB_URL_Aadhaar,user, pass);
                    System.out.println("Somethimg happening here too Database done...");
                    stmt = conn.createStatement();

                    //statement to crete message ID
                    ResultSet rs = stmt.executeQuery("select msgid from pgint");
                    while(rs.next()){
                         id = rs.getInt(1);
                        }
                    mgid=id+1;
                    
                    //statement to insert data
                    System.out.println(id);
                    System.out.println("Again Somethimg happening here...");
                    stmt.executeUpdate("INSERT INTO `pgint` (`msgid`, `dptid`, `uid`, `empid`, `sub`, `body`,`digilink`, `appli`, `estampid`, `sdate`, `pdate`, `status`, `currentemprank`) VALUES ('"+mgid+"', 'EDNPY01', '"+sender+"', '"+receiver+"', 'Applying for High school marksheet','"+body+"', '"+link+"', NULL, 2346 , CURDATE(), NULL, 'UR', '1');;");
                    result = 1;
                    System.out.println("Sucess happening here...");
                }catch(Exception e){
                        e.printStackTrace();
                    }
return result;            
}
}
%>
<%
    int res=0;
    String departmentID = "";
    String receiver = request.getParameter("reciever");
    String sender = request.getParameter("sender");
    String link = request.getParameter("link1");
    String body = request.getParameter("txt");
    DBConnection obj = new DBConnection();
    res=obj.SubmitDocuments(sender,receiver,link,body);
    if(res==1){
%>
<script type="text/javascript">
    window.location.href = "Index.html";
</script>
<%
    }
else{
%>
<script type="text/javascript">
    alert("Incorrect UID combination");
    window.location.href="two.html";
</script>
<%
    }
%>
    </body>
</html>
