//++++++++
//Copyright © 2002 Macromedia, Inc. All rights reserved.   
//++++++++

// ------------------------------------------------------------
// class NetDebugEvent - base class for all debug events sent from as
// ------------------------------------------------------------
function NetDebugEvent()
{
}
NetDebugEvent.prototype.init = function()
{
	this.EventType = "DebugEvent";
	this.Source = "Client";
	this.MovieUrl = unescape(_root._url);
	this.initDate();
}
NetDebugEvent.prototype.initDate = function()
{
	var now = new Date();
	this.Date = now;
	this.Time = now.getTime();
}
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugErrorEvent - generic internal (to NetDebug) error event
// ------------------------------------------------------------
function NetDebugErrorEvent(dataobj)
{
	this.init();
	this.EventType = "NetDebugError";
	this.Error = dataobj;
}
NetDebugErrorEvent.prototype = new NetDebugEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugTraceEvent - user generated trace event
// ------------------------------------------------------------
function NetDebugTraceEvent(traceobj)
{
	this.init();
	this.EventType = "Trace";
	this.Trace = traceobj;
}
NetDebugTraceEvent.prototype = new NetDebugEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugTraceNetServicesEvent - NetServices generated trace event
// ------------------------------------------------------------
function NetDebugTraceNetServicesEvent(w, s, n, m)
{
	this.init();
	this.EventType = "NetServicesTrace";
	this.Trace = m;
	this.Who = w;
	this.Severity = s;
	this.Number = n;
}
NetDebugTraceNetServicesEvent.prototype = new NetDebugEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugNCEvent - base class for all http NetConnection debug events
// ------------------------------------------------------------
function NetDebugNCEvent()
{
}
NetDebugNCEvent.prototype = new NetDebugEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugResultEvent - NetConnection result received event
// ------------------------------------------------------------
function NetDebugResultEvent(resultobj)
{
	this.init();
	this.EventType = "Result";
	this.Result = resultobj;
}
NetDebugResultEvent.prototype = new NetDebugNCEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugStatusEvent - NetConnection status received event
// ------------------------------------------------------------
function NetDebugStatusEvent(statusobj)
{
	this.init();
	this.EventType = "Status";
	this.Status = statusobj;
}
NetDebugStatusEvent.prototype = new NetDebugNCEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugConnectEvent - NetConnection connect called event
// ------------------------------------------------------------
function NetDebugConnectEvent(args)
{
	this.init();
	this.EventType = "Connect";
	this.ConnectString = args[0];
	if (args[1] != null) {
		this.UserName = args[1];
	}
	if (args[2] != null) {
		this.Password = args[2];
	}
}
NetDebugConnectEvent.prototype = new NetDebugNCEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugCallEvent - NetConnection call called event
// ------------------------------------------------------------
function NetDebugCallEvent(args)
{
	this.init();
	this.EventType = "Call";
	this.MethodName = args[0];
	this.Parameters = new Array();
	for (var i = 2; i < args.length; i++) {
		this.Parameters[i-2] = args[i];
	}
}
NetDebugCallEvent.prototype = new NetDebugNCEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugCloseEvent - NetConnection close called event
// ------------------------------------------------------------
function NetDebugCloseEvent()
{
	this.init();
	this.EventType = "Close";
}
NetDebugCloseEvent.prototype = new NetDebugNCEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugAddHeaderEvent - NetConnection addHeader called event
// ------------------------------------------------------------
function NetDebugAddHeaderEvent(args)
{
	this.init();
	this.EventType = "AddHeader";
	this.HeaderName = args[0];
	this.MustUnderstand = args[1];
	if (args[2] != null) {
		this.HeaderObject = args[2];
	}
}
NetDebugAddHeaderEvent.prototype = new NetDebugNCEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugRtmpLogEvent - RTMP log stream receveived log event
// ------------------------------------------------------------
function NetDebugRtmpLogEvent(infoobj)
{
	this.initDate();
	this.EventType = "Trace";
	this.Source = "RealTime";
	this.Info = infoobj;
	this.Trace = infoobj.description;
}
NetDebugRtmpLogEvent.prototype = new NetDebugNCEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugDuplicateNCDErrorEvent - another NCD is already running
// ------------------------------------------------------------
function NetDebugDuplicateNCDErrorEvent()
{
	this.initDate();
	this.EventType = "Error";
	this.Source = "NCD";
	this.Message = "NCD_ALREADY_RUNNING";
}
NetDebugDuplicateNCDErrorEvent.prototype = new NetDebugNCEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugFailedSendErrorEvent - failed to send event
// ------------------------------------------------------------
function NetDebugFailedSendErrorEvent(ev)
{
	this.initDate();
	this.EventType = "Error";
	this.Source = "NCD";
	this.OriginalEvent = ev;
	this.Message = "NCD_FAILED_TO_SEND_EVENT";
}
NetDebugFailedSendErrorEvent.prototype = new NetDebugNCEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugInfoErrorEvent - received an error that has an info object
// ------------------------------------------------------------
function NetDebugInfoErrorEvent(infoobj, mes)
{
	this.initDate();
	this.EventType = "Error";
	this.Source = "NCD";
	this.Info = infoobj;
	if (mes != null) {
		this.Message = mes;
	}
}
NetDebugInfoErrorEvent.prototype = new NetDebugNCEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugReceiveCallEvent - NetConnection arbirary received event
// ------------------------------------------------------------
function NetDebugReceiveCallEvent(mName, args)
{
	this.init();
	this.EventType = "ReceivedCall";
	this.MethodName = mName;
	this.Parameters = args;
//	this.Parameters = new Array();
//	for (var i = 0; i < args.length; i++) {
//		this.Parameters[i] = args[i];
//	}
}
NetDebugResultEvent.prototype = new NetDebugNCEvent();
// ------------------------------------------------------------

// ------------------------------------------------------------
// function StripNCDEventToMinmal - a global helper function
// ------------------------------------------------------------
_global.StripNCDEventToMinmal = function(ev)
{
	var ret = new Object();
	if (ev.EventType != null) ret.EventType	= ev.EventType	;
	if (ev.Source	 != null) ret.Source	= ev.Source		;
	if (ev.MovieUrl	 != null) ret.MovieUrl	= ev.MovieUrl	;
	if (ev.Date		 != null) ret.Date		= ev.Date		;
	if (ev.Time		 != null) ret.Time		= ev.Time		;
	if (ev.Protocol	 != null) ret.Protocol	= ev.Protocol	;
	if (ev.DebugId	 != null) ret.DebugId	= ev.DebugId	;
	
	return ret;
}
// ------------------------------------------------------------







