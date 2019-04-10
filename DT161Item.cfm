<cfparam name="url.ID" default="0">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 161</title>
</head>

<frameset rows="130,*" cols="*" framespacing="0" frameborder="no" border="0">
  <frameset rows="*" cols="*,250,443,*" framespacing="0" frameborder="no" border="0">
  <frame src="DT161Blank.cfm" name="DT161blank1" id="DT161blank1" noresize="noresize" scrolling="No" />
  <frame src="DT161ItemHead.cfm" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" />
  <frame src="DT161PlayFrame.cfm" name="DT161preplay" id="DT161preplay" noresize="noresize" scrolling="No" />
  <frame src="DT161Blank.cfm" name="DT161blank2" id="DT161blank2" noresize="noresize" scrolling="No" />
</frameset>
<frameset rows="*" cols="*,693,*" framespacing="0" frameborder="no" border="0">
  <frame src="DT161Blank.cfm" name="DT161blankleft" id="DT161blankright" noresize="noresize" scrolling="No" />
  <cfoutput><frame src="DT161ItemBody.cfm?ID=#url.ID#" name="DT161body" id="DT161body" noresize="noresize" scrolling="No" /></cfoutput>
  <frame src="DT161Blank.cfm" name="DT161blankright" id="DT161blankright" noresize="noresize" scrolling="No" />
</frameset>
</frameset>
<noframes><body>
</body>
</noframes></html>
