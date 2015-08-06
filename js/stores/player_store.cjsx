PlayerActions = (require "../actions/actions.cjsx").PlayerActions


defaultState =
    level: 0

PlayerStore = Reflux.createStore
    # actions this store listens to
    listenables: [PlayerActions]

    # the initial state of the store from localstorage
    # if that fails, use the default
    getInitialState: ->
        storageState = window.localStorage.getItem("playerState")
        this.playerState =
            if storageState then JSON.parse(storageState) else defaultState
        return this.playerState

    # responses to actions are dispatched automatically by action name
    # (i.e. updateLevel -> onUpdateLevel)
    onUpdateLevel: (level) ->
        if this.level != level
            this.playerState.level = level
            this.cacheAndTrigger()

    # cache the player state to local stoarage and then
    # notify listening objects of the change
    cacheAndTrigger: ->
        window.localStorage.setItem(
            "playerState",
            JSON.stringify(this.playerState))
        this.trigger(this.playerState)

module.exports = PlayerStore
