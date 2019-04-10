<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body onload="javascript: submitform()">
<form name="myform" action="handle-data.php">
<input type="submit" name="submit" value="submit" />
Search: <input type='text' name='query'>
<A href="javascript: submitform()">Search</A>
</form> 
<SCRIPT language="JavaScript">
function submitform()
{
  document.myform.submit();
}
</SCRIPT> 
</body>
</html>
