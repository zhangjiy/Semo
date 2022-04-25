//
//  UIControl+Block.h
//  Semo
//
//  Created by jiyang on 2022/3/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^buttonBlock)(id sender);

@interface UIControl (Block)
- (void)addBlock:(buttonBlock)block event:(UIControlEvents)event;
@end

NS_ASSUME_NONNULL_END
