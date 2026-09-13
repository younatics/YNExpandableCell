# USE [ExpandableCell](https://github.com/younatics/ExpandableCell). New version of this library.
# YNExpandableCell

[![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager/)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/YNExpandableCell.svg?style=flat)](https://cocoapods.org/pods/YNExpandableCell)
[![Platform](https://img.shields.io/badge/platform-iOS%2013%2B-lightgrey.svg?style=flat)](https://developer.apple.com/ios/)
[![Swift 6.0](https://img.shields.io/badge/Swift-6.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/younatics/YNExpandableCell/blob/master/LICENSE)

## Updates
See [CHANGELOG](https://github.com/younatics/YNExpandableCell/blob/master/CHANGELOG.md) for details

## Intoduction
Easiest usage of expandable & collapsible cell for iOS, written in Swift 6. You can customize expandable `UITableViewCell` whatever you like. `YNExpandableCell` is made because `insertRows` and `deleteRows` is hard to use. You can just inherit `YNTableViewDelegate` and add one more method `func tableView(_ tableView: YNTableView, expandCellAt indexPath: IndexPath) -> UITableViewCell?`

![demo](Images/demo.gif)

## Requirements

`YNExpandableCell` is written in Swift 6 and uses Swift tools version 6.0. It supports iOS 13.0+ through Swift Package Manager and CocoaPods. The CocoaPods deployment target is also iOS 13.0.

## Installation

### Swift Package Manager

In Xcode, choose **File ▸ Add Package Dependencies…** and enter:

```
https://github.com/younatics/YNExpandableCell.git
```

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/younatics/YNExpandableCell.git", from: "2.0.0")
]
```

### CocoaPods

YNExpandableCell 2.0.0 is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YNExpandableCell', '2.0.0'
```

## Usage
```swift
import YNExpandableCell
```

Make `YNTableView` in Storyboard or in code
```swift
@IBOutlet var ynTableView: YNTableView!
```

Inherit `YNTableViewDelegate`
```swift
class ViewController: UIViewController, YNTableViewDelegate 
```

Set delegate and register cells
```swift
self.ynTableView.ynDelegate = self

let cells = ["YNExpandableCellEx","YNSliderCell","YNSegmentCell"]
self.ynTableView.registerCellsWith(nibNames: cells, and: cells)
self.ynTableView.registerCellsWith(cells: [UITableViewCell.self as AnyClass], and: ["YNNonExpandableCell"])
```

#### Use one of the expandable-cell methods
Set expandable cell in a `YNTableViewDelegate` method:
```swift
func tableView(_ tableView: YNTableView, expandCellAt indexPath: IndexPath) -> UITableViewCell? {
    let ynSliderCell = tableView.dequeueReusableCell(withIdentifier: YNSliderCell.ID) as! YNSliderCell
    if indexPath.section == 0 && indexPath.row == 1 {
        return ynSliderCell
     }
     return nil
}
```

Or set an expandable cell with a height using a `YNTableViewCell` object:
```swift
func tableView(_ tableView: YNTableView, expandCellWithHeightAt indexPath: IndexPath) -> YNTableViewCell? {
    let ynSliderCell = YNTableViewCell()
    ynSliderCell.cell = tableView.dequeueReusableCell(withIdentifier: YNSliderCell.ID) as! YNSliderCell
    ynSliderCell.height = 142

    if indexPath.section == 0 && indexPath.row == 1 {
        return ynSliderCell
    }
        return nil
}
```

Get didSelectRowAt in `YNTableViewDelegate` method (Optional)
```swift
func tableView(_ tableView: YNTableView, didSelectRowAt indexPath: IndexPath, isExpandableCell: Bool, isExpandedCell: Bool) {
    print("Selected Section: \(indexPath.section) Row: \(indexPath.row) isExpandableCell: \(isExpandableCell) isExpandedCell: \(isExpandedCell)")
}

```

Get didDeselectRowAt in `YNTableViewDelegate` method (Optional)
```swift
func tableView(_ tableView: YNTableView, didDeselectRowAt indexPath: IndexPath, isExpandableCell: Bool, isExpandedCell: Bool) {
    print("Deselected Section: \(indexPath.section) Row: \(indexPath.row) isExpandableCell: \(isExpandableCell) isExpandedCell: \(isExpandedCell)")
}
```

Set basic `UITableViewDataSource`, `UITableViewDelegate` and Done!

### Customize

Expand & Collapse All if you want 
```swift
self.ynTableView.expandAll()
self.ynTableView.collapseAll()
```

Inherit `YNExpandableCell` if you want awesome '+' '-' custom accessory type
```swift
class YNExpandableCellEx: YNExpandableCell

// Change normalCustomAccessoryType, selectedCustomAccessoryType Images
```

Cutomize `UITableView.RowAnimation`
```swift
self.ynTableView.ynTableViewRowAnimation = UITableView.RowAnimation.top
```

Make Extensions for more `UITableViewDelegate` if you need or make pull request for me :)

## References
#### Please tell me or make pull request if you use this library in your application :) 
#### [@zigbang](https://github.com/zigbang)
#### [MotionBook](https://github.com/younatics/MotionBook)
## Author
[younatics](https://twitter.com/younatics)
<a href="http://twitter.com/younatics" target="_blank"><img alt="Twitter" src="https://img.shields.io/twitter/follow/younatics.svg?style=social&label=Follow"></a>

## License
YNExpandableCell is available under the MIT license. See the LICENSE file for more info.
