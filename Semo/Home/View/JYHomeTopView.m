//
//  JYHomeTopView.m
//  Semo
//
//  Created by jiyang on 2022/4/27.
//

#import "JYHomeTopView.h"
#import "JYHomeTodayMoodView.h"
#import "JYPrefixHeader.h"

@interface JYHomeTopView ()
@property (nonatomic, strong) JYHomeTodayMoodView *todayMoodView;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation JYHomeTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self addSubview:self.todayMoodView];
    [self addSubview:self.rightButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _rightButton.size = CGSizeMake(40, 40);
    _rightButton.right = self.width - 20;
    _rightButton.centerY = self.height / 2.f + 15;
    
    _todayMoodView.size = CGSizeMake((self.width - 20 * 3 - 40), 40);
    _todayMoodView.left = 20;
    _todayMoodView.centerY = self.height / 2.f + 15;
}

- (JYHomeTodayMoodView *)todayMoodView {
    if (!_todayMoodView) {
        _todayMoodView = [[JYHomeTodayMoodView alloc] initWithFrame:CGRectZero];
        _todayMoodView.backgroundColor = SMHomeBackgroudColor;
        _todayMoodView.layer.masksToBounds = YES;
        _todayMoodView.layer.cornerRadius = 5.f;
    }
    
    return _todayMoodView;
        
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_rightButton setImage:[UIImage imageNamed:@"lbs_icon_share_black.png"] forState:UIControlStateNormal];
    }
    
    return _rightButton;
}

@end
