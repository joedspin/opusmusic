//++++++++
//Copyright © 2002 Macromedia, Inc. All rights reserved.   
//++++++++

// ------------------------------------------------------------
// NetDebug version function. This should really be in a separate
// file.
// ------------------------------------------------------------
function getNetDebugVersion()
{
	return 1;
}
// ------------------------------------------------------------

// ------------------------------------------------------------
// class NetDebugConfig - NetDebug configurations
// ------------------------------------------------------------
function NetDebugConfig()
{
//	attachNetDebugConfigFunctions(this);
}
// ------------------------------------------------------------

function attachNetDebugConfigFunctions(ndc)
{
	ndc.setDebug = function(setval) {
		this.m_debug = setval;
	}
	ndc.getDebug = function() {
		return this.m_debug;
	}
	for (var prop in ndc) {
		if (typeof(ndc[prop]) == "object") {
			attachNetDebugConfigFunctions(ndc[prop]);
		}
	}
}

// register this class so class gets recontructed with functions after serialization
Object.registerClass("NetDebugConfig", NetDebugConfig);

//
// function to get a default NetDebugConfig
//
function getDefaultNetDebugConfig(iscontroller)
{
	if (_global.netDebugConfigSO == undefined) {
		var soName = "TestMovie_Config_Info";
		if (iscontroller) {
			soName = "Controller_Config_Info";
		}
		_global.netDebugConfigSO = SharedObject.getLocal(soName);
	}
	if (_global.netDebugConfigSO.data.config == undefined) {
		_global.netDebugConfigSO.data.config = getRealDefaultNetDebugConfig();
	}
	_global.netDebugConfigSO.flush();
//	attachNetDebugConfigFunctions(_global.netDebugConfigSO.data.config);
	return _global.netDebugConfigSO.data.config;
}

//
// real default
//
function getRealDefaultNetDebugConfig()
{
	var defaultConfig 					= new NetDebugConfig();
	defaultConfig.m_debug				= true;
	// client
	defaultConfig.client 				= new NetDebugConfig();
	defaultConfig.client.m_debug		= true;
	defaultConfig.client.trace 			= true;
	defaultConfig.client.recordset 		= true;
	defaultConfig.client.http 			= true;
	defaultConfig.client.rtmp 			= true;
	// realtime server
	defaultConfig.realtime_server 		= new NetDebugConfig();
	defaultConfig.realtime_server.m_debug = true;
	defaultConfig.realtime_server.trace	= true;
	// app server
	defaultConfig.app_server 				= new NetDebugConfig();
	defaultConfig.app_server.m_debug		= true;
	defaultConfig.app_server.trace 			= true;
	defaultConfig.app_server.error	 		= true;
	defaultConfig.app_server.recordset 		= true;
	defaultConfig.app_server.httpheaders 	= false;
	defaultConfig.app_server.amf 			= false;
	defaultConfig.app_server.amfheaders 	= false;
	// ColdFusion
	defaultConfig.app_server.coldfusion 	= true;
//	defaultConfig.app_server.coldfusion 	= new NetDebugConfig();
//	defaultConfig.app_server.coldfusion.m_debug					= true;
//	defaultConfig.app_server.coldfusion.template				= false;
//	defaultConfig.app_server.coldfusion.execution_time			= false;
//	defaultConfig.app_server.coldfusion.database 		 		= true;
//	defaultConfig.app_server.coldfusion.sql_query      			= true;
//	defaultConfig.app_server.coldfusion.object_query   			= false;
//	defaultConfig.app_server.coldfusion.trace          			= true;
//	defaultConfig.app_server.coldfusion.exception      			= true;
//	defaultConfig.app_server.coldfusion.http 					= false;
//	defaultConfig.app_server.coldfusion.variable       			= false;
//	defaultConfig.app_server.coldfusion.application_variable 	= false;
//	defaultConfig.app_server.coldfusion.cgi_variable 			= false;
//	defaultConfig.app_server.coldfusion.client_variable 		= false;
//	defaultConfig.app_server.coldfusion.cookie_variable 		= false;
//	defaultConfig.app_server.coldfusion.form_variable 			= false;
//	defaultConfig.app_server.coldfusion.request_variable 		= false;
//	defaultConfig.app_server.coldfusion.server_variable 		= false;
//	defaultConfig.app_server.coldfusion.session_variable 		= false;
//	defaultConfig.app_server.coldfusion.url_variable 			= false;
	
//	defaultConfig.app_server.coldfusion.details					= false;
	
	return defaultConfig;
}
