<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <%!
           public class DBConnection{
            String DB_URL_Aadhaar = "jdbc:mysql://192.168.137.1/i4c";
            String user = "sharmada";
            String pass = "";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            String username ="";
            String userDOB = "";
 
            public int AadharVerification(String UID,String NameEntered, String DOBEntered) throws Exception{
                int result=0;
                int uid = Integer.parseInt(UID);
               try{
                    System.out.println("I'm Here");
                    Class.forName("com.mysql.jdbc.Driver");
                    System.out.println("I'm Here again");
                    conn = DriverManager.getConnection(DB_URL_Aadhaar, user, pass);
                    System.out.println("Again I'm Here again");
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT name,dob FROM aadhar WHERE id = "+uid+" ;");
                    while(rs.next()){
                        username = rs.getString("name");
                        userDOB = rs.getString("dob");
                    }
                    if((username.equalsIgnoreCase(NameEntered))&&(userDOB.equalsIgnoreCase(DOBEntered))){
                           
                            result=1;
                    }
                    else{
                    System.out.println(username+" "+NameEntered+" "+userDOB+" "+DOBEntered+" ");
                    System.out.println("Incorrect UID,Name/DOB combination"); 
                    }
                    System.out.println("Success");
                }catch(Exception e){
                        e.printStackTrace();
                    }
return result;            
}
}
%>
<%
    int res=0;
    String name = request.getParameter("username");
    String dob = request.getParameter("userdob");
    String uid = request.getParameter("userUID");
    DBConnection obj = new DBConnection();
    res=obj.AadharVerification(uid,name,dob);
    if(res==1){
%>
<script type="text/javascript">
    window.location.href = "two.html";
</script>
<%
    }
else{
%>
<script type="text/javascript">
    alert("Incorrect UID combination");
    window.location.href="one.html";
</script>
<%
}
%>
    </body>
</html>
