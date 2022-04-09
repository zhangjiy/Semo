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
@property (nonatomic, strong) UIImageView * imageView;
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
    [self.contentView addSubview:self.imageView];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    return _imageView;
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

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        self.titleLabel.text = text;
    }
}

- (void)setImage:(nullable UIImage *)image {
    if (_image != image) {
        _image = image;
        self.imageView.image = image;
        self.titleLabel.hidden = image ? YES:NO;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _backgroundContentView.frame = self.bounds;
    _imageView.size = CGSizeMake(self.contentView.height, self.contentView.height);
    _imageView.centerX = self.contentView.width / 2.f;
    _imageView.centerY = self.contentView.height / 2.f;
    _titleLabel.frame = self.bounds;
}

@end
