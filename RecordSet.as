//++++++++
//Copyright © 2002 Macromedia, Inc. All rights reserved.   
//++++++++

// A RecordSet

#include "RsDataProviderClass.as"

//-------------------------------------------------------------
// private definitions
//-------------------------------------------------------------

// private fields of this object
//
// all recordsets have these fields
//   mTitles
//
// server-associated recordset only
//   mRecordSetId - if non-null, then this is a s.a. recordset
//   mRecordSetService
//   mTotalCount
//   mRecordsAvailable
//   //mHighWater
//   mDeliveryMode
//
// only if deliverymode = "page"
//   mPageSize	
//   mNumPrefetchPages
//
//   mAllNotified
//   mOutstandingRecordCount
//

//-------------------------------------------------------------
// public RecordSet Constructor
//-------------------------------------------------------------

// The RecordSet constructor.
//
// If a RecordSet object is received from a server via the AMF protocol, then
// there will be a field called "serverInfo" already existing when the constructor is called
// by the AMF deserializer. The fields are:
//   totalCount: int
//   columnNames: array of string
//   initialData: array of array of field
//   id: string
//   version: int
//   cursor: int
//   serviceName: string
// 
// If the RecordSet is being created by the normal "new RecordSet()" call, then
// "serverInfo" will not exist.

// NOTE: the server counts records starting from number 1, but we count starting from 0.

_global.RecordSet = function(columnNames)
{	
	if (this.mTitles != null)
	{
		// we've already been constructed.
		// this should happen only when the object is a
		// shared object that's being reloaded into memory.
		this.views = new Array(); // these are probably out of date
		return;
	}

	// initialize our superclass
	this.init();

	if (this.serverInfo == null)
	{
		// there's no server information - we're done
		this.mTitles = columnNames;
		return;
	}

	// this recordset came from a server.
	if (this.serverInfo.version != 1)
	{
		NetServices.trace("RecordSet", "warning", 100, "Received incompatible recordset version from server");
		return;
	}

	// set up the initial contents of the recordset
	this.mTitles = this.serverInfo.columnNames;
	this.mRecordsAvailable = 0;
	//this.mHighWater = 0;
	this.setData((this.serverInfo.cursor == null) ? 0 : (this.serverInfo.cursor - 1), this.serverInfo.initialData);

	if (this.serverInfo.initialData.length != this.serverInfo.totalCount)
	{
		this.mRecordSetId = this.serverInfo.id;
		// we haven't yet got all the data
		if (this.mRecordSetId != null)
		{
			// if id is non-null, there are more records still on the server.
			// This therefore is a server-associated recordset
			this.serviceName = (this.serverInfo.serviceName == null) ? "RecordSet" : this.serverInfo.serviceName;

			// initialize other fields
			this.mTotalCount = this.serverInfo.totalCount;
			this.mDeliveryMode = "ondemand";
			this.mAllNotified = false;
			this.mOutstandingRecordCount = 0;
		}
		else
		{
			NetServices.trace("RecordSet", "warning", 102, "Missing some records, but there's no recordset id");
		}
	}
	
	this.serverInfo = null;
}

// Define our superclass
RecordSet.prototype = new RsDataProviderClass();

// Ensure that RecordSets received via AMF messages get
// deserialized into actionscript RecordSet objects.
Object.registerClass("RecordSet", RecordSet);

RecordSet.prototype._setParentService = function(service)
{
	this.gateway_conn = service.nc;
}

RecordSet.prototype.getRecordSetService = function()
{
	if (this.mRecordSetService == null)
	{
		if (this.gateway_conn == null)
		{
			// _setParentService never got called. this will only happen if:
			//  - recordset is not the top-level return value, or
			//  - NetServiceProxyResponder is not in use (i.e. there is a developer-supplied response object 
			//    for the service call that returned this RecordSet
			
			this.gateway_conn = NetServices.createGatewayConnection();
		}
		else
		{
			// A parent netconnect has been supplied. If necessary,
			// make a new netconnection, so we can have separate debug flags
			if (_global.netDebugInstance != undefined)
			{
				this.gateway_conn = this.gateway_conn.clone();
			}
		}
		if (_global.netDebugInstance != undefined)
		{
			this.gateway_conn.setupRecordset();
			this.gateway_conn.setDebugId("RecordSet " + this.mRecordSetId);
		}

		this.mRecordSetService = this.gateway_conn.getService(this.serviceName, this);
		if (this.mRecordSetService == null)
		{
			NetServices.trace("RecordSet", "warning", 101, "Failed to create recordset service");
			this.mRecordSetService = 0; // so we don't get a flood of error messages
		}
	}
	
	return this.mRecordSetService;
}

