//++++++++
//Copyright © 2002 Macromedia, Inc. All rights reserved.   
//++++++++

// ------------------------------------------------------------
// class NetDebug - top level user API for debugging NetConnections
// implements DebugEventReceiver, LocalCommandReceiver, NetDebug interfaces
// ------------------------------------------------------------
function NetDebug()
{
	this.m_ncs = new Array();
	this.m_Config = getDefaultNetDebugConfig();
	this.m_glc = new GlobalLocalConnection(false, this);
	// request a new config
	this.m_glc.sendCommand(new GetConfigCommand());
	this.m_NextNewId = 0;
}
NetDebug.prototype.addNetConnection = function(nc)
{
	this.m_ncs.push(nc);
	return this.m_NextNewId++;
}
NetDebug.prototype.removeNetConnection = function(nc)
{
	for (var i = 0; i < this.m_ncs.length; i++) {
		if (nc == this.m_ncs[i]) {
			this.m_ncs.splice(i, 1);
			break;
		}
	}
}
NetDebug.prototype.sendDebugEvent = function(eventobj)
{
	if (!this.m_glc.send(eventobj)) {
		// the event failed to send, create an error event in its place
		this.m_glc.send(new NetDebugFailedSendErrorEvent(StripNCDEventToMinmal(eventobj)));
		return false;
	}
	return true;
}
NetDebug.prototype.sendCommand = function(commandobj)
{
	return this.m_glc.sendCommand(commandobj);
}
NetDebug.prototype.requestNewConfig = function()
{
	return this.sendCommand(new GetConfigCommand());
}
NetDebug.prototype.updateConfig = function(config)
{
	// merge our default config and all our ncs
	copyProperties(this.m_Config, config);
	for (var i = 0; i < this.m_ncs.length; i++) {
		if (this.m_ncs[i] != null) {
			this.m_ncs[i].updateConfig(config);
		}
	}
}
NetDebug.prototype.sendStatus = function(statusobj)
{
	if (this.m_Config.m_debug && this.m_Config.client.m_debug) {
		return this.m_glc.send(new NetDebugStatusEvent(statusobj));
	}
}
// Debug event handlers
NetDebug.prototype.onEvent = function(eventobj)
{
	return this.sendDebugEvent(eventobj);
}
NetDebug.prototype.onEventError = function(errorobj)
{
	return this.sendDebugEvent(new NetDebugErrorEvent(errorobj));
}
// Command event handlers
NetDebug.prototype.onReceiveCommand = function(commandobj)
{
	// just call the function named in the command
	// on this object
	this[commandobj.command](commandobj.data);
}
NetDebug.prototype.onReceiveError = function(errorobj)
{
	this.sendDebugEvent(new NetDebugErrorEvent(errorobj));
}
NetDebug.prototype.traceNetServices = function(who, severity, number, message)
{	
	if (this.m_Config.m_debug && this.m_Config.client.m_debug && this.m_Config.client.trace) {
		if (!this.sendDebugEvent(new NetDebugTraceNetServicesEvent(who, severity, number, message))) {
			// can't report error in test movie
			//trace("NetDebug.trace - Failed to sendDebugEvent");	
		}
	}
}
// public methods
NetDebug.prototype.trace = function(traceobj)
{	
	if (this.m_Config.m_debug && this.m_Config.client.m_debug && this.m_Config.client.trace) {
		if (!this.sendDebugEvent(new NetDebugTraceEvent(traceobj))) {
			// can't report error in test movie
			//trace("NetDebug.trace - Failed to sendDebugEvent");	
		}
	}
}
// ------------------------------------------------------------

//
// The one global instance of NetDebug
//
if (_global.netDebugInstance == undefined) {
	_global.netDebugInstance = new NetDebug();
}
// access
function getNetDebug()
{
	return _global.netDebugInstance;
}

// public static trace function
NetDebug.trace = function(obj)
{
	getNetDebug().trace(obj);
}

// NetServices static trace function
NetDebug.traceNetServices = function(who, severity, number, message)
{
	getNetDebug().traceNetServices(who, severity, number, message);
}

// public static version function
NetDebug.getVersion = function()
{
	return getNetDebugVersion();
}

// global status handler
NetDebug.globalOnStatus = function(statusobj)
{
	getNetDebug().sendStatus(statusobj);
}
if (_global.System.onStatus == undefined) {
	_global.System.onStatus = NetDebug.globalOnStatus;
}
