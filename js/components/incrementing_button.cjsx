TouchButton = require "./touch_button.cjsx"
PlayerStore = require "../stores/player_store.cjsx"
PlayerActions = (require "../actions/actions.cjsx").PlayerActions

# a button that increments the player's level by 1 when tapped
IncrementingButton = React.createClass
    displayName: "IncrementingButton"

    mixins: [Reflux.connect(PlayerStore, "ps")],

    incrementCounter: ->
        # console.log "incrementing counter"
        PlayerActions.updateLevel(this.state.ps.level + 1)

    render: ->
        # render as a touchbutton that calss the incrementCounter
        # callback when tapped
        <TouchButton
            touchCallback={this.incrementCounter}>
            Level: {this.state.ps.level}
        </TouchButton>

module.exports = IncrementingButton
