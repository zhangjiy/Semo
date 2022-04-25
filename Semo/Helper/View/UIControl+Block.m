//
//  UIControl+Block.m
//  Semo
//
//  Created by jiyang on 2022/3/23.
//

#import "UIControl+Block.h"
#import <objc/runtime.h>

@implementation UIControl (Block)

static char blockKey;

- (void)addBlock:(buttonBlock)block event:(UIControlEvents)event {
    objc_setAssociatedObject(self, &blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callControlActionBlock:) forControlEvents:event];
}

- (void)callControlActionBlock:(id)sender {
    buttonBlock block = (buttonBlock)objc_getAssociatedObject(self, &blockKey);
    if (block) {
        block(sender);
    }
}

@end
