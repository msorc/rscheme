
var dragOffset = null;

function eventPoint( event ) {
    return { x: event.clientX - dragOffset.left, 
             y: event.clientY - dragOffset.top };
}

function canvasMouseDown( event ) {
    var adj;
    if ($.browser.msie) {
        adj = { left:0, top:0 };
    } else {
        adj = $("#canvas").offset();
        adj.left -= document.documentElement.scrollLeft || document.body.scrollLeft;
        adj.top -= document.documentElement.scrollTop || document.body.scrollTop;
    }
    dragOffset = adj;
    pt = eventPoint( event );
    console.log( "mouse down at " + pt.x + "," + pt.y );

    event.preventDefault();
}

function canvasMouseMove( event ) {
    pt = eventPoint( event );
    console.log( "mouse move at " + pt.x + "," + pt.y );
    event.preventDefault();
}

function canvasMouseUp( event ) {
    pt = eventPoint( event );
    console.log( "mouse up at " + pt.x + "," + pt.y );
    event.preventDefault();
}


function drawIntro(svg) {
    svg.rect(20.5, 50.5, 100, 50, {fill: 'yellow', stroke: 'navy', strokeWidth: 1}); 
    svg.rect(30.5, 53.5, 100, 50, {fill: 'white', stroke: 'navy', strokeWidth: 1}); 
    //var sheet = svg.rect( 0, 0, '500', '500', { id: 'sheet', fill: '#eef' } );
    //$(sheet).mousedown(canvasMouseDown).mousemove(canvasMouseMove).mouseup(canvasMouseUp);
    //svg.configure( { width: "100%", height: "100%" } );
}

function documentReady() {
    $('#canvas').svg( { onLoad: drawIntro } );
    $("#nav").treeview( { collapsed: true } );
}

$(document).ready( documentReady );

