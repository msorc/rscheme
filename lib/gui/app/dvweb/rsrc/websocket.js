
WS_URI = "ws://localhost:8112/rpc/foo";
myWebSocket = null;

function reportConnectionOpen() {
    console.log( "opened" );
}

function reportConnectionClosed() {
    console.log( "closed" );
}

function reportConnectionError(ev) {
    console.log( "error: " + ev.data );
}

function processReceivedMessage(ev) {
    var j = jQuery.parseJSON( ev.data );
    console.log( j );
}

function send(msg) {
    myWebSocket.send( JSON.stringify( msg ) );
}


function startWebSocket() {
    var ws = new WebSocket( WS_URI );
    ws.onopen = function(event) {
        reportConnectionOpen();
    };
    ws.onclose = function(event) {
        reportConnectionClosed();
    }
    ws.onmessage = function(event) {
        processReceivedMessage( event );
    }
    ws.onerror = function(event) {
        reportConnectionError( event );
    }
    myWebSocket = ws;
}
