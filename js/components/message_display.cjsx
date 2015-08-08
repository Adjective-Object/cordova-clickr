PlayerStore = require "../stores/player_store.cjsx"
ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

# mapping between the minimum level required to see a message
# and the body of the message
mapping =
    0:  "welcome to MMORPG!"
    10: "gz on level 10!"
    20: "wow, you're really going at it"
    30: "do you feel satisfied with your life right now?"
    40: "yeah, you click that button!"
    50: "mmm fun"
    60: "great job!"
    70: "woa, nearing level cap already!?"
    80: "almost there,  just 19 more levels"
    90: "endgame here we come!"
    94: "so.."
    96: "close.."
    99: "congrats! you beat the game!"
    110: "uhh... you can stop now"
    120: "no really, that's it, the game is done..."
    150: "why are you doing this?"
    170: "are you hoping to get some kind of satisfaction out of it?"
    200: "you're just clicking a button.."
    240: "is this about your parents?"
    290: "did they not pay enough attention to you? is that why you're \
          clicking so much?"
    340: "really it's okay you don't have to keep pressing the button"
    370: "just put the phone down, man"
    400: "put.."
    410: "the phone.."
    420: "down!"
    430: "..."
    450: "you didn't put the phone down"
    460: "well fine then, I'm not going to keep talking to you if you're \
         just going to keep pressing that button"
    480: ""
    500: "stop."
    600: <img src="./img/dickbutt.png"
              height="128px"
              style={"WebkitTransform": "scale(0.1, 0.1)"}/>
    700: <img src="./img/dickbutt.png"
              height="128px"
              style={"WebkitTransform": "scale(0.3, 0.3)"}/>
    800: <img src="./img/dickbutt.png"
              height="128px"
              style={"WebkitTransform": "scale(0.5, 0.5)"}/>
    900: <img src="./img/dickbutt.png"
              height="128px"
              style={"WebkitTransform": "scale(0.7, 0.7)"}/>
    1000: <img src="./img/dickbutt.png"
              height="128px"
              style={"WebkitTransform": "scale(1.0, 1.0)"}/>


# get the appropriate message for any level
levelToMessage = (level) ->
    intkeys = (parseInt i for i in Object.keys(mapping))
    candidates = intkeys.filter((k)-> k <= level)

    return (
        if (candidates.length > 0)
        then mapping[Math.max.apply(null, candidates).toString()]
        else "")


MessageDisplay = React.createClass
    displayName: "MessageDisplay"
    mixins: [Reflux.connect(PlayerStore, "ps")],

    clearExitAnim: ->
        (React.getDOMElement this.refs.old)

    render: ->
        msg = levelToMessage(this.state.ps.level)

        # the ReactCSSTransitionGroup automatically manages changing children.
        # when a new child is added (as identified by key), it gets the class
        # .textcycle-enter and when it leaves, it gets the class
        # .textcycle-leave. optionally .textcycle-appear, if transitionAppear
        # is specified
        <ReactCSSTransitionGroup
            transitionName="textcycle"
            transitionAppear={true}>

            <div className="message-display"
                 key={msg}>
                {msg}
            </div>
        </ReactCSSTransitionGroup>

module.exports = MessageDisplay
