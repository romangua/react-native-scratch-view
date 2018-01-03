import React, { Component, PropTypes } from 'react';
import { NativeModules, requireNativeComponent, View, Text } from 'react-native';

class ScratchImageView extends Component {
    constructor(props) {
        super(props);
        this._onChange = this._onChange.bind(this);
    }

    _onChange(event) {
        /*if(!this.props.onDateChange) {
            return;
        }
        this.props.onDateChange(event.nativeEvent); */
    }

    render() {
        return <RNScratchImageView {...this.props} onChange={this._onChange} />;
    }
}

ScratchImageView.propTypes = {
  /*  day: PropTypes.number,
    month: PropTypes.number,
    year: PropTypes.number,
    onDateChange: PropTypes.func,*/
    ...View.propTypes,
}

const RNScratchImageView = requireNativeComponent(`RNScratchImageView`, ScratchImageView, {
    nativeOnly: {
        onChange: true,
    }
});
