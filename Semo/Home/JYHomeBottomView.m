//
//  JYHomeBottomView.m
//  Semo
//
//  Created by jiyang on 2022/3/7.
//

#import "JYHomeBottomView.h"
#import "JYPrefixHeader.h"

#define FeelingsCount Feelings.count
#define VerticalLineViewCount FeelingsCount + 1
#define HorizeLineViewCount 2

@interface JYHomeBottomView ()
@property (nonatomic, strong) UIButton *feelingButton;
@end


@implementation JYHomeBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self initFeelingButtons];
    [self initLineViews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutFeelingButtons];
    [self layoutLinViews];

}

- (void)initFeelingButtons {
    for (int i = 0; i < FeelingsCount; i ++) {
        NSString *feelStr = Feelings[i];
        UIButton *button = [self createFeelingButton];
        button.tag = 1000 + i;
        [button setTitle:feelStr forState:UIControlStateNormal];
        [self addSubview:button];
    }
}

- (UIButton *)createFeelingButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}

- (void)initLineViews {
    for (int i = 0; i < HorizeLineViewCount; i ++) {
        UIView *lineView = [self createLineView];
        lineView.tag = 2000 + i;
        [self addSubview:lineView];
    }
    
    for (int i = 0; i < VerticalLineViewCount; i ++) {
        UIView *lineView = [self createLineView];
        lineView.tag = 3000 + i;
        [self addSubview:lineView];
    }
}

- (UIView *)createLineView {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = [UIColor blackColor];
    return lineView;
}

- (void)layoutFeelingButtons {
    CGFloat left = SMHomeLeft;
    CGFloat width = (self.width - SMHomeLeft * 2) / FeelingsCount;
    for (int i = 0; i < FeelingsCount; i ++) {
        NSInteger buttonTag = 1000 + i;
        UIButton *button = [self viewWithTag:buttonTag];
        button.width = width;
        button.height = self.height;
        button.centerY = self.height / 2.f;
        button.left = left;
        
        left += width;
    }
}

- (void)layoutLinViews {
    CGFloat top = SMHomeBottomLineMagin;
    for (int i = 0; i < HorizeLineViewCount; i ++) {
        NSInteger viewTag = 2000 + i;
        UIView *lineView = [self viewWithTag:viewTag];
        lineView.height = 1.f;
        lineView.width = self.width - SMHomeBottomLineMagin * 2;
        lineView.left = SMHomeBottomLineMagin;
        lineView.top = top;
        
        top = self.height - SMHomeBottomLineMagin;
    }
    
    CGFloat width = (self.width - SMHomeLeft * 2) / FeelingsCount;
    CGFloat left = SMHomeLeft;
    for (int i = 0; i < VerticalLineViewCount; i ++) {
        NSInteger viewTag = 3000 + i;
        UIView *lineView = [self viewWithTag:viewTag];
        lineView.height = self.height;
        lineView.width = 1.f;
        lineView.centerY = self.height / 2.f;
        lineView.left = left;
        
        left += width;
    }
}

@end
