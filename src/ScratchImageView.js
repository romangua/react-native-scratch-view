import React, { Component } from 'react';
import { PropTypes } from 'prop-types';
import { NativeModules, requireNativeComponent, View, Text } from 'react-native';

class ScratchImageView extends Component {

    constructor(props) {
        super(props);
        this._onRevealPercentChanged = this._onRevealPercentChanged.bind(this);
        this._onRevealed = this._onRevealed.bind(this);
    }

    _onRevealPercentChanged(e) {
        if (!this.props.onRevealPercentChanged) {
            return;
        }
        this.props.onRevealPercentChanged(e.nativeEvent.value);
    }

    _onRevealed(e) {
        if (!this.props.onRevealed) {
            return;
        }
        this.props.onRevealed();
    }
    
    render() {
        return (
            <RNScratchImageView {...this.props} 
               onRevealPercentChanged={this._onRevealPercentChanged} 
               onRevealed={this._onRevealed}
            />
        );
    }
}

ScratchImageView.propTypes = {
    revealPercent: PropTypes.number,
    imageScratched: PropTypes.object,
    imagePattern: PropTypes.object,
    strokeWidth: PropTypes.number,
    onRevealed: PropTypes.func,
    onRevealPercentChanged: PropTypes.func,
    ...View.propTypes,
}

const RNScratchImageView = requireNativeComponent(`RNScratchImageView`, ScratchImageView);

module.exports = ScratchImageView;
