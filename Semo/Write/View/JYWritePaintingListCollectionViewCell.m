//
//  JYWritePaintingListCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import "JYWritePaintingListCollectionViewCell.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYWritePaintingListCollectionViewCell ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation JYWritePaintingListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.textLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _textLabel.size = CGSizeMake(self.contentView.width - 10, self.contentView.width - 10);
    _textLabel.centerX = self.contentView.width / 2.f;
    _textLabel.centerY = self.contentView.height / 2.f;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.font = [UIFont fontWithName:@"BodoniOrnamentsITCTT" size:20];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.layer.masksToBounds = YES;
        _textLabel.layer.cornerRadius = (self.contentView.width - 10) / 2.f;
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

- (void)updateViewWithModel:(JYPaintingItem *)model {
    self.textLabel.text = model.title;
}

@end
