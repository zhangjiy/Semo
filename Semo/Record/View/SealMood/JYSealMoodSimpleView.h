//
//  JYSealMoodSimpleView.h
//  Semo
//
//  Created by jiyang on 2022/3/29.
//

#import <UIKit/UIKit.h>
#import "ZHFigureDrawingLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYSealMoodSimpleView : UIView
@property (nonatomic, strong) NSString * text;
- (instancetype)initWithFrame:(CGRect)frame type:(ZHFigureDrawingType)type;
@end

NS_ASSUME_NONNULL_END
