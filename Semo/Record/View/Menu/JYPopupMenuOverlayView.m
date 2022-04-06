//
//  JYPopupMenuOverlayView.m
//  Semo
//
//  Created by jiyang on 2022/3/22.
//

#import "JYPopupMenuOverlayView.h"
#import "JYPopupMenu.h"

@implementation JYPopupMenuOverlayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    UIView *view = touch.view;
    
    if (view == self) {
        // Close popup menu
        [self.popupMenu dismissAnimated:YES];
    }
}


@end
