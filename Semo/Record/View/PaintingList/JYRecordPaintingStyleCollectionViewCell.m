//
//  JYRecordPaintingStyleCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import "JYRecordPaintingStyleCollectionViewCell.h"
#import "JYHeartView.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYRecordPaintingStyleCollectionViewCell ()
@property (nonatomic, strong) UIView *circleView;
@end

@implementation JYRecordPaintingStyleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.circleView];
    _circleView.size = CGSizeMake(self.contentView.width * 0.45, self.contentView.width * 0.45);
    _circleView.top = (self.contentView.height - _circleView.size.height) / 2.f;
    _circleView.left = (self.contentView.width - _circleView.size.width) / 2.f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (UIView *)circleView {
    if (!_circleView) {
        _circleView = [[UIView alloc] initWithFrame:CGRectZero];
        _circleView.layer.masksToBounds = YES;
        _circleView.layer.cornerRadius = 4.f;
        _circleView.layer.borderWidth = 2.f;
        _circleView.layer.borderColor = [UIColor blackColor].CGColor;
    }
     
    return _circleView;
}

@end
