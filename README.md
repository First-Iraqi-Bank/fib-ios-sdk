# First Iraqi bank FIBPaymentSDK

<p align="center">
<a href="https://cocoapods.org/pods/FIBPaymentSDK" alt="FIBPaymentSDK on CocoaPods" title="FIBPaymentSDK on CocoaPods"><img src="https://img.shields.io/cocoapods/v/RxSwift.svg" /></a>
<a href="https://github.com/apple/swift-package-manager" alt="FIBPaymentSDK on Swift Package Manager" title="FIBPaymentSDK on Swift Package Manager"><img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" /></a>
</p>

FIB Payment SDK is a payment library using First Iraqi Bank App written in Swift.

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#Usage)
- [Redirection](#Redirection)

## Features
- [x] Make payment transaction using FIB App.
- [x] check the status of the payments which you make.
- [x] provising a UI that you can use for handling the transactions.
- [x] provising your custome UI but the logic that we provide in this SDK. 
- [x] Supports 3 FIB apps (Personal & Business & Corporate).

## Requirements

- iOS 12.1+ 
- Xcode 11+
- Swift 5.0+

## Installation

### [CocoaPods](https://cocoapods.org)

it is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate `FIBPaymentSDK` into your Xcode project using CocoaPods, specify it in your `Podfile`:

``` ruby 
  pod 'FIBPaymentSDK', '1.1.1'
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

if you eant to integrate the SDK using SwiftPackageManager you just need to go to `File -> Swift Packages -> Add Package Dependency...` then in the search write `https://github.com/First-Iraqi-Bank/fib-ios-sdk.git`, the url for this github repository, then choose the version or the branch of interest.

## Usage
The first thing you will need to do if you want to use this SDK is creating a propertyList in your app with exactly this name:
`FIBConfiguration.plist`
this file contains the required data for the sdk to be able to work.
replace the content of the SDK with:

```ruby
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>clientSecret</key>
	<string>you will be given this secret</string>
	<key>clientId</key>
	<string>you will be given this ID</string>
	<key>grantType</key>
	<string>client_credentials</string>
	<key>baseURLs</key>
	<dict>
		<key>fibBackend</key>
		<string>this URL might change based on your need</string>
	</dict>
</dict>
</plist>

```

An overview of `FIBConfiguration.plist`:

2. `clientSecret`: an secret that you will be given to authenticate you.

3. `clientId`: an Id that you will be given to identify you as a client.

4. `grantType`: this is used for suthentication as well.

5. `baseURLs`: the baseURLs that we use for making the API requests for creating the payment, currently it only has one property which is `fibPayGate`.

the fibPayGate can be either:

  1. `develop`: which can be used for testing purposes.

```ruby
https://fib.dev.fib.iq
```

2. `production`: which you will use when you release your app.

```ruby
https://fib.prod.fib.iq
```

To use the FIBPaymentSDK you need to import it:

```swift
import FIBPaymentSDK
```

then you will need to create an instance of PayWithFIBView:

```swift
let fibView =  PayWithFIBView()
```

`PayWithFIBView` has a method named `configure` which you can call to make the view intractable:

```swift
configure(fibApplicationURLs: [FIBApplicationURLType],
          delegate: FIBPaymentManagerDelegate?)
```

it has three parameters:
1. `fibApplicationURLs`: this is an Array of Type `FIBApplicationURLType`, so we expect all the links of the `FIB apps` to be sent to this method. 
2.`delegate`: it is an instance of type `FIBPaymentManagerDelegate?` which you need to conform to in order to be notified about some extra information on the transaction.

`FIBPaymentManagerDelegate` has three methods which you can implement:

1.

```swift
func paymentCanceled(paymentID: String):
```

this one is called when you cancel a spesific payment.

2.
```swift
func didReceive(error: APIError):
```

This one will be called every time you want to start a FIB payment or check the status of a specific payment but an error occurs in the APIRequest for handling these cases you will need to implement this to deal with any `error` that might occur.

The error is of type `APIError` which is an `enum`  so that you can check what is exactly the error and update you UI accordingly.


 Doing so you enable the `fibView` to make all the required functionalities and present and alert to indicate to the user that he/she can open the available FIB applications.

`PayWithFIBView` has another method you can use and it is:

```swift
public func checkPaymentStatus(paymentID: String,
                                   completion: @escaping (PaymentStatusType?) -> Void)
```
                                   
 this one is used to check the status of a specific payment, It has two parameters:
 
`paymentID`: an ID which is used to indicate which transaction you need to check.

`completion`: which gives you a feedback about the status.

it has yet another method:

```swift
func cancelPayment(paymentID: String)
```
you call this one when you want to cancel a specific payment.

> Please note that Cancel Payment feature should not be used for refunding an item,
> this feature should be used only to cancel a pending and currently active payment.

`PayWithFIBView` has an instance of `UIButton` which you can customize for example like that:

```swift
fibView.button.setTitle(“any custom title", for: .normal)
```

and also you can assign the logic for handling payment with `FIB` your self, Incase you want to use the `SDK` but you want to use your won UI, we got your back:

we have created a class which you can use to handle all the logic but provide your own UI:

```swift
let fibPaymentManager: FIBPaymentManagerType

init(fibPaymentManager: FIBPaymentManagerType = FIBPaymentManager()) {
self.fibPaymentManager = finPaymentManager
fibPaymentManager.delegate = self
}
```

As you see `FIBPaymentManagerType` is a protocol and `FIBPaymentManager` is the class that conforms to it, we have provided this protocol in order to make your life easier in terms of testability.

It has three methods which you will need to use:

1. 
```swift 
func openFIB(_ applicationType: FIBApplicationURLType)
```
This is responsible for opening the fib apps based on you input, it has one parameter:

  a- `applicationType`: you can pass `.personalURL("personal app link")` or `.businessURL("business app link")` or, `.corporateURL("corporate app link")`, based on user’s input to you.

2. 
```swift
func checkPaymentStatus(paymentID: String,
                            completion: @escaping ((PaymentStatusType?) -> Void))
```

 this one is used to check the status of a specific payment, It has two parameters:

  a- `paymentID`: an ID which is used to indicate which transaction you need to check.
  b-`completion`: which gives you a feedback about the status.
  
3.
```swift
 func cancelPayment(paymentID: String)
 ```
 
 you call this one when you want to cancel a specific payment.

As you can see in the body of the`initializer`, `fibPaymentManager` has a property called `delegate` and it is of type `FIBPaymentManagerDelegate?` Which you need to conform to and implement its methods.

## Redirection

this SDK also includes an option to redirect the user from the FIB appllications to your application, you can provide the applications `redirect URI` and everyThing will be handled for you.

it is optional to have this feature, so if you provide your `redirect URI`, the redirection happens otherwise the FIB applications behave as they normally would.
