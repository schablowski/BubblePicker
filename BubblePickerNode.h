//
//  BubblePickerNode.h
//
//  Created by Stefan Schablowski on 13.02.21.
//

#import <UIKit/UIKit.h>
#import "BubblePicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface BubblePickerNode : UIView {
    
    UILabel *label;
    UIImageView *imageView;

    BOOL isExpanded;
    
    NSString *titleString;
    UIColor *backColor;
    UIColor *textColor;
    
}

@property BubblePicker *bubblepicker;
@property int index;
@property UIFont *font;
@property UIFont *selectedFont;

- (void)setSelected:(BOOL)flag;
- (id) init:(NSString*)title :(UIColor*) labelColor :(UIColor*) color :(UIImage*) image;
- (id) init:(NSString*)title :(UIColor*) labelColor :(UIColor*) color;

@end

NS_ASSUME_NONNULL_END
