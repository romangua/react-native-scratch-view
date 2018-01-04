import React, { Component, PropTypes } from 'react';
import { NativeModules, requireNativeComponent, View, Text } from 'react-native';

class ScratchImageView extends Component {
    constructor(props) {
        super(props);
    }

    render() {
        return <RNScratchImageView {...this.props} />;
    }
}

ScratchImageView.propTypes = {
    ...View.propTypes,
}

const RNScratchImageView = requireNativeComponent(`RNScratchImageView`, ScratchImageView);

module.exports = ScratchImageView;
