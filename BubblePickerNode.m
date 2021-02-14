//
//  BubblePickerNode.m
//
//  Created by Stefan Schablowski on 13.02.21.
//

#import <UIKit/UIKit.h>
#import "BubblePickerNode.h"

@implementation BubblePickerNode
@synthesize bubblepicker;
@synthesize index;

-(id) init:(NSString*)title :(UIColor*) labelColor :(UIColor*) color :(UIImage*) image {
    
    if(!self) {
        self = [super init];
    }
    
    isExpanded = NO;
    titleString = title;
    backColor = color;
    textColor = labelColor;
    
    int isLeft = arc4random_uniform(2);
    CGFloat marginLeft = 300;
    
    if ( isLeft == 0) {
        marginLeft = -300.0f;
    }
    
    CGRect screenSize = UIScreen.mainScreen.bounds;
    int screenWidth = screenSize.size.width;
    int screenHeight = screenSize.size.height;
    
    CGFloat x = screenWidth/2 + marginLeft - 100 + arc4random_uniform(100);
    CGFloat y = screenHeight/2 - 100 + arc4random_uniform(100);
           
    self = [super initWithFrame:CGRectMake( x, y, 100, 100 )];
    
    [self drawBubble:title :color :image];
    
    return self;
    
}

-(id) init:(NSString*)title :(UIColor*) labelColor :(UIColor*) color {
    
    if(!self) {
        self = [super init];
    }
    
    isExpanded = NO;
    titleString = title;
    backColor = color;
    textColor = labelColor;
    
    int isLeft = arc4random_uniform(2);
    CGFloat marginLeft = 300;
    
    if ( isLeft == 0) {
        marginLeft = -300.0f;
    }
    
    CGRect screenSize = UIScreen.mainScreen.bounds;
    int screenWidth = screenSize.size.width;
    int screenHeight = screenSize.size.height;
    
    CGFloat x = screenWidth/2 + marginLeft - 100 + arc4random_uniform(100);
    CGFloat y = screenHeight/2 - 100 + arc4random_uniform(100);
           
    self = [super initWithFrame:CGRectMake( x, y, 100, 100 )];
    
    [self drawBubble:title :color :NULL];
    
    return self;
    
}

- (void)drawBubble:(NSString*)title :(UIColor*) color :(UIImage*) image {

    if ( image ) {
    
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, 100, 100);
        imageView.alpha = 0;

        [self addSubview:imageView];
        
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(3, 3, self.frame.size.width -6, self.frame.size.height -6) cornerRadius:47];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;

    label = [[UILabel alloc] initWithFrame:self.bounds];
    label.text = titleString;
    label.textColor = textColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = self.font;
    
    [self addSubview:label];

    self.backgroundColor = backColor;
    self.clipsToBounds = YES;

    UITapGestureRecognizer *singleFingerTap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handleSingleTap:)];
    
    [self addGestureRecognizer:singleFingerTap];
    
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    if(isExpanded){
        
        if ( bubblepicker.delegate ) {
        
            [bubblepicker.delegate didDeselectNodeAt:bubblepicker :[NSIndexPath indexPathForRow:index inSection:0]];
            
        }
        
        [bubblepicker.selectedIndices removeObject:self];
                
    } else {
        
        if ( bubblepicker.delegate ) {
        
            [bubblepicker.delegate didSelectNodeAt:bubblepicker :[NSIndexPath indexPathForRow:index inSection:0]];
            
        }
        
        [bubblepicker.selectedIndices addObject:self];
        
    }
    
    [self setSelected:!isExpanded];
    
}

- (void)setSelected:(BOOL)flag {
    
    isExpanded = flag;
    
    [bubblepicker.BPAnimator removeBehavior:bubblepicker.BPDynamics];
    [bubblepicker.BPAnimator removeBehavior:bubblepicker.BPGravity];
    [bubblepicker.BPAnimator removeBehavior:bubblepicker.BPCollision];
    
    UIBezierPath *maskPath;
    
    if(!isExpanded){
        
        self.bounds = CGRectMake(0, 0, 100, 100);
        
        maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(3, 3, self.bounds.size.width - 6, self.bounds.size.height - 6) cornerRadius:47];
        
        imageView.frame = CGRectMake(0, 0, 160, 160);
        imageView.alpha = 0;

        label.frame = self.bounds;
        label.font = self.font;
    
    } else {
        
        self.bounds = CGRectMake(0, 0, 160, 160);

        imageView.frame = CGRectMake(0, 0, 160, 160);
        imageView.alpha = 0.5;

        maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(3, 3, self.bounds.size.width - 6, self.bounds.size.height - 6) cornerRadius:77];
        
        label.frame = self.bounds;
        label.font = self.selectedFont;
        
    }
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

    [bubblepicker.BPAnimator addBehavior:bubblepicker.BPDynamics];
    [bubblepicker.BPAnimator addBehavior:bubblepicker.BPGravity];
    [bubblepicker.BPAnimator addBehavior:bubblepicker.BPCollision];
        
}

-(UIDynamicItemCollisionBoundsType) collisionBoundsType {
    
    return UIDynamicItemCollisionBoundsTypeEllipse;
    
}

- (UIBezierPath*)collisionBoundingPath {
    
    return [UIBezierPath bezierPathWithRect:self.bounds];
    
}

@end
