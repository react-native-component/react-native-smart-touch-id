# react-native-smart-touch-id

Smart authentication with the native Touch ID popup for React Native app.

This component is compatible with React Native 0.25 and newer.

## Preview

![react-native-smart-touch-id-preview][1]

## Installation

```
npm install react-native-smart-touch-id --save
```

or

```
npm install @react-native-component/react-native-smart-touch-id --save
```

```js

export default class TouchIdTest extends Component {

  render() {
    return (
      <View style={{flex: 1, justifyContent: 'center', alignItems: 'center', }}>
        <Text style={{margin: 20, }} onPress={this._isSupported}>verify whether touchId is supported</Text>
        <Text style={{margin: 20, }} onPress={this._trggerTouchId}>trigger touch id</Text>
      </View>
    )
  }

  _isSupported = () => {
    TouchId.isSupported( (error) => {
      if (error) {
        Alert.alert('TouchId is not supported!')
      } else {
        Alert.alert('TouchId is supported!')
      }
    })
  }

  _trggerTouchId = () => {
    let description = 'Verify the existing mobile phone fingerprint using the home key'
    //let title       //fallback button title will be default as 'Enter Password'(localized)
    //let title = ""  //fallback button will be hidden
    let title = "Verify Password"   //fallback button title will be default as 'Verify Password'(unlocalized)
    TouchId.verify( description, title, (error) => {
      if (error) {
        if(error.message == '-3') {
            //fallback button is pressed
          Alert.alert('errorCode: ' + error.message + ' verify failed, user wants to ' + title)
        }
        else {
          Alert.alert('errorCode: ' + error.message + ' verify failed')
        }
      } else {
        Alert.alert('verify succeeded')
      }
    })
  }

}

```

## Errors

There are various reasons why authenticating with Touch ID may fail.
Whenever calling Touch ID authentication fails, `TouchId.verify` will return an error code
More information on errors can be found in [Apple's Documentation][2].


[1]: http://cyqresig.github.io/img/react-native-smart-touch-id-preview-v1.0.0.gif
[2]: https://developer.apple.com/library/prerelease/ios/documentation/LocalAuthentication/Reference/LAContext_Class/index.html#//apple_ref/c/tdef/LAError