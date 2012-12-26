//  This code is responsible for walking a user interaction
//  through a "wizard", which is a series of prompted interactions
//  driven from the server side.  During the interaction, a temporary
//  display list can be constructed.
//
//  It corresponds to the execution of a "define-interactive" on the
//  server side

wizardStack = [];

function clearPrompt() {
    var p = $("#wizardPrompt");
    p.removeClass("active").html( "no interaction" ).addClass("inactive");
}

function setPrompt( cmd ) {
    var p = $("#wizardPrompt");
    p.removeClass("inactive").html( cmd.message ).addClass("active");
}

function startWizard( wiz ) {
    var depth = wizardStack.length;
    wizardStack[depth] = wiz;
    wiz.displayList = [];
    setPrompt( wiz.prompt );
}

function runScript( name ) {
    console.log( "Running wizard script: [" + name + "]" );
    startWizard( { prompt: { message: "Select a corner" } } );
}
