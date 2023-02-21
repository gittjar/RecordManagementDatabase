<%@ Language=VBScript %>
<% 
option explicit 
Response.Expires = -1
Server.ScriptTimeout = 600
%>
<!-- #include file="freeaspupload.asp" -->
<%

Dim uploadsDirVar
uploadsDirVar = server.MapPath("\Dynaint_K07_ilta\Ope\Alko\Alko_images") 


function OutputForm()
%>
	
	
    <form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadTester.asp" onSubmit="return onSubmitForm();">
    <table border="0" id="taulu">
    <tr>
    <td>File to be uploaded:</td>
    <td><input name="attach1" type="file" size="10"></td>
    <td rowspan="2">    
    <%if session("photograph")<>"" then%>
		<img src="../levyt_images/<%=session("photograph")%>" height="120"/>
    <%end if%>
    </td>
    </tr>
    <tr>
    <td></td>
    <td align="right" valign="top"><input style="margin-top:4" type=submit value="  Upload "></td>
    </tr>   
    </table>
    </form>
<%
end function

function TestEnvironment()
    Dim fso, fileName, testFile, streamTest
    TestEnvironment = ""
    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    if not fso.FolderExists(uploadsDirVar) then
        TestEnvironment = "<B>Folder " & uploadsDirVar & " does not exist.</B><br>The value of your uploadsDirVar is incorrect. Open uploadTester.asp in an editor and change the value of uploadsDirVar to the pathname of a directory with write permissions."
        exit function
    end if
    fileName = uploadsDirVar & "\test.txt"
    on error resume next
    Set testFile = fso.CreateTextFile(fileName, true)
    If Err.Number<>0 then
        TestEnvironment = "<B>Folder " & uploadsDirVar & " does not have write permissions.</B><br>The value of your uploadsDirVar is incorrect. Open uploadTester.asp in an editor and change the value of uploadsDirVar to the pathname of a directory with write permissions."
        exit function
    end if
    Err.Clear
    testFile.Close
    fso.DeleteFile(fileName)
    If Err.Number<>0 then
        TestEnvironment = "<B>Folder " & uploadsDirVar & " does not have delete permissions</B>, although it does have write permissions.<br>Change the permissions for IUSR_<I>computername</I> on this folder."
        exit function
    end if
    Err.Clear
    Set streamTest = Server.CreateObject("ADODB.Stream")
    If Err.Number<>0 then
        TestEnvironment = "<B>The ADODB object <I>Stream</I> is not available in your server.</B><br>Check the Requirements page for information about upgrading your ADODB libraries."
        exit function
    end if
    Set streamTest = Nothing
end function

function SaveFiles
    Dim Upload, fileName, fileSize, ks, i, fileKey

    Set Upload = New FreeASPUpload
    Upload.Save(uploadsDirVar)

	' If something fails inside the script, but the exception is handled
	If Err.Number<>0 then Exit function

    SaveFiles = ""
    ks = Upload.UploadedFiles.keys
    if (UBound(ks) <> -1) then
        SaveFiles = "<B>Files uploaded:</B> "
        for each fileKey in Upload.UploadedFiles.keys
            SaveFiles = SaveFiles & Upload.UploadedFiles(fileKey).FileName & " (" & Upload.UploadedFiles(fileKey).Length & "B) "
            session("photograph")=Upload.UploadedFiles(fileKey).FileName
            Response.Redirect("uploadTester.asp")
         next
    else
        SaveFiles = "The file name specified in the upload form does not correspond to a valid file in the system."
    end if
end function
%>

<HTML>
<HEAD>
<script>
function onSubmitForm() {
    var formDOMObj = document.frmSend;
    if (formDOMObj.attach1.value == "" && formDOMObj.attach2.value == "" && formDOMObj.attach3.value == "" && formDOMObj.attach4.value == "" )
        alert("Please press the browse button and pick a file.")
    else
        return true;
    return false;
}
function paikka(){
	document.getElementById('taulu').style.position="absolute"
	document.getElementById("taulu").style.top="0"
}
</script>

</HEAD>

<BODY onload="paikka()">

<%
Dim diagnostics
if Request.ServerVariables("REQUEST_METHOD") <> "POST" then
    diagnostics = TestEnvironment()
    if diagnostics<>"" then
        response.write "<div style=""margin-left:20; margin-top:30; margin-right:30; margin-bottom:30;"">"
        response.write diagnostics
        response.write "<p>After you correct this problem, reload the page."
        response.write "</div>"
    else
        response.write "<div style=""margin-left:0; margin-top:0;"">"
        OutputForm()
        response.write "</div>"
    end if
else
    response.write "<div style=""margin-left:0; margin-top:0;"">"
    OutputForm()
    response.write SaveFiles()
    response.write "<br></div>"
end if

%>


</BODY>
</HTML>
