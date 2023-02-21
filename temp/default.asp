<!-- #include file="open_db.asp"-->
<html>
<head>
<title>Alko</title>
<link rel="Stylesheet" type="text/css" href="main.css" />
</head>
<body>
<form action="default.asp" method="get">
<table border="0" width="100%">
<tr>
<td width="25%"></td>
<td width="25%" align="right">Hakusana:</td>
<td width="25%"><input type="text" name="hakuArvo" value="<%=request("hakuArvo")%>" /></td>
<td width="25%" align="right"><a href="login.asp">Login</a></td>
</tr>
<tr>
<td></td>
<td align="right">Genre:</td>
<td>
<select name="Genre_id"> 'Luodaan Genre_id -niminen muuttuja
<%
SqlStr="SELECT * FROM genre"
objRs.Open Sqlstr, objConn,1,3 
do while not objRs.EOF
    if cint(request("Genre_id"))=cint(objRs("genre_id")) then   'Kategoria_id valinta tutkitaan cint requestilla
        response.Write("<option selected value='"&objRs("genre_id")&"'></option>"&vbcrlf) 'Option Select value j‰tt‰‰ tehdyn valinnan valintaruutuun
    else    
        response.Write("<option value='"&objRs("genre_id")&"'></option>"&vbcrlf)
    end if
    objRs.MoveNext
loop
objRs.Close
%>
</select>
</td>
<td></td>
</tr>
<tr>
<td></td>
<td align="right">Tyyppi:</td>
<td>
<select name="Tyyppi_id">   'Luodaan Tyyppi_id -niminen muuttuja
<%
SqlStr="SELECT * FROM Types"   'SQL puolen koodia
objRs.Open Sqlstr, objConn,1,3 
do while not objRs.EOF
    if cint(request("Tyyppi_id"))=cint(objRs("type_id")) then
        response.Write("<option selected value='"&objRs("type_id")&"'>"&objRs("TName")&"</option>"&vbcrlf)
    else
        response.Write("<option value='"&objRs("type_id")&"'>"&objRs("TName")&"</option>"&vbcrlf)
    end if
    objRs.MoveNext
loop
objRs.Close
%>
</select>
</td>
<td></td>
</tr>
<tr>
<td></td>
<td></td>
<td><input type="submit" name="haeNappi" value="Hae" /></td>
<td>
<%if session("login")<>"" then 'Jos kirjautuminen on tapahtunut...%> 
    <input type="button" value=" Lis‰‰ " onclick="document.location='lisaa.asp'" />
<%end if%>
</td>
</tr>
</table>
</form>
<%
'Rakennetaan perus - SQL -lause
SqlStr="SELECT * FROM Categories as C, Drinks as D, Types as T WHERE C.Category_id=D.Category_id AND D.Type_id=T.Type_id AND D.Continued=1"

'Lis‰t‰‰n lauseeseen hakuehto, jos on olemassa URL:ssa
if request("hakuArvo")<>"" then 'Jos hakuArvo Id ollut muuta kuin tyhj‰
    SqlStr=SqlStr & " AND (D.Name LIKE '%"&request("hakuArvo")&"%' OR D.AddInfo LIKE '%"&request("hakuArvo")&"%')"
end if

'Lis‰t‰‰n lauseeseen kategoria, jos on olemassa
if request("Kategoria_id")<>"" then 
    if request("Kategoria_id")<>1 then
        SqlStr=SqlStr & " AND C.Category_id=" & request("Kategoria_id")
    end if
end if

'Lis‰t‰‰n lauseeseen tyyppi, jos on olemassa
if request("Tyyppi_id")<>"" then
    if request("Tyyppi_id")<>1 then
        SqlStr=SqlStr & " AND T.Type_id=" & request("Tyyppi_id")
    end if
end if

objRs.Open Sqlstr, objConn,1,3   'Kyselyn toteuttaminen
do while not objRs.EOF
    response.Write(vbcrlf & "<br /><br /><table border='0' width='100%'>")
    response.Write("<tr><td width='25%'></td><td colspan='2' class='mainHeader'>"&objRs("Name")&"</td><td width='25%'></td></tr>")
    if session("login")<>"" then 'Onko login tapahtunut?
        response.Write("<tr><td></td><td width='25%' rowspan='4' align='center'><img height='250' src='Alko_images/"&objRs("image")&"' /></td><td class='header'>Tuotenro: "&objRs("Drink_id")&"</td><td><input type='button' value='Poista' onclick=""document.location='poista.asp?Drink_id="&objRs("Drink_id")&"&Name="&objRs("Name")&"'"" /></td></tr>")
    else    'ei ole
        response.Write("<tr><td></td><td width='25%' rowspan='4' align='center'><img height='250' src='Alko_images/"&objRs("image")&"' /></td><td class='header'>Tuotenro: "&objRs("Drink_id")&"</td><td></td></tr>")
    end if
    response.Write("<tr><td></td><td class='header'>Kategoria: "&objRs("CName")&"</td><td></td></tr>")
    response.Write("<tr><td></td><td class='header'>Tyyppi: "&objRs("TName")&"</td><td></td></tr>")
    response.Write("<tr><td></td><td class='header'>Tilavuuspros: "&objRs("Vol")*100&" %</td><td></td></tr>")
    response.Write("<tr><td></td><td class='header' colspan='2'>Lis‰tietoja: "&objRs("AddInfo")&"</td><td></td></tr>")
    response.Write("</table>")
    objRs.MoveNext
loop
objRs.Close
 %>
</body>
</html>
<%objConn.Close%>