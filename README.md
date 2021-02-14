# BubblePicker
 BubblePicker Objective-C

# BubblePicker

[![Version](https://img.shields.io/cocoapods/v/BubblePicker-Objective-C.svg?style=flat)](http://cocoapods.org/pods/BubblePicker-Objective-C)
[![License](https://img.shields.io/cocoapods/l/BubblePicker-Objective-C.svg?style=flat)](http://cocoapods.org/pods/BubblePicker-Objective-C)
[![Platform](https://img.shields.io/cocoapods/p/BubblePicker-Objective-C.svg?style=flat)](http://cocoapods.org/pods/BubblePicker-Objective-C)

The original code in SWIFT can be found [here](https://github.com/ronneldavis/BubblePicker)

## Usage

Setup the BubblePicker view

```Objective-C 

NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:@[@"Sports",@"People"]];raphy"]

BubblePicker *bubblePicker = [[BubblePicker alloc]init];       // Or use a storyboard
bubblePicker.delegate = self;
[bubblePicker reloadData];
```

Implement the delegate methods

```Objective-C 
@interface MoodController : UIViewController <BubblePickerDelegate> {
        
}
```

Delegate callbacks for when a user selects or deselects a bubble

```Objective-C

- (void)didDeselectNodeAt:(nonnull BubblePicker *)bubblepicker :(NSIndexPath *)nodeFor {
            
    NSLog(@"didDeselectNodeAt :%ld", (long)nodeFor.row);
    
}

- (void)didSelectNodeAt:(nonnull BubblePicker *)bubblepicker :(NSIndexPath *)nodeFor {
    
    NSLog(@"didSelectNodeAt :%ld", (long)nodeFor.row);
    
}

- (id)nodeFor:(nonnull BubblePicker *)bubblepicker :(NSIndexPath *)nodeFor {
    
    BubblePickerNode *node = [[BubblePickerNode alloc] init:items[nodeFor.row] :[UIColor whiteColor] :[UIColor redColor]];
    
    node.font = [UIFont fontWithName:@"Overpass-Regular" size:20.0f];
    node.selectedFont = [UIFont fontWithName:@"Overpass-Regular" size:30.0f];
    
    return node;
    
}

- (NSInteger)numberOfItems:(nonnull BubblePicker *)bubblepicker {
    
    return [items count];
    
}
```

Set and get selected nodes 

```Swift

[bubblePicker setSelected:@[@0, @2, @3, @4]];
[bubblePicker getSelected(];

```

Bubble picker node properties

```Objective-C

@property UIFont *font;
@property UIFont *selectedFont;

```

## Installation

BubblePicker Objective-C is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "BubblePicker-Objective-C"
```

## Author

Stefan Schablowski: s.schablowski@web.de

## License

BubblePicker Objective-C is available under the MIT license. See the LICENSE file for more info.

Copyright (c) 2021 Stefan Schablowski
