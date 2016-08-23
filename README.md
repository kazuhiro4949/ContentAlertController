# ContentAlertController

ContentAlertController is a kind of UIAlertViewController like UI. You can add any custom view to the object.

## What's this?

There are some templates to make rich alert.

### Headline Template

![uploaded](https://cloud.githubusercontent.com/assets/18320004/17892613/39394740-697d-11e6-85ee-728d69cc1ca3.gif)

### Flyer Template

![viewport](https://cloud.githubusercontent.com/assets/18320004/17893266/0ddbb684-6980-11e6-96b6-3444ec31939c.gif)


## Feature
- [x] Enable to put any custom views on AlertView and ActionSheet as you like it
- [x] add custom style to AlertView and ActionSheet 
- [x] copy the style and API of UIAlertViewController

## Requirements
- iOS 9.0+
- Swift 2.2

## Installation
### Carthage

+ Install Carthage from Homebrew
```
> ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
> brew update
> brew install carthage
```
+ Move your project dir and create Cartfile
```
> touch Cartfile
```
+ add the following line to Cartfile
```
github "kazuhiro49/ContentAlertController"
```
+ Create framework
```
> carthage update --platform iOS
```

+ In Xcode, move to "Genera > Build Phase > Linked Frameworks and Library"
+ Add the framework to your project
+ Add a new run script and put the following code
```
/usr/local/bin/carthage copy-frameworks
```
+ Click "+" at Input file and Add the framework path
```
$(SRCROOT)/Carthage/Build/iOS/ContentAlertController.framework
```
+ Write Import statement on your source file
```
Import ContentAlertController
```

### CocoaPods
+ Install CocoaPods
```
> gem install cocoapods
> pod setup
```
+ Create Podfile
```
> pod init
```
+ Edit Podfile
```ruby
# Uncomment this line to define a global platform for your project
use_framework!  # add

target 'MyAppName' do
  pod 'ContentAlertController' # add
end

target 'MyAppTests' do

end

target 'MyAppUITests'
```

+ Install

```
> pod install
```
open .xcworkspace

## Example

## Usage

## License

Copyright (c) 2016 Kazuhiro Hayashi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
