# MomentsGallery

[![CI Status](http://img.shields.io/travis/fortyfox/MomentsGallery.svg?style=flat)](https://travis-ci.org/Melvin Beemer/MomentsGallery)
[![Version](https://img.shields.io/cocoapods/v/MomentsGallery.svg?style=flat)](http://cocoapods.org/pods/MomentsGallery)
[![License](https://img.shields.io/cocoapods/l/MomentsGallery.svg?style=flat)](http://cocoapods.org/pods/MomentsGallery)
[![Platform](https://img.shields.io/cocoapods/p/MomentsGallery.svg?style=flat)](http://cocoapods.org/pods/MomentsGallery)

MomentsGallery is a gallery view controller inspired by Twitter's Moments. It includes a parallax effect while swiping between photos, tap to view the full photo and the ability to add a title and a caption.

![MomentsGallery Exmaple](https://i.imgur.com/F5DzQIw.gif)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Local images
```swift
var images = ["1.jpg", "2.jpg", "3.jpg"]
var moments: [Moment] = []

for imagePath in images {
    let moment = Moment(image: UIImage(named: imagePath))
    moments.append(moment)
}

let momentsVC = MomentsGallery(moments: moments)
self.presentViewController(momentsVC, animated: true, completion: nil)
```
### Images from the web
```swift
var images = ["http://url.com/1.jpg", "http://url.com/2.jpg", "http://url.com/3.jpg"]
var moments: [Moment] = []

for imageUrl in images {
    let moment = Moment(url: imageUrl)
    moments.append(moment)
}

let momentsVC = MomentsGallery(moments: moments)
self.presentViewController(momentsVC, animated: true, completion: nil)
```

### Controlling the page index
```swift
let momentsVC = MomentsGallery(moments: [moment, moment, moment])
momentsVC.initialPageIndex = 2 // Set initial index before presenting, not animated
self.presentViewController(momentsVC, animated: true, completion: nil)

momentsVC.scrollToIndex(2) // Set index after view controller is presented, animated
```

## Requirements
* Swift 2.1
* iOS 8.2

## Dependencies
* [HanekeSwift](https://github.com/Haneke/HanekeSwift)

## Installation

MomentsGallery is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MomentsGallery"
```

To install MomentsView with Carthage add the following line to your `cartfile`

```
github "Fortyfox/MomentsGallery" ~> 0.1.0
```

## Author

Melvin Beemer, melvin.beemer@gmail.com

## License

MomentsGallery is available under the MIT license. See the LICENSE file for more info.
