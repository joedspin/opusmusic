//++++++++
//Copyright © 2002 Macromedia, Inc. All rights reserved.   
//++++++++

// ------------------------------------------------------------
// NetConnection functions - proxy and API functions that attach to NetConnection
// ------------------------------------------------------------
// private functions
NetConnection.prototype.attachDebug = function()
{
	if (!this.m_Attached) {
		this.m_Attached = true;
		this.m_HeaderAdded = false;
		this.m_Config = new NetDebugConfig();
		copyProperties(this.m_Config, getNetDebug().m_Config);
		this.m_Protocol = "none";
		this.m_Id = getNetDebug().addNetConnection(this);
	}
}
NetConnection.prototype.sendDebugEvent = function(eventobj)
{
	// add a protocol entry
	eventobj.Protocol = this.m_Protocol;
	// add a NetConnection instance id
	eventobj.DebugId = this.m_Id;
	
	return getNetDebug().onEvent(eventobj);
}
NetConnection.prototype.sendServerEvent = function(eventobj)
{
	// set the Url
	eventobj.MovieUrl = unescape(_root._url);
	if (!this.sendDebugEvent(eventobj)) {
		// can't report error in test movie
		//trace("NetConnection.sendServerEvent - Failed to sendDebugEvent");
	}
}
NetConnection.prototype.sendClientEvent = function(eventobj)
{
	if (this.m_Config.m_debug && this.m_Config.client.m_debug) {
		if ((this.m_Config.client.http && this.m_Protocol == "http") ||
			(this.m_Config.client.rtmp && this.m_Protocol == "rtmp")) {			
			if (!this.sendDebugEvent(eventobj)) {
				// can't report error in test movie
				//trace("NetConnection.sendClientEvent - Failed to sendDebugEvent");
			}
		}
	}
}
NetConnection.prototype.addNetDebugHeader = function()
{
	if (!this.m_HeaderAdded) {		
		this.m_HeaderAdded = true;
		if (this.m_Config.m_debug && this.m_Config.app_server.m_debug && this.m_Protocol == "http") {	
			// add our debug header -- tells the server to send back debug info
			// avoid creating a client add header event
			this.realaddHeader("amf_server_debug", true, this.m_Config.app_server);
		} else {	
			// config has been updated to turn off debugging, need to remove header
			this.realaddHeader("amf_server_debug", true, undefined);
		}
	}
}
NetConnection.prototype.updateConfig = function(config)
{
	this.attachDebug();	
	copyProperties(this.m_Config, config);
	this.m_HeaderAdded = false;
}
NetConnection.prototype.isRealTime = function()
{
	return (this.m_Config.m_debug && this.m_Config.realtime_server.m_debug &&
			this.m_Protocol == "rtmp");
}
NetConnection.prototype.setupRecordset = function()
{
	this.attachDebug();
	this.m_Config.client.http = this.m_Config.client.recordset;
}
// Proxy functions
function netDebugProxyConnect()
{
	this.attachDebug();
	// process client side built in debug
	var proto = arguments[0].substr(0, 4);
	if (proto == "http" || proto == "rtmp") {
		this.m_Protocol = proto;
	} else {
		// default to http
		this.m_Protocol = "http";
	}
	this.sendClientEvent(new NetDebugConnectEvent(arguments));
	// start a realtime trace if necessary
	if (this.isRealTime()) {
		this.m_ConnectString = arguments[0];
		getNetDebug().sendCommand(new StartRTMPTraceCommand(arguments[0]));
		var ret = this.realconnect.apply(this, arguments);
		this.realcall("@getClientID", new RTMPClientIDResponse(arguments[0], this));
		return ret;	
	}
	// do the connect
	return this.realconnect.apply(this, arguments);
}
function netDebugProxyCall()
{
	this.attachDebug();
	this.sendClientEvent(new NetDebugCallEvent(arguments));
	this.addNetDebugHeader();
	if (this.m_Config.app_server) {
		// Pass through the call with our wrapper response object
		arguments[1] = new NetDebugResponseProxy(this, arguments[1]);
		return this.realcall.apply(this, arguments);
	} else {
		// No Server debug, just call through without inserting our proxy response object
		return this.realcall.apply(this, arguments);
	}
}
function netDebugProxyClose()
{
	this.attachDebug();
	this.sendClientEvent(new NetDebugCloseEvent());
	// stop realtime trace if necessary
	if (this.isRealTime()) {
		getNetDebug().sendCommand(new StopRTMPTraceCommand(this.m_ConnectString, this.m_ClientId));
	}
	var ret = this.realclose();
	getNetDebug().removeNetConnection(this);
	return ret;
}
function netDebugProxyAddHeader()
{
	this.attachDebug();
	this.sendClientEvent(new NetDebugAddHeaderEvent(arguments));
	return this.realaddHeader.apply(this, arguments);
}
//
// Developer API
//
NetConnection.prototype.setDebugId = function(id)
{
	this.attachDebug();
	this.m_Id = id;
}
NetConnection.prototype.getDebugId = function()
{
	this.attachDebug();
	return this.m_Id;
}
NetConnection.prototype.trace = function(traceobj)
{
	this.attachDebug();
	if (this.m_Config.m_debug && this.m_Config.client.m_debug && this.m_Config.client.trace) {
		this.sendDebugEvent(new NetDebugTraceEvent(traceobj));
	}
}
// Config access functions
NetConnection.prototype.getDebugConfig = function()
{
	this.attachDebug();
	return this.m_Config;
}

