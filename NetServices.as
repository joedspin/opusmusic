//++++++++
//Copyright © 2002 Macromedia, Inc. All rights reserved.   
//++++++++

#include "RecordSet.as"

// -----------------------------------------------------------------
// NetServiceProxyResponder
// This is the automatically-generated responder object that is used
// when a service is called and no responder object was given.
// -----------------------------------------------------------------

_global.NetServiceProxyResponder = function(service, methodName)
{
	//trace("NetServiceProxyResponder(" + service + "," + methodName + ")");
	this.service = service;
	this.methodName = methodName;
}

// This function gets called whenever an onResult is received from the server
// as a result of a call that is being handled by our responder object.
NetServiceProxyResponder.prototype.onResult = function(result)
{
	//trace("NetServiceProxyResponder.onResult(" + result + ")");
	var client = this.service.client;

	// tell the result object what service it came from, if it wants to know.
	// (this call usually has no effect, except for NetServiceProxy and RecordSet).
	result._setParentService(this.service);

	var func = this.methodName + "_Result";
	if (typeof(client[func]) == "function")
	{
		// there is an "xxx_Result" method supplied - call it.
		client[func](result);
	}
	else if (typeof(client.onResult) == "function")
	{
		// there is an "onResult" method supplied - call it.
		client.onResult(result);
	}
	else
	{
		// nobody to call. Dump something to the output window.
		NetServices.trace("NetServices", "info", 1, func + " was received from server: " + result);
	}
}

// This function gets called whenever an onStatus is received from the server
// as a result of a call that is being handled by our responder object.
NetServiceProxyResponder.prototype.onStatus = function(result)
{
	//trace("NetServiceProxyResponder.onStatus(" + objectToString(result) + ")");
	var client = this.service.client;

	var func = this.methodName + "_Status";
	if (typeof(client[func]) == "function")
	{
		// there is an "xxx_Status" method supplied - call it.
		client[func](result);
	}
	else if (typeof(client.onStatus) == "function")
	{
		// there is an "onStatus" method supplied - call it.
		client.onStatus(result);
	}
	else if (typeof(_root.onStatus) == "function")
	{
		// there is an "onStatus" method at the root level - call it.
		_root.onStatus(result);
	}
	else if (typeof(_global.System.onStatus) == "function")
	{
		// there is an "onStatus" method at the global level - call it.
		_global.System.onStatus(result);
	}
	else
	{
		// nobody to call. Dump something to the output window.
		NetServices.trace("NetServices", "info", 2, func + " was received from server: " + result.class + " " + result.description);
	}
}


// -----------------------------------------------------------------
// NetServiceProxy
// -----------------------------------------------------------------

// Ensure that NetServiceProxy objects received via AMF messages get
// correctly deserialized into actionscript objects.
Object.registerClass("NetServiceProxy", NetServiceProxy);

_global.NetServiceProxy = function(nc, serviceName, client)
{
	if (nc != null)
	{
		// the constructor was called from ActionScript code
		this.nc = nc;
		this.serviceName = serviceName;
		this.client = client;
	}
	// else - parameter is null, this probably means that 
	// this object has just been received as a typed object in an AMF message.
	// just leave the data alone. construction of this object
	// will be completed when _setParentService is called.
}

NetServiceProxy.prototype._setParentService = function(service)
{
	this.nc = service.nc;
	this.client = service.client;
}

// This function gets called whenever somebody does "myService.methodName(parameters...)".
// We construct and return the function "f", which knows how to call the correct server method. 
NetServiceProxy.prototype.__resolve = function(methodName)
{
	//trace("NetServiceProxy.__resolve " + methodName);
	var f = function()
	{
		// did the user give a default client when he created this NetServiceProxy? 
		if (this.client != null)
		{
			// Yes. Let's create a responder object.
			arguments.unshift(new NetServiceProxyResponder(this, methodName));
		}
		else
		{
			if (typeof(arguments[0].onResult) != "function")
			{
				NetServices.trace("NetServices", "warning", 3, "There is no defaultResponder, but no responder was given in call to " + methodName);
				arguments.unshift(new NetServiceProxyResponder(this, methodName));
			}
		}
		arguments.unshift(this.serviceName + "." + methodName);
		return this.nc.call.apply(this.nc, arguments);
	}
	return f;
}

// -----------------------------------------------------------------
// NetConnection
// -----------------------------------------------------------------

// This function creates a service proxy object associated with this NetConnection.
NetConnection.prototype.getService = function(serviceName, client)
{
	var result = new NetServiceProxy(this, serviceName, client);
	//trace("NetConnection.getService " + result);
	return result;
}

// This function sets the credentials into a standard header which gets sent to the server
// on all subsequent requests.
NetConnection.prototype.setCredentials = function(userid, password)
{
	this.addHeader("Credentials", false, {userid: userid, password: password});
}

