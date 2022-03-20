//
//  JYViewProtocol.h
//  Semo
//
//  Created by jiyang on 2022/3/20.
//

#ifndef JYViewProtocol_h
#define JYViewProtocol_h

#import <UIKit/UIKit.h>

@protocol JYViewProtocol <NSObject>
@optional
@property (nonatomic, strong, readonly) UIView * containerView;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)initConfig;
- (void)initSubviews;
- (void)layoutSubviews;
@end

#endif /* JYViewProtocol_h */