//-------------------------------------------------------------
// public property access functions
//-------------------------------------------------------------

RecordSet.prototype.getColumnNames = function()
{
	return this.mTitles;
}

//-------------------------------------------------------------
// public DataProvider functions
//
// Most DataProvider functions are simply inherited from our superclass.
//-------------------------------------------------------------

// The following inherited functions are always valid
//RsDataProviderClass.prototype.getItemId = function(index)

// For server-associated recordsets, the following inherited functions
// are only valid after the recordset becomes fully populated
/*
RsDataProviderClass.prototype.addItemAt = function(index, value)
{
}

RsDataProviderClass.prototype.addItem = function(value)
{ 
}

RsDataProviderClass.prototype.removeItemAt = function(index) 
{
}

RsDataProviderClass.prototype.removeAll = function()
{
}

RsDataProviderClass.prototype.replaceItemAt = function(index, itemObj) 
{
}

RsDataProviderClass.prototype.sortItemsBy = function(fieldName, order)
{
}
*/

RecordSet.prototype.getLength = function()
{
	if (this.mRecordSetID != null)
	{
		// a server-associated recordset
		//trace("RecordSet.getLength: " + this.mTotalCount);
		return this.mTotalCount;
	}
	else
	{
		// a local recordset
		//trace("RecordSet.getLength: " + this.items.length);
		return this.items.length;
	}
}


// returns null if the index is out of range
// returns 1 if the data is unavailable
// returns the data if it is available
RecordSet.prototype.getItemAt = function(index)
{
	//trace("RecordSet.getItemAt(" + index + ")");

	if (this.mRecordSetId == null)
	{
		// this is not a server-associated recordset
		//trace("RecordSet.getItemAt not server-associated");
		return this.items[index];
	}

	// It is server associated. See if the index is valid. 
	if ((index < 0) || (index >= this.getLength()))
	{
		NetServices.trace("RecordSet", "warning", 104, "getItemAt(" + index + ") index out of range");
		return null;
	}

	// let the paging lookahead code have a look at this request.
	// (even if the record is in memory we might still want to request a download of the page)
	this.requestRecord(index);

	var result = this.items[index];
	if (result == 1) return "in progress";
	//trace("RecordSet.getItemAt(" + index + ") returning " + result);
	return result;
}

// the spec includes this as a dataprovider function, even though it really isn't
RecordSet.prototype.setField = function(index, fieldName, value)
{
	if (!this.checkLocal()) return;

	if (index<0 || index>=this.getLength()) {
		return;
	}
	this.items[index][fieldName] = value;
	this.updateViews( {event:"updateRows", firstRow:index, lastRow:index} );
}

//-------------------------------------------------------------
// public Data Manipulation functions
//-------------------------------------------------------------

RecordSet.prototype.filter = function(filterFunction, context)
{
	if (!this.checkLocal()) return;

	// create a new, empty recordset
	var result = new RecordSet(this.mTitles);

	// loop over all the records in the current recordset
	// find the ones that the the filter function approves of,
	// and add it to the result
	for(var i = 0; i < this.getLength(); i++)
	{
		var item = this.getItemAt(i);
		if ((item != null) && (item != 1) && filterFunction(item, context))
		{
			result.addItem(item);
		}
	}

	//trace("RecordSet.filter: " + NetServices.objectToString(result));
	return result;
};


RecordSet.prototype.sort = function(compareFunc)
{
	if (!this.checkLocal()) return;

	this.items.sort(compareFunc);
	this.updateViews( {event:"sort"} );
}

//-------------------------------------------------------------
// public Data Delivery functions
//-------------------------------------------------------------

RecordSet.prototype.isLocal = function()
{
	return (this.mRecordSetID == null);
}

RecordSet.prototype.isFullyPopulated = function()
{
	return this.isLocal();
}

RecordSet.prototype.getNumberAvailable = function()
{
	if (this.isLocal())
	{
		return this.getLength();
	}
	else
	{
		return this.mRecordsAvailable;
	}
}

