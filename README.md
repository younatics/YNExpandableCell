# YNExpandableCell

[![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome)
[![Version](https://img.shields.io/cocoapods/v/YNExpandableCell.svg?style=flat)](http://cocoapods.org/pods/YNExpandableCell)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/YNExpandableCell.svg)](http://cocoadocs.org/docsets/YNExpandableCell)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/younatics/YNExpandableCell/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/younatics/YNExpandableCell.svg?branch=master)](https://travis-ci.org/younatics/YNExpandableCell)
[![Platform](https://img.shields.io/cocoapods/p/YNExpandableCell.svg?style=flat)](http://cocoapods.org/pods/YNExpandableCell)
[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/)

#### ✨[Listed 5th at trending open source and 8th at trending developer in Github Swift category [03/21/2017]](https://github.com/younatics/YNExpandableCell/blob/master/Images/5th.PNG)

## Updates

See [CHANGELOG](https://github.com/younatics/YNExpandableCell/blob/master/CHANGELOG.md) for details

## Intoduction
Easiest usage of expandable & collapsible cell for iOS, written in Swift 3. You can customize expandable `UITableViewCell` whatever you like. `YNExpandableCell` is made because `insertRows` and `deleteRows` is hard to use. You can just inheirt `YNTableViewDelegate` and add one more method `func tableView(_ tableView: YNTableView, expandCellAt indexPath) -> UITableViewCell?` 

![demo](Images/YNExpandableCell.gif)

## Requirements

`YNExpandableCell` written in Swift 3. Compatible with iOS 8.0+

## Installation

### Cocoapods

YNExpandableCell is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YNExpandableCell'
```
### Carthage
```
github "younatics/YNExpandableCell"
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

#### Use one of required method
Set expandable cell in `YNTableViewDelegate` method (Required)
```swift
func tableView(_ tableView: YNTableView, expandCellAt indexPath: IndexPath) -> UITableViewCell? {
    let ynSliderCell = tableView.dequeueReusableCell(withIdentifier: YNSliderCell.ID) as! YNSliderCell
    if indexPath.section == 0 && indexPath.row == 1 {
        return ynSliderCell
     }
     return nil
}
```

Set expandable cell with height in `YNTableViewDelegate` method using `YNTableViewCell` object (Required) 
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

Cutomize `UITableViewRowAnimation`
```swift
self.ynTableView.ynTableViewRowAnimation = UITableViewRowAnimation.top
```

Make Extensions for more `UITableViewDelegate` if you need or make pull request for me :)

## References
#### Please tell me or make pull request if you use this library in your application :) 
[@zigbang](https://github.com/zigbang)

## Author
[younatics 🇰🇷](http://younatics.github.io)

## License
YNExpandableCell is available under the MIT license. See the LICENSE file for more info.
