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
@property (nonatomic, strong) UILabel *titleLabel;
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
    //[self addSubview:self.titleLabel];
    [self addSubview:self.todayMoodView];
    [self addSubview:self.rightButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _rightButton.size = CGSizeMake(40, 40);
    _rightButton.right = self.width - 10;
    _rightButton.centerY = self.height / 2.f + 15;
    
    _todayMoodView.size = CGSizeMake((self.width - 20 * 2 - 40), 40);
    _todayMoodView.left = 20;
    _todayMoodView.centerY = self.height / 2.f + 16;
    
    [_titleLabel sizeToFit];
    _titleLabel.left = 20;
    _titleLabel.bottom = _todayMoodView.top - 5;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"每月统计";
    }
    return _titleLabel;
}

- (JYHomeTodayMoodView *)todayMoodView {
    if (!_todayMoodView) {
        _todayMoodView = [[JYHomeTodayMoodView alloc] initWithFrame:CGRectZero];
        _todayMoodView.layer.masksToBounds = YES;
        _todayMoodView.layer.cornerRadius = 5.f;
        _todayMoodView.layer.borderWidth = 0.5f;
    }
    
    return _todayMoodView;
        
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_rightButton setImage:[UIImage imageNamed:@"lbs_icon_share_black.png"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _rightButton;
}

- (void)rightButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(homeTopView:rightButtonAction:)]) {
        [self.delegate homeTopView:self rightButtonAction:sender];
    }
}

@end
