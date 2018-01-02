'use strict';

var React = require('react');
var PropTypes = require('prop-types');
var {
    requireNativeComponent,
    View,
    UIManager,
    DeviceEventEmitter
} = require('react-native');

class ScratchImageView extends React.Component {
    constructor() {
        super();
        this.onChange = this.onChange.bind(this);
        this.subscriptions = [];
    }

    onChange(event) {
        if(event.nativeEvent.dragged){
            if (!this.props.onDragEvent) {
                return;
            }
            this.props.onDragEvent({
                dragged: event.nativeEvent.dragged
            });
        }
    }

    componentDidMount() {
        if (this.props.onDragEvent) {
            let sub = DeviceEventEmitter.addListener(
                'onDragEvent',
                this.props.onDragEvent
            );
            this.subscriptions.push(sub);
        }
    }

    componentWillUnmount() {
        this.subscriptions.forEach(sub => sub.remove());
        this.subscriptions = [];
    }

    render() {
        return (
            <RNScratchImageView {...this.props} onChange={this.onChange} />
        );
    }
}

ScratchImageView.propTypes = {
    ...View.propTypes
};

var RNScratchImageView = requireNativeComponent('RNScratchImageView', ScratchImageView, {
    nativeOnly: { onChange: true }
});

module.exports = ScratchImageView;
