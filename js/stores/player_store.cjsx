PlayerActions = (require "../actions/actions.cjsx").PlayerActions

PlayerStore = Reflux.createStore
    # actions this store listens to
    listenables: [PlayerActions]

    # the initial state of the store
    getInitialState: ->
        this.playerState = {
            level: 0
        }
        return this.playerState

    # responses to actions are dispatched automatically by action name
    # (i.e. updateLevel -> onUpdateLevel)
    onUpdateLevel: (level) ->
        if this.level != level
            # console.log "updating level #{this.playerState.level} -> #{level}"
            this.playerState.level = level
            this.trigger(this.playerState)
        else
            # console.log "ignoring level update #{this.playerState.level} -> #{level}"



module.exports = PlayerStore
