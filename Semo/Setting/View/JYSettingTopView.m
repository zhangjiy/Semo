//
//  JYSettingTopView.m
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import "JYSettingTopView.h"
#import "JYPrefixHeader.h"

@interface JYSettingTopView()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation JYSettingTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    _titleLabel.centerX = self.width / 2.f;;
    _titleLabel.centerY = self.height / 2.f + 15;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
