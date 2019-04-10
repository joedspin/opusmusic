//++++++++
//Copyright © 2002 Macromedia, Inc. All rights reserved.   
//++++++++

// This is used internally as the superclass of the RecordSet class.
// It is an exact copy of DataProviderClass, which is included here
// because of packaging limitations.

_global.RsDataProviderClass = function()
{
//	trace("init : FDataProviderClass");
	this.init();
}

RsDataProviderClass.prototype.init = function()
{
	this.items = new Array();
	this.uniqueID = 0;
	this.views = new Array();
}

RsDataProviderClass.prototype.addView = function(viewRef)
{
	//removeView needed?
	this.views.push(viewRef);
	var eventObj = {event: "updateAll"};
	viewRef.modelChanged(eventObj);
	
}

RsDataProviderClass.prototype.addItemAt = function(index, value)
{
	if (!this.checkLocal()) return;
	if (index < 0) return;
	
	if (index<this.getLength()) {
		this.items.splice(index, 0, "tmp");
	}
	this.items[index] = new Object();
	if (typeof(value)=="object") {
		this.items[index] = value;
//	} else {
//		this.items[index].label = value;
	}
	this.items[index].__ID__ = this.uniqueID++;
	var eventObj =  {event:"addRows", firstRow:index, lastRow:index};
	this.updateViews(eventObj);

}

RsDataProviderClass.prototype.addItem = function(value)
{ 
	if (!this.checkLocal()) return;
		
	this.addItemAt(this.getLength(), value);
}

RsDataProviderClass.prototype.removeItemAt = function(index) 
{
	if (!this.checkLocal()) return;
	if (index<0 || index>=this.getLength()) {
		return;
	}

	var tmpItm = this.items[index];
	this.items.splice(index,1);
	var eventObj = {event:"deleteRows", firstRow:index, lastRow:index};
	this.updateViews(eventObj)
	return tmpItm;
}

RsDataProviderClass.prototype.removeAll = function()
{
	if (!this.checkLocal()) return;
	
	this.items = new Array();
	this.updateViews({event:"deleteRows", firstRow:0, lastRow:this.getLength()-1});
}

RsDataProviderClass.prototype.replaceItemAt = function(index, itemObj) 
{
	if (!this.checkLocal()) return;
	
	if (index<0 || index>=this.getLength()) {
		return;
	}
	var tmpID = this.getItemID(index);
	this.items[index] = itemObj;
	this.items[index].__ID__ = tmpID;
	this.updateViews( {event:"updateRows", firstRow:index, lastRow:index} );
}

RsDataProviderClass.prototype.getLength = function()
{
	return this.items.length;
}

RsDataProviderClass.prototype.getItemAt = function(index)
{
	return this.items[index];
}

RsDataProviderClass.prototype.getItemID = function(index)
{
	return this.items[index].__ID__;
}

RsDataProviderClass.prototype.sortItemsBy = function(fieldName, order)
{
	if (!this.checkLocal()) return;
	
	this.items.sortOn(fieldName);
	if (order=="DESC") {
		this.items.reverse();
	}
	this.updateViews( {event:"sort"} );
}

// ::: PRIVATE METHODS

RsDataProviderClass.prototype.updateViews = function(eventObj)
{
	//eventObj.serial = "$$" + this.mSerial++;
	//trace("updating views..." + eventObj.serial + " " + eventObj.event);
	for (var i=0; i<this.views.length; i++) {
		this.views[i].modelChanged(eventObj);
	}
}
