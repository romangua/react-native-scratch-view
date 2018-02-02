import React, { Component, PropTypes } from 'react';
import { NativeModules, requireNativeComponent, View, Text } from 'react-native';

class ScratchImageView extends Component {

    constructor(props) {
        super(props);
        this.onRevealPercentChanged = this.onRevealPercentChanged.bind(this);
    }

    onRevealPercentChanged(e) {
        console.log("onRevealPercentChanged: " + e);
        if(!this.props.onRevealPercentChanged) {
            return;
        }
        this.props.onRevealPercentChanged(event.nativeEvent);
    }

    render() {
        return 
            <RNScratchImageView {...this.props}
                onRevealPercentChanged={this.onRevealPercentChanged}
            />;
    }
}

ScratchImageView.propTypes = {
  /*  day: PropTypes.number,
    month: PropTypes.number,
    year: PropTypes.number,
    onDateChange: PropTypes.func,*/
    onRevealPercentChanged: PropTypes.func,
    ...View.propTypes,
}

const RNScratchImageView = requireNativeComponent(`RNScratchImageView`, ScratchImageView, {
    nativeOnly: {
        onRevealPercentChanged: false,
    }
});

module.exports = ScratchImageView;
