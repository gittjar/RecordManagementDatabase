<!-- #include file="open_db.asp"-->
<%
'Estet‰‰n sivun luvaton k‰yttˆ
'if session("login")="" then - ei k‰y koska toteutuakseen lause vaatii session -tyyppisen login -nimisen muuttujan, jonka arvo on tyhj‰
if not session("login")<>"" then
    response.Redirect("login.asp")
end if

'Jos Lis‰‰ -nappia on painettu
if request("LisaaNappi")<>"" then
    Session("levyn_nimi")=Request("levyn_nimi")'Asetetaan arvoja tilallisiin muuttujiin
    Session("artisti_id")=Request("artisti_id")
    'julkaisuvuosi=replace(Request("julkaisuvuosi"),",",".")
    Session("julkaisuvuosi")=Request("julkaisuvuosi")
    Session("kustantaja_id")=Request("kustantaja_id")
    Session("genre_id")=Request("genre_id")
    
    if isnumeric(julkaisuvuosi)=false then
        response.Redirect("lisaa.asp?msg=Korjaa julkaisuvuosi")
   ' elseif cdbl(julkaisuvuosi)<1800 or cdbl(julkaisuvuosi)>4000 then
   '   response.Redirect("lisaa.asp?msg=Korjaa julkaisuvuosi")
    end if
    
    SqlStr="INSERT INTO levyt (levyn_nimi,artisti_id,julkaisuvuosi,kustantaja_id,genre_id,poistettu,image) VALUES ('"&request("levyn_nimi")&"','"&request("artisti_id")&"',"&request("julkaisuvuosi")&",'"&request("kustantaja_id")&"','"&request("genre_id")&"',0,'"&session("photograph")&"')"
    'SqlStr="INSERT INTO levyt (levyn_nimi,artisti_id,julkaisuvuosi,kustantaja_id,genre_id,poistettu,image) VALUES ('"&request("levyn_nimi")&"','"&request("artisti_id")&"',"&request("julkaisuvuosi")&",'"&request("kustantaja_id")&"','"&request("genre_id")&"',0,'"&session("photograph")&"')"
    'response.Write sqlstr
    objConn.Execute SqlStr
    Session("levyn_nimi")=""
    'Session("artisti_id")=""
    Session("julkaisuvuosi")=""
    'Session("kustantaja_id")=""
    'Session("genre_id")=""
    response.Redirect("default.asp")
end if


'Collection luuppi
'for each x in request.Form
'    response.Write(x & "=" & request(x) & "<br />")
'next
%>
<html>
<head>
<title>Lis‰‰ Levy</title>
<link rel="Stylesheet" type="text/css" href="screen.css" />
</head>
<body>
<form action="lisaa.asp" method="post">
<table border="1" width="100%">
<tr>
<td width="25%"></td>
<td width="25%" align="right">Levyn nimi:</td>
<td width="25%"><input type="text" name="levyn_nimi" size="35" value="<%=Session("levyn_nimi")%>" /></td>
<td width="25%"></td>
</tr>
<tr>
<td></td>
<td align="right">Artisti:</td>
<td>
<select name="artisti_id"> 'Luodaan artisti_id -niminen muuttuja
<%
SqlStr="SELECT * FROM artistit"
objRs.Open Sqlstr, objConn,1,3 
do while not objRs.EOF
    if (request("kustantaja_id"))=(objRs("artisti_id")) then   
        response.Write("<option selected value='"&objRs("artisti_id")&"'>"&objRs("artisti_id")&"</option>"&vbcrlf) 'Option Select value j‰tt‰‰ tehdyn valinnan valintaruutuun
    else    
        response.Write("<option value='"&objRs("artisti_id")&"'>"&objRs("artisti_id")&"</option>"&vbcrlf) 'value arvo kulkee piilossa ja j‰lkimm‰inen n‰kyy
    end if
    objRs.MoveNext
loop
objRs.Close
%>
</select>


</td>
<td><%if session("login")<>"" then 'Jos kirjautuminen on tapahtunut...%> 
    <a href="lisaa_artisti.asp"><img border="0" width="35" height="30" src="images/archive.gif" /></a>
<%end if%></td>
</tr>
<tr>
<td width="25%"></td>
<td width="25%" align="right">Julkaisuvuosi:</td>
<td width="25%"><input type="text" name="julkaisuvuosi" size="35" value="<%=Session("julkaisuvuosi")%>" /></td>
<td width="25%"></td>
</tr>
<tr>
<td></td>
<td align="right">Kustantaja:</td>
<td>
<select name="kustantaja_id"> 'Luodaan kustantaja_id -niminen muuttuja
<%
SqlStr="SELECT * FROM kustantajat"
objRs.Open Sqlstr, objConn,1,3 
do while not objRs.EOF
    if (request("kustantaja_id"))=(objRs("kustantaja_id")) then   
        response.Write("<option selected value='"&objRs("kustantaja_id")&"'>"&objRs("kustantaja_id")&"</option>"&vbcrlf) 'Option Select value j‰tt‰‰ tehdyn valinnan valintaruutuun
    else    
        response.Write("<option value='"&objRs("kustantaja_id")&"'>"&objRs("kustantaja_id")&"</option>"&vbcrlf) 'value arvo kulkee piilossa ja j‰lkimm‰inen n‰kyy
    end if
    objRs.MoveNext
loop
objRs.Close
%>
</select>


</td>
<td><%if session("login")<>"" then 'Jos kirjautuminen on tapahtunut...%> 
    <a href="lisaa_kustantaja.asp"><img border="0" width="35" height="30" src="images/archive.gif" /></a>
<%end if%></td>
</tr>



<tr>
<td></td>
<td align="right">Genre:</td>
<td>
<select name="genre_id"> 'Luodaan genre_id -niminen muuttuja
<%
SqlStr="SELECT * FROM genre"
objRs.Open Sqlstr, objConn,1,3 
do while not objRs.EOF
    if (request("genre_id"))=(objRs("genre_id")) then   
        response.Write("<option selected value='"&objRs("genre_id")&"'>"&objRs("genre_id")&"</option>"&vbcrlf) 'Option Select value j‰tt‰‰ tehdyn valinnan valintaruutuun
    else    
        response.Write("<option value='"&objRs("genre_id")&"'>"&objRs("genre_id")&"</option>"&vbcrlf) 'value arvo kulkee piilossa ja j‰lkimm‰inen n‰kyy
    end if
    objRs.MoveNext
loop
objRs.Close
%>
</select>



</td>
<td><%if session("login")<>"" then 'Jos kirjautuminen on tapahtunut...%> 
    <a href="lisaa_genre.asp"><img border="0" width="35" height="30" src="images/archive.gif" /></a>
<%end if%> </td>
</tr>
<td></td>
<td align="right">Kuva:</td>
<td>
<iframe frameborder="0" src="upload/uploadtester.asp"></iframe>
</td>
<td></td>
</tr>
<tr>
<td></td>
<td></td>
<td>
<input type="submit" value=" Lis‰‰ " name="LisaaNappi" />
<input type="button" value="Peruuta" onclick="history.back(-1)" />
</td>
<td class="error"><%=request("msg")%></td>
</tr>
</table>
</form>
</body>
</html>
<%objConn.Close%>