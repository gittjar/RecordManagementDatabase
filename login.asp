<!-- #include file="open_db.asp" -->
<%
if request("uid")<>"" then 'Button has been pressed
    uid=request("uid")
    pwd=request("pwd")
    if uid<>"" and pwd<>"" then
        SqlStr="SELECT * FROM login WHERE uid='"&uid&"' AND pwd='"&pwd&"'"
        objRs.open SqlStr, objConn,1,3
        if not objRs.EOF then
            Session("Login")="Ok"
            response.Redirect("default.asp")
        else
            response.Redirect("login.asp?msg=No match for the uid/pwd!")
        end if
        objRs.Close
        objConn.Close
    else
        response.Redirect("login.asp?msg=Give both values!")
    end if
end if


 %>
<html>
<head>
<title>Login</title>
<link rel="stylesheet" type="text/css" href="screen.css" />
<script>
function Tarkasta(){
    if(MyForm.uid.value==""){
        MyForm.uid.focus()
        alert("Täytä Tunnus!")
    }else if(MyForm.pwd.value==""){
        MyForm.pwd.focus()
        alert("Täytä Salasana!")
    }else{
        MyForm.submit()
    }
}
</script>
</head>
<body onload="MyForm.uid.focus()">
<form action="login.asp" method="post" name="MyForm">
<table border="0" width="100%">
<tr>
<td width="25%"></td>
<td width="20%"></td>
<td class="passu">Kirjautuminen</td>
<td width="25%"></td>
</tr>
<tr>
<td></td>
<td class="passu">Tunnus:</td>
<td><input type="text" name="uid" /></td>
<td></td>
</tr>
<tr>
<td></td>
<td class="passu">Salasana:</td>
<td><input type="password" name="pwd" /></td>
<td></td>
</tr>
<tr>
<td></td>
<td></td>
<td><input type="button" value="Login" name="Nappi" class="btn" onclick="Tarkasta()" /></td>
<td></td>
</tr>
<tr>
<td></td>
<td></td>
<td class="passu"><%=request("msg")%></td><!--Luetaan virhe URL:sta-->
<td></td>
</tr>
</table>
</form>
</body>
</html>
