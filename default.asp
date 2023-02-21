<!-- #include file="open_db.asp"-->
<html>

<HEAD>
  <TITLE>Levyjenhallinta ª P‰‰sivu</TITLE>
  <META name="description" content="www.levynhallinta">
  <META name="keywords" content="levylistaus">
  <link rel="icon" href="images/rake.ico" type="image/ico"/>
  <link href="screen.css" rel="stylesheet" media="screen" type="text/css"/>
</HEAD>

<body leftmargin="0" rightmargin="0" marginheight="0" marginwidth="0" bgcolor="#F0F0E1" background="images/betoni.gif">

<div align="center">
  <table border="0" width="85%" cellspacing="0" cellpadding="0" background="images/topbkg.jpg">
  <tr>
    <center>
      <td width="34%"><img border="0" src="images/topleft.jpg"></td>
      <td width="33%"><img border="0" src="images/logo.jpg"></td>
    
    <td width="33%">
      <p align="right"><img border="0" src="images/topright.jpg"></td>
  </tr>
  </table>
</div>
<center>
<div class="teksti">
<div class="linkit">
	<ul>
	<li><a href="default.asp">Etusivu</a></li>
	<li><%if session("Login")<>"Ok" then %>
    <a href="login.asp">Login</a>
<%else %>
    <a href="logout.asp">Logout</a>
<%end if %></li>
	<li><a href="yhteys.html">Yhteys</a></li>
	
	</ul>
</div>


<form action="default.asp" method="get">
<table border="0" width="100%">
<tr>
<td width="25%"> </td>
<td width="25%" align="right">Hakusana:</td>
<td width="25%"><input type="text" name="hakuArvo" value="<%=request("hakuArvo")%>" /></td>
<td width="25%" align="right"></td>
</tr>
<tr>
<td></td>
<td align="right"></td>
<td>



</td>
<td></td>
</tr>
<tr>
<td></td>
<td align="right"></td>
<td>
</td>
<td></td>
</tr>
<tr>
<td></td>
<td></td>
<td><input type="submit" name="haeNappi" value="Hae" /><%if session("login")<>"" then 'Jos kirjautuminen on tapahtunut...%> 
    <input type="button" value=" Lis‰‰ " onclick="document.location='lisaa.asp'" />
<%end if%> </td>
<td>
</td>
</tr>
</table>
</form>
<%
'Rakennetaan perus - SQL -lause
SqlStr="SELECT * FROM levyt"

'Lis‰t‰‰n lauseeseen hakuehto, jos on olemassa URL:ssa
if request("hakuArvo")<>"" then 'Jos hakuArvo Id ollut muuta kuin tyhj‰
    sqlstr=sqlstr & " WHERE (artisti_id LIKE '%"&request("hakuArvo")&"%' OR levyn_nimi LIKE '%"&request("hakuArvo")&"%' OR genre_id LIKE '%"&request("hakuArvo")&"%' OR julkaisuvuosi LIKE '%"&request("hakuArvo")&"%') OR kustantaja_id LIKE '%"&request("hakuArvo")&"%'"
    SqlStr=SqlStr & " AND Poistettu=0 ORDER BY artisti_id"
else
    SqlStr=SqlStr & " WHERE Poistettu=0 ORDER BY artisti_id"
end if

'response.Write sqlstr
'Lis‰t‰‰n lauseeseen kategoria, jos on olemassa
'if request("Kategoria_id")<>"" then 
 '   if request("Kategoria_id")<>1 then
  '      SqlStr=SqlStr & " AND C.Category_id=" & request("Kategoria_id")
  '  end if
'end if

'Lis‰t‰‰n lauseeseen tyyppi, jos on olemassa
'if request("genre_id")<>"" then
    'if request("genre_id")<>1 then
        'SqlStr=SqlStr & " AND genre_id=" & request("genre_id")
    'end if
'end if

objRs.Open Sqlstr, objConn,1,3   'Kyselyn toteuttaminen
do while not objRs.EOF
    response.Write(vbcrlf & "<br /><br /><table border='0' width='100%'>")
    response.Write("<tr><td width='25%'></td><td colspan='2' class='mainHeader'>"&objRs("artisti_id")&"   -   "&objRs("levyn_nimi")&"</td><td width='25%'></td></tr>")
    if session("login")<>"" then 'Onko login tapahtunut?
        response.Write("<tr><td></td><td width='25%' rowspan='4' align='center'><img height='250' src='levyt_images/"&objRs("image")&"' /></td><td class='header'>Artisti: "&objRs("artisti_id")&"</td><td><input type='button' value='Poista' onclick=""document.location='poista.asp?artisti_id="&objRs("levyn_nimi")&"&levyn_nimi="&objRs("levyn_nimi")&"'"" /></td></tr>")
    else    'ei ole
        response.Write("<tr><td></td><td width='25%' rowspan='4' align='center'><img height='250' src='levyt_images/"&objRs("image")&"' /></td><td class='header'>Artisti: "&objRs("artisti_id")&"</td><td></td></tr>")
    end if
    'response.Write("<tr><td></td><td class='header'>Artisti: "&objRs("artisti_id")&"</td><td></td></tr>")
    response.Write("<tr><td></td><td class='header'>Genre: "&objRs("genre_id")&"</td><td></td></tr>")
    response.Write("<tr><td></td><td class='header'>Julkaisuvuosi: "&objRs("julkaisuvuosi")&"</td><td></td></tr>")
    response.Write("<tr><td></td><td class='header' colspan='2'>Kustantaja: "&objRs("kustantaja_id")&"</td><td></td></tr>")
    response.Write("</table>")
    objRs.MoveNext
loop
objRs.Close
 %>





<br><br>
<div class="kuva">

</div>
              
		
		</p>
<br><br><br>
     
        <font face="Arial" size="1"></font>
    </div>


<div class="alapalkki">
<center><font face="Arial" size="1">Levyjenhallinta j‰rjestelm‰ - © 2007 Jarno Ker‰nen</center>
</font>

</div>

</center>
</CENTER>


</body>
</html>
<%objConn.Close%>
