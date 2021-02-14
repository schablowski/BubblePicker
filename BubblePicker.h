//
//  BubblePicker.h
//
//  Created by Stefan Schablowski on 13.02.21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BubblePickerDelegate;

@interface BubblePicker : UIView {
    
    NSMutableArray *nodes;
    CGPoint gravPos;
    
}

@property NSMutableArray *selectedIndices;
@property UIDynamicAnimator *BPAnimator;
@property UICollisionBehavior *BPCollision;
@property UIFieldBehavior *BPGravity;
@property UIDynamicItemBehavior *BPDynamics;

@property(nullable,nonatomic,weak) id<BubblePickerDelegate> delegate;

- (void)reloadData;
- (id)initWithDelegate:(id)delegate;
- (void)setSelected:(NSArray*)arr;
- (NSArray*)getSelected;

@end

@protocol BubblePickerDelegate

- (NSInteger) numberOfItems:(BubblePicker*) bubblepicker;
- (id) nodeFor:(BubblePicker*) bubblepicker :(NSIndexPath*) nodeFor;
- (void) didSelectNodeAt:(BubblePicker*) bubblepicker :(NSIndexPath*) nodeFor;
- (void) didDeselectNodeAt:(BubblePicker*) bubblepicker :(NSIndexPath*) nodeFor;

@end

NS_ASSUME_NONNULL_END
