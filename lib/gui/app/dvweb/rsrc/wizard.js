//  This code is responsible for walking a user interaction
//  through a "wizard", which is a series of prompted interactions
//  driven from the server side.  During the interaction, a temporary
//  display list can be constructed.
//
//  It corresponds to the execution of a "define-interactive" on the
//  server side

wizardStack = [];

function clearPrompt() {
    var n = $("#wizardPrompt");
    n.removeClass("active").html( "--" ).addClass("inactive");
}

currentPrompt = null;

function setPrompt( p ) {
    var n = $("#wizardPrompt");
    n.removeClass("inactive").html( p.message ).addClass("active");
    currentPrompt = p;
}

function respondToPrompt( response ) {
    send( { action: "prompt-response",
            id: currentPrompt.id,
            value: response } );
    clearPrompt();
    currentPrompt = null;
}

function startWizard( wiz ) {
    $("#wizardName").html( "(" + wiz.id + ") " +  wiz.name );
}

function endWizard( wiz ) {
    $("#wizardName").html( "--" );
}

ActionHandlers["start-wizard"] = startWizard;
ActionHandlers["end-wizard"] = endWizard;

ActionHandlers["prompt"] = setPrompt;

function runScript( name ) {
    console.log( "Running wizard script: [" + name + "]" );
    send( { action: "invoke-command", name: name } );
    //startWizard( { prompt: { message: "Select a corner" } } );
}
