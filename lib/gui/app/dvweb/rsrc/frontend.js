
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
    if (dragOffset != null) {
        pt = eventPoint( event );
        console.log( "mouse move at " + pt.x + "," + pt.y );
        event.preventDefault();
    }
}

function canvasMouseUp( event ) {
    if (dragOffset != null) {
        pt = eventPoint( event );
        console.log( "mouse up at " + pt.x + "," + pt.y );
        event.preventDefault();
        dragOffset = null;
        if (currentPrompt.type == "point") {
            respondToPrompt( { x: Math.floor(pt.x),
                               y: Math.floor(pt.y) } );
        }
    }
}


function extendDisplayList( item ) {
    var svg = $('#canvas').svg('get');
    svg[item.primitive].apply( svg, item.args );
}

ActionHandlers["extend-display-list"] = extendDisplayList;

function abox1() {
    var s1 = {fill: 'red', stroke: 'navy', strokeWidth: 3 };
    extendDisplayList( { primitive: "rect",
                         args: [55,10,85,12,s1] } );
}

function abox2() {
    var s1 = {fill: 'navy', stroke: 'red', strokeWidth: 2 };
    extendDisplayList( { primitive: "rect",
                         args: [60,70, 10,10, s1] } );
}

function drawIntro(svg) {
    //
    svg.rect(20.5, 50.5, 100, 50, {fill: 'yellow', stroke: 'navy', strokeWidth: 1}); 
    svg.rect(30.5, 53.5, 100, 50, {fill: 'white', stroke: 'navy', strokeWidth: 1}); 
    var sheet = svg.rect( 0.5, 0.5, 500, 500, { id: 'sheet', fill: "#fff", stroke: '#ccc', "fill-opacity": 0 } );
    $(sheet).mousedown(canvasMouseDown).mousemove(canvasMouseMove).mouseup(canvasMouseUp);
    //svg.configure( { width: "100%", height: "100%" } );
}

function documentReady() {
    $('#canvas').svg( { onLoad: drawIntro } );
    $("#nav").treeview( { collapsed: true } );
    startWebSocket();
}

$(document).ready( documentReady );

