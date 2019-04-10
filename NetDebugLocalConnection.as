//++++++++
//Copyright © 2002 Macromedia, Inc. All rights reserved.   
//++++++++

// An interface to be used with GlobalLocalConnection
//
// NetDebugReceiver interface
//	onReceive( Object dataobj )
//	onReceiveError( Object errorobj )

// ------------------------------------------------------------
// class GlobalLocalConnection - a dual use class for sending or receiving 
//                               data and commands on a LocalConnection, 
//                               using a global instance
// ------------------------------------------------------------
function GlobalLocalConnection(iscontroller, receiver, domainname)
{
	this.maxConnections = 10;
	var sToMovie 		= "_NetDebugLocalToDebugMovie";
	var sToController 	= "_NetDebugLocalToController";

	// set up the connection and send names
	var connectname = null;
	if (iscontroller) {
		connectname = sToController;
		this.sendnames = new Array();
		this.sendnames.push(sToMovie);
		for (var i = 0; i < this.maxConnections; i++) {
			this.sendnames.push(sToMovie + i);
		}
		this.maxConnections = 0;
	} else {
		connectname = sToMovie;
		this.sendnames = new Array();
		this.sendnames.push(sToController);
	}
	this.setDomainName(domainname);
	// create LC as necessary
	if (_global.g_NetDebugLocalConnection == undefined) {
		_global.g_NetDebugLocalConnection = new LocalConnection();
		_global.g_NetDebugLocalConnection.allowDomain = function() {
			// allow everbody to send to us
			return true;
		}
	}
	if (receiver != null) {
		_global.g_NetDebugLocalConnection.m_Receiver = receiver;
		_global.g_NetDebugLocalConnection.onData = function(dataobj)
		{
			_global.g_NetDebugLocalConnection.m_Receiver.onReceive(dataobj);
		}
		_global.g_NetDebugLocalConnection.onCommand = function(commandobj)
		{
			_global.g_NetDebugLocalConnection.m_Receiver.onReceiveCommand(commandobj);
		}
		// now just connect
		if (!_global.g_NetDebugLocalConnection.connect(connectname)) {	
			var connected = false;
			for (var i = 0; i < this.maxConnections; i++) {
				if (_global.g_NetDebugLocalConnection.connect(connectname + i)) {
					// got a connection
					connected = true;
					break;
				}
			}
			if (!connected) {
				if (iscontroller) {		
					receiver.onReceiveError(new NetDebugDuplicateNCDErrorEvent());
				} else {
					// can't report error in test movie
					//trace("NetDebug, over maximum number of movies");
				}
			} 
		}
	}
}
GlobalLocalConnection.prototype.setDomainName = function(domainname)
{
	if (domainname != null && domainname != "") {
		this.sendPrefix = domainname + ":";
	} else {
		this.sendPrefix = "";
	}
}
GlobalLocalConnection.prototype.send = function(dataobj)
{
	return this.sendRaw("onData", dataobj);
}
GlobalLocalConnection.prototype.sendCommand = function(commandobj)
{
	return this.sendRaw("onCommand", commandobj);
}
GlobalLocalConnection.prototype.sendRaw = function(functionname, obj)
{
	var suc = true;
	for (var i = 0; i < this.sendnames.length; i++) {	
		suc &= _global.g_NetDebugLocalConnection.send(
						this.sendPrefix + this.sendnames[i], functionname, obj);
	}
	return suc;
}
// ------------------------------------------------------------

// ------------------------------------------------------------
// class LocalCommand - base class for some local commands
// ------------------------------------------------------------
function LocalCommand()
{
}
LocalCommand.prototype.init = function(commandname, dataobj)
{
	this.command = commandname;
	this.data = dataobj;
}
// ------------------------------------------------------------

// ------------------------------------------------------------
// class UpdateNetDebugConfigCommand - command to update ND configuration
//                                     (i.e. affects new NetConnections)
// ------------------------------------------------------------
function UpdateNetDebugConfigCommand(dataobj)
{
	this.init("updateConfig", dataobj);
}
UpdateNetDebugConfigCommand.prototype = new LocalCommand();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class GetConfigCommand - command to request new a configuration
// ------------------------------------------------------------
function GetConfigCommand()
{
	this.init("getConfig", null);
}
GetConfigCommand.prototype = new LocalCommand();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class StartRTMPTraceCommand - command to request that realtime trace be started
// ------------------------------------------------------------
function StartRTMPTraceCommand(cs)
{
	var connectinfo = new Object();
	connectinfo.connectstring = cs;
	connectinfo.url = _root._url;
	this.init("startRealTimeTrace", connectinfo);
}
StartRTMPTraceCommand.prototype = new LocalCommand();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class AddRTMPClientCommand
// ------------------------------------------------------------
function AddRTMPClientCommand(cs, cid)
{
	var connectinfo = new Object();
	connectinfo.connectstring = cs;
	connectinfo.url = _root._url;
	connectinfo.clientid = cid;
	this.init("addRealTimeClient", connectinfo);
}
AddRTMPClientCommand.prototype = new LocalCommand();
// ------------------------------------------------------------

// ------------------------------------------------------------
// class StopRTMPTraceCommand - command to request that realtime trace be stopped
// ------------------------------------------------------------
function StopRTMPTraceCommand(cs, cid)
{
	var connectinfo = new Object();
	connectinfo.connectstring = cs;
	connectinfo.url = _root._url;
	connectinfo.clientid = cid;
	this.init("stopRealTimeTrace", connectinfo);
}
StopRTMPTraceCommand.prototype = new LocalCommand();
// ------------------------------------------------------------