RecordSet.prototype.setDeliveryMode = function(mode, pagesize, numPrefetchPages)
{
	//trace("RecordSet.setDeliveryMode(" + mode + "," + pagesize + "," + numPrefetchPages + ")");
	this.mDeliveryMode = mode;
	this.stopFetchAll();

	if (mode == "ondemand")
	{
		// nothing else to do
		return;
	}

	if (pagesize == null)
	{
		// deduce the page size from our views...
		// !!@ doc note: you must up at least one view (via setDataProvider) before doing setDeliveryMode
		// !!@ doc note: if there are multiple views, we use the pagesize of the first view 
		// !!@ doc note: if the listbox gets resized, you must call setDeliveryMode again
		pagesize = this.views[0].getRowCount();
		if (pagesize == null)
		{
			pagesize = 25;
		}
	}

	if (mode == "page")
	{
		if (numPrefetchPages == null)
		{
			numPrefetchPages = 0;
		}

		this.mPageSize = pagesize;
		this.mNumPrefetchPages = numPrefetchPages;
		// !!@ doc note: 0 is ok for numPrefetchPages, it means fetch only the current page.
	}
	else if (mode == "fetchall")
	{
		this.stopFetchAll();
		this.startFetchAll(pagesize);
	}
	else
	{
		NetServices.trace("RecordSet", "warning", 107, "SetDeliveryMode: unknown mode string");
	}
}

//-------------------------------------------------------------
// Responses from the RecordSet service
//-------------------------------------------------------------

// This function is where all our data comes in from the recordset service
RecordSet.prototype.getRecords_Result = function(info)
{
	//trace("RecordSet.getRecords_Result(), start=" + info.Cursor +
	//	", id=" + info.id + ", data=" + info.Page);

	this.setData(info.Cursor - 1, info.Page);
	this.mOutstandingRecordCount -= info.Page.length;
	// !!@ assert (this.mOutstandingRecordCount) >= 0
	this.updateViews({event:"updateRows", firstRow:info.Cursor - 1, lastRow:info.Cursor - 1 + info.Page.length - 1});

	if ((this.mRecordsAvailable == this.mTotalCount) && !this.mAllNotified)
	{
		this.updateViews({event:"allRows"});
		this.mRecordSetService.release();
		this.mAllNotified = true;
		this.mRecordSetID = null;
		this.mRecordSetService = null;
	}
}

RecordSet.prototype.release_Result = function()
{
	// ignore this
}

//-------------------------------------------------------------
// private data delivery functions
//-------------------------------------------------------------

RecordSet.prototype.arrayToObject = function(anArray)
{
	if (this.mTitles == null)
	{
		NetServices.trace("RecordSet", "warning", 105, "getItem: titles are not available");
		return null;
	}

	var result = new Object;
	for (var i = 0; i < anArray.length; i++)
	{
		var title = this.mTitles[i];
		if (title == null)
		{
			title = "column" + i + 1;
		}
		result[title] = anArray[i];
	}

	return result;
}

RecordSet.prototype.setData = function(start, dataArray)
{
	//trace("setData " + start + "," +dataArray.length);
	for (var i = 0; i < dataArray.length; i++)
	{
		var index = i + start;
		
		var rec = this.items[index];
		if ((rec != null) && (rec != 1))
		{
			// why are we getting this data! we already have it
			NetServices.trace("RecordSet", "warning", 106, "Already got record # " + recordIndex);
		}
		else
		{
			this.mRecordsAvailable += 1;
		}

		this.items[index] = this.arrayToObject(dataArray[i]);
		this.items[index].__ID__ = this.uniqueID++;
	}
}

RecordSet.prototype.requestOneRecord = function(index)
{
	if (this.items[index] == null)
	{
		this.getRecordSetService().getRecords(this.mRecordSetId, index + 1, 1);
		this.mOutstandingRecordCount++;
		this.items[index] = 1;
		this.updateViews({event:"fetchRows", firstRow:index, lastRow:index});
	}
}

RecordSet.prototype.requestRecord = function(index)
{
	//trace("RecordSet.requestRecord(" + index + ")");

	if (this.mDeliveryMode != "page")
	{
		// fetchall, ondemand or unknown
		this.requestOneRecord(index);
		return;

		// !!@ if in fetchall mode, should start fetching from here, and wrap around to 1 later on
	}

	// we're in page mode
	// !!@ there is probably a better algorithm, but messier
	// the current algorithm works fine if records are always fetched in increasing index order
	// but goes wierd if not.

	// See if we need to prefetch the next N+1 pages, starting at index
	// (its N+1 because we always prefetch *the current page* as well
	// as any requested other pages)
	var firstIndex = int(index / this.mPageSize) * this.mPageSize;
	var lastIndex = firstIndex + (this.mPageSize * (this.mNumPrefetchPages + 1)) - 1;
	this.requestRecordRange(firstIndex, lastIndex);
}

