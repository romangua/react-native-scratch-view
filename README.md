 
# react-native-scratch-view

## Getting started

`$ npm install react-native-scratch-view --save`

### Mostly automatic installation

`$ react-native link react-native-scratch-view`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-scratch-view` and add `RNScratchView.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNScratchView.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNScratchViewPackage;` to the imports at the top of the file
  - Add `new RNScratchViewPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-scratch-view'
  	project(':react-native-scratch-view').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-scratch-view/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-scratch-view')
  	```


## Usage
```javascript

import React, { Component } from 'react';
import { View, Text, StyleSheet} from 'react-native';
import ScratchImageView from 'react-native-scratch-view';

export default class App extends Component {

constructor(props) {
   super(props);

   this.state = {
     onRevealPercentChanged: 0,
     onRevealed: "false"
   };
   this.onRevealPercentChanged = this.onRevealPercentChanged.bind(this);
   this.onRevealed = this.onRevealed.bind(this);
}

onRevealed() {
   this.setState({onRevealed: "true"});
}

onRevealPercentChanged(e) {
   this.setState({onRevealPercentChanged: e});
}

render() {
   return (
     <View style={styles.container}>
        <ScratchImageView 
	  style={{height: 350, width: 350}}
	  onRevealPercentChanged={this.onRevealPercentChanged}
	  onRevealed={this.onRrevealPercent={50}
	  strokeWidth={20}
	  imageScratched={{uri: 'https://static.iris.net.co/semana/upload/images/2016/6/2/476094_1.jpg'}}
	  imagePattern={{uri: 'https://s3-media3.fl.yelpcdn.com/bphoto/Meh1qnJ-w95iitwbIF7moA/348s.jpg'}}
	/>
	<Text>onRevealPercentChanged: {this.state.onRevealPercentChanged} %</Text>		
	<Text>onRevealed: {this.state.onRevealed}</Text>
     </View>
    );
  }
}

const styles = StyleSheet.create({
   container: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center'
   }
});

```
  
