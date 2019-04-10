//++++++++
//Copyright © 2002 Macromedia, Inc. All rights reserved.   
//++++++++

// ------------------------------------------------------------
// function copyProperties - copy all properties from one object to another
//                           including nested objects of any AS class
//                           NOTE: ignore type of to and from parameters
// ------------------------------------------------------------
_global.copyProperties = function(to, from)
{
	for (var prop in from) {
		if (prop == "__proto__" || prop == "function") {
			// prototype or function, don't copy
			continue;
		} else if (typeof(from[prop]) == "object") {
			// nested object
			if (to[prop] == undefined) {
				// none there, create a new object
				to[prop] = new from[prop].__proto__.constructor();
			}
			// recurse to asign
			copyProperties(to[prop], from[prop]);
		} else {
			// just a "normal" property
			to[prop] = from[prop];
		}
	}
}
// ------------------------------------------------------------


// ------------------------------------------------------------
// function copyObject - returns a deep copy of the of obj parameter
//                       if obj is not an object, it just returns obj
// ------------------------------------------------------------
_global.copyObject = function(obj)
{
	if (typeof(obj) == "object") {
		var ret = new obj.__proto__.constructor();
		copyProperties(ret, obj);
		return ret;
	}
	return obj;
}
// ------------------------------------------------------------


// ------------------------------------------------------------
// Object Dump functions
// ------------------------------------------------------------
_global.objectToStringTree = function(obj, openstr, typesepstr, valuesepstr, closestr)
{
	var st = new StringLineAdder(obj, new TreeLineRenderer((openstr == null ? "{" : openstr), 
														(typesepstr == null ? ":" : typesepstr), 
														(valuesepstr == null ? ", " : valuesepstr), 
														(closestr == null ? "}" : closestr)));
	return st.getString();
}
_global.objectToListboxTree = function(listbox, obj, openstr, typesepstr, valuesepstr, closestr)
{
	new ListLineAdder(listbox, obj, new TreeLineRenderer((openstr == null ? "{" : openstr), 
														(typesepstr == null ? ":" : typesepstr), 
														(valuesepstr == null ? ", " : valuesepstr), 
														(closestr == null ? "}" : closestr)));
}
// ------------------------------------------------------------


//
// define a couple of invisible interfaces
//
// interface LineRenderer
//   getLine(level[, lineitem][...])
// interface LineAdder
//   addLine(level[, lineitem][...])


//
// class StringLineAdder - add line to a string
//   implements LineAdder
//
_global.StringLineAdder = function(obj, renderer)
{
	this.linerenderer = renderer;
	this.output = "";
	nestedObjectDump(0, null, obj, this);
}
StringLineAdder.prototype.getString = function()
{
	return this.output;
}
StringLineAdder.prototype.addLine = function(level, objname, objtype, objvalue, objnum)
{
	var line = this.linerenderer.getLine(level, objname, objtype, objvalue, objnum);
	if (line != null) {
		this.output += line + newline;
	}
	return true;
}

//
// class ListLineAdder - add lines to a list box
//   implements LineAdder
//
_global.ListLineAdder = function(listbox, obj, renderer)
{
	this.linerenderer = renderer;
	this.output_lb = listbox;
	nestedObjectDump(0, null, obj, this);
}
ListLineAdder.prototype.addLine = function(level, objname, objtype, objvalue, objnum)
{
	var line = this.linerenderer.getLine(level, objname, objtype, objvalue, objnum);
	if (line != null) {
		this.output_lb.addItem(line);
	}
	return true;
}

//
// class TreeLineRenderer - implements LineRenderer for a Tree
//    implements LineRenderer
//
_global.TreeLineRenderer = function(pre, typedelim, valuedelim, post)
{
	this.init(pre, typedelim, valuedelim, post);
}
TreeLineRenderer.prototype.init = function(pre, typedelim, valuedelim, post)
{
	this.prechar = pre;
	this.typechar = typedelim;
	this.valuechar = valuedelim;
	this.postchar = post;
}
TreeLineRenderer.prototype.getLine = function(level, objname, objtype, objvalue, objnum)
{
	// just build a line in a tree
	var sAdd = "";
	for (var i = 0; i < level; i++) {
		sAdd += "\t";
	}
	var valuedelim = this.valuechar;
	if (objname != null && objtype != "object") {
		sAdd += this.prechar + objtype + this.typechar + objname;
	} else if (objtype == "object") {
		if (typeof(objvalue) == "number") {
			sAdd += this.prechar + objtype + this.typechar + objname;
			sAdd += valuedelim + "object#" + objvalue;
			objvalue = null;
		} else {
			sAdd += this.prechar + objtype + "#" + objnum + this.typechar + objname;
		}
	} else {
		sAdd += this.prechar + objtype;
		valuedelim = this.typechar;
	}
	if (objvalue != null) {
		sAdd += valuedelim + objvalue;
	}
	sAdd += this.postchar;
	return sAdd;
}

//
// nestedObjectDump - worker function
//
_global.nestedObjectDump = function(level, objname, obj, lineadder)
{
	if (level == 0) {
		nestedObjectDump.callcount++;
		nestedObjectDump.objcount = -1;
	}
	if (obj == null) {
		return lineadder.addLine(level, objname, "undefined");
	} else if (typeof(obj) == "function") {
		return lineadder.addLine(level, objname, "function");
	} else if (typeof(obj) == "object") {
		if (obj.__nestedObjectDump_id != undefined && obj.__nestedObjectDump_ref == nestedObjectDump.callcount) {
			return lineadder.addLine(level, objname, "object", obj.__nestedObjectDump_id);
		}
		nestedObjectDump.objcount++;
		if (lineadder.addLine(level, objname, "object", null, nestedObjectDump.objcount) == nestedObjectDump.skip) {
			return nestedObjectDump.proceed;
		}
		obj.__nestedObjectDump_id = nestedObjectDump.objcount;
		obj.__nestedObjectDump_ref = nestedObjectDump.callcount;
		
		var props = new Array();
		var objs = new Array();
		for (var prop in obj) {
			if (prop == "__proto__" || 
				prop == "__nestedObjectDump_id" ||
				prop == "__nestedObjectDump_ref") {
				// skip prototype functions
				continue;
			}
			if (typeof(obj[prop]) == "object") {
				objs.push(prop);
			} else {
				props.push(prop);
			}
		}
		if (objs.length == 0 && props.length == 0) {
			if (typeof(obj.toString) == "function" && obj.toString() != "") {
				return lineadder.addLine(level + 1, null, "string", obj.toString());
			} else if (lineadder.noProps != undefined) {
				lineadder.noProps(level + 1);
				return nestedObjectDump.proceed;
			}
		}
		// sort the arrays
		props.sort();
		objs.sort();
		// add props first, then objs
		var bret = true;
		for (var i = 0; i < props.length; i++) {
			if (nestedObjectDump(level + 1, props[i], obj[props[i]], lineadder) == nestedObjectDump.stop) {
				bret = false;
				break;
			}
		}
		if (bret) {
			for (var i = 0; i < objs.length; i++) {
				if (!nestedObjectDump(level + 1, objs[i], obj[objs[i]], lineadder)) {
					bret = false;
				//	break;
				}
			}
		}
		return nestedObjectDump.proceed;
	} else {
		return lineadder.addLine(level, objname, typeof(obj), obj);
	}
}
nestedObjectDump.proceed = 1;
nestedObjectDump.skip = 2;
nestedObjectDump.stop = 3;
nestedObjectDump.callcount = 0;
nestedObjectDump.objcount = 0;