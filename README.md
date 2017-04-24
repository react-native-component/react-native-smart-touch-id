# react-native-smart-touch-id

[![npm](https://img.shields.io/npm/v/react-native-smart-touch-id.svg)](https://www.npmjs.com/package/react-native-smart-touch-id)
[![npm](https://img.shields.io/npm/dm/react-native-smart-touch-id.svg)](https://www.npmjs.com/package/react-native-smart-touch-id)
[![npm](https://img.shields.io/npm/dt/react-native-smart-touch-id.svg)](https://www.npmjs.com/package/react-native-smart-touch-id)
[![npm](https://img.shields.io/npm/l/react-native-smart-touch-id.svg)](https://github.com/react-native-component/react-native-smart-touch-id/blob/master/LICENSE)

Smart authentication with the native Touch ID popup for React Native app.

This component is compatible with React Native 0.25 and newer, only supports iOS.

## Preview

![react-native-smart-touch-id-preview][1]

## Installation

```
npm install react-native-smart-touch-id --save
```

## Notice

It can only be used greater-than-equal react-native 0.4.0 for ios, if you want to use the package less-than react-native 0.4.0, use `npm install react-native-smart-touch-id@untilRN0.40 --save`


## Installation (iOS)

* Drag RCTTouchId.xcodeproj to your project on Xcode.

* Click on your main project file (the one that represents the .xcodeproj) select Build Phases and drag libRCTTouchId.a from the Products folder inside the RCTTouchId.xcodeproj.

* Look for Header Search Paths and make sure it contains $(SRCROOT)/../../../react-native/React as recursive.

## Full Demo

see [ReactNativeComponentDemos][0]

## Usage

```js

import React, {
  Component
} from 'react'
import {
  View,
  Text,
  Alert,
  StyleSheet
} from 'react-native'

import TouchId from 'react-native-smart-touch-id'
import Button from 'react-native-smart-button'

export default class TouchIdTest extends Component {

  render() {
    return (
      <View style={{flex: 1, justifyContent: 'center', alignItems: 'center', }}>
          <Button
            touchableType={'blur'}
            style={{marginVertical: 10, width: 300, justifyContent: 'center', height: 40, backgroundColor: 'red', borderRadius: 3, borderWidth: StyleSheet.hairlineWidth, borderColor: 'red', justifyContent: 'center',}}
            textStyle={{fontSize: 17,  color: 'white'}}
            onPress={this._isSupported}>
            verify if touchId is supported
          </Button>
          <Button
            touchableType={'blur'}
            style={{marginVertical: 10, width: 300, justifyContent: 'center', height: 40, backgroundColor: 'red', borderRadius: 3, borderWidth: StyleSheet.hairlineWidth, borderColor: 'red', justifyContent: 'center',}}
            textStyle={{fontSize: 17,  color: 'white'}}
            onPress={this._trggerTouchId}>
            trigger touch id
          </Button>
        </View>
    )
  }

  //_isSupported = () => {
  //  TouchId.isSupported( (error) => {
  //    if (error) {
  //      Alert.alert('TouchId is not supported!')
  //    } else {
  //      Alert.alert('TouchId is supported!')
  //    }
  //  })
  //}

  _isSupported = async () => {
      try {
          await TouchId.isSupported()
          Alert.alert('TouchId is supported!')
      } catch(e) {
          Alert.alert('TouchId is not supported!')
      }
  }

  //_trggerTouchId = () => {
  //    let description = 'Verify the existing mobile phone fingerprint using the home key'
  //    //let title       //fallback button title will be default as 'Enter Password'(localized)
  //    //let title = ""  //fallback button will be hidden
  //    let title = "Verify Password"   //fallback button title will be 'Verify Password'(unlocalized)
  //    TouchId.verify(description, title, (error) => {
  //        if (error) {
  //            if (error.message == '-3') {
  //                //fallback button is pressed
  //                Alert.alert('errorCode: ' + error.message + ' verify failed, user wants to ' + title)
  //            }
  //            else {
  //                Alert.alert('errorCode: ' + error.message + ' verify failed')
  //            }
  //        } else {
  //            Alert.alert('verify succeeded')
  //        }
  //    })
  //}

  _trggerTouchId = async () => {
      let description = 'Verify the existing mobile phone fingerprint using the home key'
      //let title       //fallback button title will be default as 'Enter Password'(localized)
      //let title = ""  //fallback button will be hidden
      let title = "Verify Password"   //fallback button title will be 'Verify Password'(unlocalized)
      try {
          await TouchId.verify({
              description,
              title,
          });
          //await TouchId.verify("123123123123");
          Alert.alert('verify succeeded')
      } catch(e) {
          if (e.code == '-3') {
              //fallback button is pressed
              Alert.alert('errorCode: ' + e.code + ' verify failed, user wants to ' + title)
          }
          else {
              Alert.alert('errorCode: ' + e.code + ' verify failed')
          }
      }
  }

}

```

## Errors

There are various reasons why authenticating with Touch ID may fail.
Whenever calling Touch ID authentication fails, `TouchId.verify` will return an error code.

More information on errors can be found in [Apple's Documentation][2].

[0]: https://github.com/cyqresig/ReactNativeComponentDemos
[1]: http://cyqresig.github.io/img/react-native-smart-touch-id-preview-v1.0.2.gif
[2]: https://developer.apple.com/library/prerelease/ios/documentation/LocalAuthentication/Reference/LAContext_Class/index.html#//apple_ref/c/tdef/LAError
