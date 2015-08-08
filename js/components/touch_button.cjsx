TouchButton = React.createClass
    displayName: "TouchButton"
    elemBounds: {
        bottom: undefined
        height: undefined
        left:   undefined
        right:  undefined
        top:    undefined
        width:  undefined
    }

    getInitialState: ->
        return {
            tracking_touch: false
        }

    getDefaultProps: ->
        return {
            touchCallback: -> null
        }

    componentWillMount: ->
        React.initializeTouchEvents true

    componentDidMount: ->
        elem = React.findDOMNode(this)
        this.elemBounds = elem.getBoundingClientRect()
        this.elemCenter = {
            x: this.elemBounds.left + this.elemBounds.width / 2
            y: this.elemBounds.top + this.elemBounds.height / 2
        }

    handleTouchStart: (e) ->
        this.setState({
            tracking_touch: true
            })
        e.preventDefault();

    handleTouchMove: (e) ->
        touch = e.nativeEvent.changedTouches[0]
        relativeX = touch.pageX - this.elemCenter.x
        relativeY = touch.pageY - this.elemCenter.y

        should_cancel = (
            (Math.abs relativeX) > this.elemBounds.width / 2 + touch.radiusX or
            (Math.abs relativeY) > this.elemBounds.height / 2 + touch.radiusY)

        this.handleTouchCancel() if should_cancel

    handleTouchCancel: (e) ->
        this.setState({
            tracking_touch: false
            })

    handleTouchEnd: (e) ->
        if this.state.tracking_touch
            this.props.touchCallback()
            this.setState({
                tracking_touch: false
                })

    render: ->
        classes = {
            "custom-button": true,
            "active": this.state.tracking_touch
        }

        <div className=classNames(classes)
             onTouchStart={this.handleTouchStart}
             onTouchMove={this.handleTouchMove}
             onTouchCancel={this.handleTouchCancel}
             onTouchEnd={this.handleTouchEnd}

             onMouseDown={this.handleTouchStart}
             onMouseUp={this.handleTouchEnd}>

             
             <div className="over">
                {this.props.children}
             </div>
             
             <div className="under">
             </div>
        </div>

module.exports = TouchButton
