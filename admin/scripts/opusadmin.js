// JavaScript Document
function SelectAll() {
	len = document.catResultsForm.elements.length;
	var i=0;
	for( i=0; i<len; i++) {
		tmpVar = document.catResultsForm.elements[i].name;
		document.catResultsForm.elements[i].checked=true;
			}
}
function SelectNone() {
	len = document.catResultsForm.elements.length;
	var i=0;
	for( i=0; i<len; i++) {
		tmpVar = document.catResultsForm.elements[i].name;
		document.catResultsForm.elements[i].checked=false;
			}
}
function clearBoxes () {
	document.sForm.sCatnum.value="";
	document.sForm.sLabel.value="";
	document.sForm.sArtist.value="";
	document.sForm.sTitle.value="";
	document.sForm.sDiscogsID.value="";
	document.sForm.vendorID.value="0";
}
function clearBoxesShop () {
	document.sForm.sCatnum.value="";
	document.sForm.sLabel.value="";
	document.sForm.sArtist.value="";
	document.sForm.sTitle.value="";
}
function popOrders() {
		window.open('http://www.downtown304.com/admin/ordersPrintPicklists.pdf');
}