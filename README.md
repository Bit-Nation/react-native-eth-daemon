# React Native Eth Daemon

## Getting started

`$ npm install react-native-eth-daemon --save`

### Mostly automatic installation

`$ react-native link react-native-eth-daemon`

#### Android
Open the "android" project of your React-Native app in Android Studio and add to "build.gradle(Project)" this:
    ```
      allprojects {
        ...
        flatDir {
          dirs "$rootDir/../node_modules/react-native-eth-daemon/android/geth"
        }
      }
    ```

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-eth-daemon` and add `RNEthDaemon.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNEthDaemon.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNEthDaemonPackage;` to the imports at the top of the file
  - Add `new RNEthDaemonPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-eth-daemon'
  	project(':react-native-eth-daemon').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-eth-daemon/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-eth-daemon')
  	```
4. It's necessary to add to "build.gradle(Project)" this:
    ```
      allprojects {
        ...
        flatDir {
          dirs "$rootDir/../node_modules/react-native-eth-daemon/android/geth"
        }
      }
    ```

## Usage
```javascript
import RNEthDaemon from 'react-native-eth-daemon';

And then use the functions startDaemon/stopDaemon as follow inside your JS:

async function startFunction() {
  try {
    let result = await RNEthDaemon.startDaemon({
      enabledEthereum:true,
      networkID:3,
      enodesNumber:16,
      maxPeers:25,
      enabledWhisper:false
    });
    Alert.alert(result);
  } catch(e) {
    Alert.alert('There was a problem starting the Node');
  }
}

async function stopFunction() {
  try {
    let result = await RNEthDaemon.stopDaemon();
    Alert.alert(result);
  }  catch(e) {
    Alert.alert('There was a problem stopping the Node');
  }
}
```

## Development
- We are using [this](http://nvie.com/posts/a-successful-git-branching-model/) git workflow. Please make sure to read it.
- Make sure to prefix your git commit's with an "topic" like to `[git] blacklisted .idea folder`
