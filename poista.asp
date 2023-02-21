<!-- #include file="open_db.asp"-->
<%
'Estetään sivun luvaton käyttö
'if session("login")="" then - ei käy koska toteutuakseen lause vaatii session -tyyppisen login -nimisen muuttujan, jonka arvo on tyhjä
if not session("login")<>"" then
    response.Redirect("login.asp")
end if

if request("poistanappi")<>"" then  'Poisto on vahvistettu
    SqlStr="UPDATE levyt SET poistettu=1 WHERE levyn_nimi='"&request("levyn_nimi")&"'"
    'response.Write(SqlStr)
    objConn.execute SqlStr
    response.Redirect("default.asp")
end if
%>
<html>
<head>
<title>Levyjen hallinta</title>
<link rel="Stylesheet" type="text/css" href="main.css" />
</head>
<body>
<center>
<form action="poista.asp" method="get">
Poista levy <%response.Write(request("levyn_nimi")& " - " & request("levyn_nimi") & "?")%>
<input type="hidden" name="levyn_nimi" value="<%=request("levyn_nimi")%>" />
<input type="submit" value="Vahvista" name="poistanappi" />
<input type="button" value="Peruuta" onclick="history.back(-1)" />
</form>
</center>
</body>
</html>
<%objConn.Close%>