
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

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNScratchView.sln` in `node_modules/react-native-scratch-view/windows/RNScratchView.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Scratch.View.RNScratchView;` to the usings at the top of the file
  - Add `new RNScratchViewPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNScratchView from 'react-native-scratch-view';

// TODO: What to do with the module?
RNScratchView;
```
  