//
//  BubblePicker.m
//
//  Created by Stefan Schablowski on 13.02.21.
//

#import "BubblePicker.h"
#import <UIKit/UIKit.h>
#import "BubblePickerNode.h"

@implementation BubblePicker

@synthesize selectedIndices;
@synthesize delegate;
@synthesize BPAnimator;
@synthesize BPGravity;
@synthesize BPDynamics;
@synthesize BPCollision;

- (id) init {
    
    if(!self) {
        self = [super init];
    }
        
    selectedIndices = [[NSMutableArray alloc] init];
    
    return self;
    
}

-(id) initWithDelegate:(id)delegate {
    
    if(!self) {
        self = [super init];
    }
        
    selectedIndices = [[NSMutableArray alloc] init];
    
    return self;
    
}

- (id)initWithCoder:(NSCoder *)aCoder {
    
    self = [super initWithCoder:aCoder];

    if(self) {

        selectedIndices = [[NSMutableArray alloc] init];
        
    }
    
    return self;
    
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        selectedIndices = [[NSMutableArray alloc] init];
        
    }
    
    return self;
}

- (NSArray*) getSelected {
    
    return selectedIndices;
    
}

- (void)setSelected:(NSArray*)arr {
    
    selectedIndices = [[NSMutableArray alloc]initWithArray: arr];

    for(BubblePickerNode *node in nodes) {
        
        if ([selectedIndices containsObject:[NSNumber numberWithInt:node.index]]) {
            
            [node setSelected:YES];
            
        } else {
            
            [node setSelected:NO];
            
        }
        
    }
    
}

- (void)reloadData {
        
    if ( delegate == nil ) {
    
        return;
        
    }

    nodes = [[NSMutableArray alloc] init];

    NSInteger items = [delegate numberOfItems:self];
    
    BPAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self];

    [self setUserInteractionEnabled:YES];

    BPGravity = [UIFieldBehavior radialGravityFieldWithPosition: self.center];
    BPGravity.falloff = 0.3f;
    BPGravity.strength = 3;
    BPGravity.animationSpeed = 7;
    
    gravPos = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));

    for (int i=0; i < items; i++) {
        
        BubblePickerNode *node = [delegate nodeFor:self :[NSIndexPath indexPathForRow:i inSection:0]];
        
        node.index = i;
        node.bubblepicker = self;
        
        [nodes addObject:node];
        
        [self addSubview:node];
        
        [BPGravity addItem:node];
        
    }
    

    BPDynamics = [[UIDynamicItemBehavior alloc]initWithItems:nodes];
    BPDynamics.allowsRotation = false;
    BPDynamics.resistance = 0.8f;

    BPCollision = [[UICollisionBehavior alloc]initWithItems:nodes];
    [BPCollision setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(0, -500, 0, -500)];
    
    [BPAnimator addBehavior:BPDynamics];
    [BPAnimator addBehavior:BPGravity];
    [BPAnimator addBehavior:BPCollision];

    UIPanGestureRecognizer *singleFingerTap =
      [[UIPanGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handleSingleTap:)];
    
    [self addGestureRecognizer:singleFingerTap];
    
}

- (void)handleSingleTap:(UIPanGestureRecognizer *)recognizer {
    
    int newX = gravPos.x + [recognizer translationInView:recognizer.view].x;
    newX = MAX(0, newX);
    newX = MIN(self.frame.size.width, newX);

    int newY = gravPos.y + [recognizer translationInView:recognizer.view].y;
    newY = MAX(self.frame.size.height*0.25, newY);
    newY = MIN(self.frame.size.height*0.75, newY);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateEnded:
            gravPos = CGPointMake(newX, newY);
            break;
            
        case UIGestureRecognizerStateChanged:
            BPGravity.position = CGPointMake(newX, newY);
            break;
            
        default:
            break;
    }
    
}

@end
