//
//  JYDayCalendarCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/13.
//

#import "JYDayCalendarCollectionViewCell.h"
#import "JYPrefixHeader.h"

@interface JYDayCalendarCollectionViewCell ()
@property (nonatomic, strong) UILabel * titleLabel;
@end

@implementation JYDayCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithSubViews];
    }
    return self;
}

- (void)initWithSubViews {
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

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        self.titleLabel.text = text;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = self.bounds;
}

@end
