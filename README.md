
# TapeTextView
![](https://img.shields.io/badge/platform-iOS-gray) ![](https://img.shields.io/badge/iOS-CoreText-green)

## Introduction
`TapeTextView` is a UITextViewSubclass which gives you the opportunity to add a marker pen effect to your text.

<img src ="https://user-images.githubusercontent.com/6486741/76167402-4921e680-615e-11ea-870d-095d0b3aa1e3.gif" width="50%" >

---

## Installation

### Cocoapods

Install [Cocoapods](https://cocoapods.org/#install) if need be.

```bash
$ gem install cocoapods
```

Add `TapeTextView` in your `Podfile`.

```ruby
use_frameworks!

pod 'TapeTextView'
```

Then, run the following command.

```bash
$ pod install
```

## Initialization

- With Autolayout

```swift
let tapeView = TapeTextView()
tapeView.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(tapeView)

tapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
tapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

tapeView.attributedText = NSAttributedString(string: text, attributes: [.font: font])
tapeView.tapeColor = color
```

- Without Autolayout

```swift
let tapeView = TapeTextView(frame: frame)
tapeView.attributedText = NSAttributedString(string: text, attributes: [.font: font])
tapeView.tapeColor = color
tapeView.autoresizeBasedOnTextLength = autoResize
view.addSubview(tapeView)
```

---


## Features

You can control
- the inclination of the marker effect via `var degrees: CGFloat` 
- the height factor of the marker effect via `var heightFactor: CGFloat`
- the lineSpacing via `var lineSpacing: CGFloat`

---


## Contributing

### Step 1

- **Option 1**
    - 🍴 Fork this repo!

- **Option 2**
    - 👯 Clone this repo to your local

### Step 2

- **HACK AWAY!** 🔨🔨🔨

### Step 3

- 🔃 Create a new pull request using <a href="https://github.com/ndPPPhz/TapeTextView/pulls" target="_blank">`https://github.com/ndPPPhz/TapeTextView/pulls`</a>.

---


## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

**[MIT license](http://opensource.org/licenses/mit-license.php)**
