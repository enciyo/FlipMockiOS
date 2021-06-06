<p align="center">
  <img src="https://fbflipper.com/img/icon.png" alt="logo" width="20%"/>
</p>
<h1 align="center">
  FlipMock
</h1>

<p align="center">
  <a href="">FlipMock</a> is a extended <a href="https://github.com/facebook/flipper"> Flipper </a> plugin that manipulates network response.
</p>


## Table of Contents

- [Using FlipMock](#using-flipmock)
  - [AppDelegate](#appdelegate)
  - [Making Simple Request (Not recomended for production)](#making-simple-request-not-recomended-for-production)
  - [Recomended Usage](#recomended-usage)
  - [If you need customize your session](#if-you-need-customize-your-session)
    - [Warning](#warning)
- [How can I mock the response?](#how-can-i-mock-the-response)


## SDK Features

- [x] Support <a href="https://github.com/Alamofire/Alamofire">Alomofire</a>
- [ ] Support <a href="https://github.com/Moya/Moya">Moya</a>
### Waiting for FlipMock Desktop Plugin support
- [x] Mock the response by HTTP method. 
- [x] Mock the response by query parameters. 
- [x] For response, support HTTP code



## Installation

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate FlipMock into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
# ...
# Flipper integration
#  ...
pod 'FlipperNetworkMockPlugin', :git => 'https://github.com/enciyo/FlipMockiOS'
```

<a href="https://fbflipper.com/docs/getting-started/ios-native">How to adding Flipper to IOS apps?</a>

# Using FlipMock

## AppDelegate


```swift
import UIKit
import FlipperMockPlugin
import FlipperKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let client = FlipperClient.shared() // from FlipperKit
        //...
        client?.add(FlipMock.plugin)
        //...
        client?.start()
        return true
    }
```

## Making Simple Request (Not recomended for production)
```swift
FM.request("https://httpbin.org/get").response { response in
    debugPrint(response)
}
```

## Recomended Usage 

```swift
    private lazy var session : Session = {
        #if DEBUG
        return FM //FlipMock
        #endif
        return AF //Alomofire
    }()
    
    func fetch(onSuccess : @escaping (String?) -> Void){
        self.session.request("https://httpbin.org/get").response { response in
    			debugPrint(response)
		}
    }

```

## If you need customize your session

```swift
 private lazy var customMockSession: Session = {
             let configuration: URLSessionConfiguration = {
                 let configuration = URLSessionConfiguration.af.default
                 //@Warning => [FlipMockUrlProtocol.self] should be first
                 let safeProtocolClasses = [FlipMockUrlProtocol.self] + (configuration.protocolClasses ?? [])
                 configuration.protocolClasses = safeProtocolClasses
                 return configuration}()
         return Session(configuration:configuration)}()
```

### Warning
FlipMockUrlProtocol should be first
```swift
let safeProtocolClasses = [FlipMockUrlProtocol.self] + (configuration.protocolClasses ?? [])
``` 


# How can I mock the response?
In this section, you can mock response using   <a href="">FlipMock</a>  desktop Plugin on the  <a href="https://github.com/facebook/flipper"> Flipper.</a>

<a href="">How to use FlipMock Desktop Plugin?</a>