// This function gets called whenever a RequestPersistentHeader header is received from the server.
NetConnection.prototype.RequestPersistentHeader = function(info)
{
	//trace("NetConnection_RequestPersistentHeader(" + objectToString(info) + ")");
	this.addHeader(info.name, info.mustUnderstand, info.data);
}

// This function gets called whenever a ReplaceGatewayUrl header is received from the server.
NetConnection.prototype.ReplaceGatewayUrl = function(newUrl)
{
	this.connect(newUrl);
}

// This function creates a new netconnection, which is just like the old connection,
// except it doesn't have the headers.
NetConnection.prototype.clone = function()
{
	var nc = new NetConnection();
	nc.connect(this.uri);
	return nc;
}

// -----------------------------------------------------------------
// NetServices
// -----------------------------------------------------------------

if (_global.NetServices == null)
{
	_global.NetServices = new Object();

	// Grab a copy of the data which (probably) got passed into this .swf
	// via the Object/Embed tag.
	NetServices.gatewayUrl = gatewayUrl;
}

NetServices.setDefaultGatewayUrl = function(url)
{
	//trace("NetServices.setDefaultGatewayUrl " + url);
	NetServices.defaultGatewayUrl = url;
}

NetServices.setGatewayUrl = function(url)
{
	//trace("NetServices.setGatewayUrl " + url);
	NetServices.gatewayUrl = url;
}

// createGatewayConnection creates a NetConnection and connects it to the
// gateway. We choose an appropriate URL for the gateway.
NetServices.createGatewayConnection = function(url)
{
	if (url == undefined)
	{
		// The gateway url wasn't given, we must find it.
		if (NetServices.isHttpUrl(_root._url))
		{
			// We're running in a browser. 
			// Our first choice: the "gatewayURL" param that got passed to this .swf via the object/embed tag
			// The developer could also set "gatewayUrl" *before* including NetServices.as.
			url = NetServices.gatewayUrl;

			if (url == undefined)
			{
				// our second choice: the default url that the developer said to use
				url = NetServices.defaultGatewayUrl;		
				
				if (url != undefined)
				{
					// We must strip off the host+port that 
					// was supplied in the default url, since the only host+port that is allowed
					// in a browser is the one that this .swf came from
					if (NetServices.isHttpUrl(url))
					{	
						var firstSlashPos = url.indexOf("/", 8);
						if (firstSlashPos >= 0)
						{
							url = url.substring(firstSlashPos);
						}
					}
				
					// The url exists, and doesn't start with http://
					// This means we should pre-pend the host+port of the URL of the current .swf.
					var hostUrl = NetServices.getHostUrl();
					if (hostUrl != null)
					{
						url = hostUrl + url;
					}
				}
			}
		}
		else
		{
			// We're running in authoring or the standalone player
			url = NetServices.defaultGatewayUrl;		
		}
	}
	
	// See if we were able to find a gateway url to use	
	if (url == undefined)
	{
		// no url. no good.
		NetServices.trace("NetServices", "warning", 4, "createGatewayConnection - gateway url is undefined");
		return null;
	}

	// We found a gateway URL. Create the NetConnection object and connect to the URL.
	var nc = new NetConnection();
	nc.connect(url);

	//trace("NetServices.createGatewayConnection " + nc);
	return nc;
}

// getHostUrl returns the hostname (and port) of the URL that contains the current .swf file.
// there is no trailing "/". returns null if the url is not http://something.
// example: if the swf url is http://my.foo.com:1234/some/thing/my.swf, this
// function will return "http://my.foo.com:1234".
NetServices.getHostUrl = function ()
{
	if (!NetServices.isHttpUrl(_root._url))
	{
		// this url doesn't start with "http://", I don't know what to do with it.
		return null;
	}
	var firstSlashPos = _root._url.indexOf("/", 8);
	if (firstSlashPos < 0)
	{
		// hmmm...
		return null;
	}
	return _root._url.substring(0, firstSlashPos);
}

NetServices.isHttpUrl = function (url)
{
	// return url.startsWith("http://") || url.startsWith("https://");
	return ((url.indexOf("http://") == 0) || (url.indexOf("https://") == 0));
}

// a function for debugging
/*
NetServices.objectToString = function(object)
{
	var result = object.toString();
	opener = "={";
	closer = "";
	for (var memberName in object)
	{
		var member = object[memberName];
		if (typeof(member) != "function")
		{
			result += opener + memberName + ":" + NetServices.objectToString(member);
			opener = ", ";
			closer = "}";
		}
	}

	return result + closer;
}
*/

// a function for reporting errors
NetServices.trace = function(who, severity, number, message)
{
	var fullMessage = who + " " + severity + " " + number + ": " + message;
	trace(fullMessage);
	NetDebug.traceNetServices(who, severity, number, message);
}

// a function for telling the version number of NetServices and RecordSet
NetServices.getVersion = function()
{
	return 1; // this value is also in the RecordSet constructor.
}

// -----------------------------------------------------------------
