IncrementingButton = require "./incrementing_button.cjsx"
MessageDisplay = require "./message_display.cjsx"

Root = React.createClass
    displayName: "Root"
    render: -> 
        <div id="root">
            <h1>MMORPG</h1>
            <MessageDisplay />
            <IncrementingButton />
        </div>

module.exports = Root
