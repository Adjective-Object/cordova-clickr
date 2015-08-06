PlayerStore = require "../stores/player_store.cjsx"

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
    94: "5!"
    95: "4!"
    96: "3!"
    97: "2!"
    98: "1!"
    99: "congrats! you beat the game!"
    100: "uhh... you can stop now"
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
            style={"-webkit-transform": "translate(0, -64px) scale(0.1, 0.1)"}/>
    700: <img src="./img/dickbutt.png" 
            height="128px" 
            style={"-webkit-transform": "translate(0, -64px) scale(0.3, 0.3)"}/>
    800: <img src="./img/dickbutt.png" 
            height="128px" 
            style={"-webkit-transform": "translate(0, -64px) scale(0.5, 0.5)"}/>
    900: <img src="./img/dickbutt.png" 
            height="128px" 
            style={"-webkit-transform": "translate(0, -64px) scale(0.7, 0.7)"}/>
    1000: <img src="./img/dickbutt.png" 
            height="128px" 
            style={"-webkit-transform": "translate(0, -64px) scale(1.0, 1.0)"}/>


levelToMessage = (level) ->
    intkeys = (parseInt i for i in Object.keys(mapping))
    candidates = intkeys.filter((k)-> k <= level)

    if candidates.length > 0
        return mapping[Math.max.apply(null, candidates).toString()]
    else
        return ""

MessageDisplay = React.createClass
    displayName: "MessageDisplay"
    mixins: [Reflux.connect(PlayerStore, "ps")],

    incrementCounter: ->
        # console.log "incrementing counter"
        PlayerActions.updateLevel(this.state.ps.level + 1)

    render: ->
        <div className="message-display">
            {levelToMessage(this.state.ps.level)}
        </div>

module.exports = MessageDisplay