RecordSet.prototype.requestRecordRange = function(index, lastIndex)
{
	//trace("RecordSet.requestRecordRange(" + index + "," + lastIndex + ")");

	var highestRequested = -1;

	// make sure indices are valid
	if (index < 0)
	{
		index = 0;
	}
	if (lastIndex >= this.getLength())
	{
		lastIndex = this.getLength() - 1;
	}

	// find sequences of null entries to request
	// we could also just make a bunch of individual requests, but this seems 
	// cleaner. The server should be able to handle either case efficiently.
	while (index <= lastIndex)
	{
		while ((index <= lastIndex) && (this.items[index] != null))
		{
			index++;
		}
		var first = index; // this is the index of the first null entry in a group

		while ((index <= lastIndex) && (this.items[index] == null))
		{
			this.mOutstandingRecordCount++;
			this.items[index] = 1;
			index++;
		}
		var last = index - 1;

		if (first <= last)
		{
			this.getRecordSetService().getRecords(this.mRecordSetId, first + 1, last - first + 1);
			highestRequested = last;
			this.updateViews({event:"fetchRows", firstRow:first, lastRow:last});
		}
	}

	return highestRequested;
}

RecordSet.prototype.startFetchAll = function(pagesize)
{
	//trace("RecordSet.startFetchAll()");
	this.mDataFetcher.disable();
	this.mDataFetcher = new RsDataFetcher(this, pagesize);
};

RecordSet.prototype.stopFetchAll = function()
{
	//trace("RecordSet.stopFetchAll()");
	this.mDataFetcher.disable();
	this.mDataFetcher = null;
};

RecordSet.prototype.checkLocal = function()
{
	if (this.isLocal())
	{
		return true;
	}
	else
	{
		NetServices.trace("RecordSet", "warning", 108, "Operation not allowed on partial recordset");
		return false;
	}
}

// ---------------------------------------------------
// RsDataFetcher -- helper class for the RecordSet
// this is an object that causes all the records
// to be fetched, one batch at a time
// ---------------------------------------------------

_global.RsDataFetcher = function(recordSet, increment)
{
	//trace("RsDataFetcher.constructor(" + recordSet + ", " + increment + ")");
	this.mRecordSet = recordSet;
	this.mRecordSet.addView(this);
	this.mIncrement = increment;
	this.mNextRecord = 0;
	this.mEnabled = true;

	this.doNext();
}

RsDataFetcher.prototype.disable = function()
{
	this.mEnabled = false;
	this.mRecordSet.removeView(this); // !!@ not implemented
	//trace("RsDataFetcher disabled");
}

RsDataFetcher.prototype.doNext = function()
{
	//trace("RsDataFetcher.doNext()");
	if (!this.mEnabled)
	{
		return;
	}

	while (true)
	{
		if (this.mNextRecord >= this.mRecordSet.getLength())
		{
			//trace("RsDataFetcher done");
			return;
		}

		this.mHighestRequested = this.mRecordSet.requestRecordRange(this.mNextRecord, this.mNextRecord + this.mIncrement - 1);
		this.mNextRecord += this.mIncrement;

		if (this.mHighestRequested > 0)
		{
			//trace("RsDataFetcher request underway " + this.mHighestRequested);
			return;
		}
		//trace("RsDataFetcher.trying again");
	}
}		

RsDataFetcher.prototype.modelChanged = function(eventObj)
{
	//trace("RsDataFetcher.modelChanged(" + eventObj.serial + " " + eventObj.event + "," + eventObj.firstRow + "," + eventObj.lastRow + "..." + this.mHighestRequested + ")");
	if ((eventObj.event == "updateRows") && 
	    (eventObj.firstRow <= this.mHighestRequested) && 
	    (eventObj.lastRow >= this.mHighestRequested))
	{
		//trace("RsDataFetcher.request done. doing next");
		this.doNext();
	}
	if (eventObj.event == "allRows")
	{
		//trace("RsDataFetcher.allrows received");
		this.disable();
	}
};