//
// NetConnection proxy setup
//
if (!NetConnection.prototype.netDebugProxyFunctions) {
	NetConnection.prototype.netDebugProxyFunctions = true;
	NetConnection.prototype.realconnect		= NetConnection.prototype.connect;
	NetConnection.prototype.realcall		= NetConnection.prototype.call;
	NetConnection.prototype.realclose		= NetConnection.prototype.close;
	NetConnection.prototype.realaddHeader	= NetConnection.prototype.addHeader;
	NetConnection.prototype.connect		= netDebugProxyConnect;
	NetConnection.prototype.call		= netDebugproxyCall;
	NetConnection.prototype.close		= netDebugproxyClose;
	NetConnection.prototype.addHeader	= netDebugproxyAddHeader;
}
// ------------------------------------------------------------

// ------------------------------------------------------------
// RTMPClientIDResponse - responder class for getting RTMP client id
// ------------------------------------------------------------
function RTMPClientIDResponse(cs, nc)
{
	this.m_ConnectString = cs;
	this.m_NC = nc;
}
RTMPClientIDResponse.prototype.onResult = function(cid)
{
	this.m_NC.m_ClientId = cid;
	getNetDebug().sendCommand(new AddRTMPClientCommand(this.m_ConnectString, cid));
}
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugResponseProxy - proxy class to take the place of
//                               NetResponse object in NetConnection calls
// ------------------------------------------------------------
function NetDebugResponseProxy(source, original)
{
	// save our source for client events
	this.m_SourceNC = source;
	// save the user's result object to forward results and errors
	this.m_OriginalNR = original;
}
// our server-called events
NetDebugResponseProxy.prototype.onDebugEvents = function(debugevents)
{
	for (var i = 0; i < debugevents.length; i++) {
		this.m_SourceNC.sendServerEvent(debugevents[i]);
	}
}
// NetResponse server-called events
NetDebugResponseProxy.prototype.onResult = function(resultobj)
{
	this.m_SourceNC.sendClientEvent(new NetDebugResultEvent(resultobj));
	this.m_OriginalNR.onResult(resultobj);
}
NetDebugResponseProxy.prototype.onStatus = function(statusobj)
{
	this.m_SourceNC.sendClientEvent(new NetDebugStatusEvent(statusobj));
	if (this.m_OriginalNR.onStatus != undefined) {
		this.m_OriginalNR.onStatus(statusobj);
	} else {
		// ? do we need to call this here ?
		// or just forget about it because there was no onStatus
		// in the target NetResponse object
		_global.System.onStatus(statusobj);
	}
}
NetDebugResponseProxy.prototype.__resolve = function(name)
{
	trace("NetDebugResponseProxy.prototype.__resolve name: " + name);
	this.m_SourceNC.sendClientEvent(new NetDebugReceiveCallEvent(name, arguments));
	this.m_OriginalNR[name].apply(arguments);
}
// ------------------------------------------------------------
