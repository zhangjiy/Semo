//
//  JYDayCalendarCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/13.
//

#import "JYDayCalendarCollectionViewCell.h"
#import "JYPrefixHeader.h"

@interface JYDayCalendarCollectionViewCell ()
@property (nonatomic, strong) UIView * backgroundContentView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) JYCalendarCalculator * calculator;
@end

@implementation JYDayCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithSubViews];
    }
    return self;
}

- (void)initWithSubViews {
    [self.contentView addSubview:self.backgroundContentView];
    [self.contentView addSubview:self.titleLabel];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        //Zapfino
        //BodoniOrnamentsITCTT
        //PartyLetPlain
        //MarkerFelt-Wide
        //SnellRoundhand
        _titleLabel.font = [UIFont systemFontOfSize:30];
    }
    
    return _titleLabel;
}

- (UIView *)backgroundContentView {
    if (!_backgroundContentView) {
        _backgroundContentView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _backgroundContentView;
}

- (void)updateViewWithText:(NSString *)text {
    self.titleLabel.text = text;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _backgroundContentView.frame = self.bounds;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.centerY = self.contentView.height / 2.f;
    self.titleLabel.centerX = self.contentView.width / 2.f;
}

@end
