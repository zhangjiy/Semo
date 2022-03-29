//
//  JYPopupStyleMenuCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/27.
//

#import "JYPopupStyleMenuCollectionViewCell.h"
#import "UIImageView+CornerRadius.h"
#import "JYStyleImageFactory.h"
#import "JYPrefixHeader.h"
#define kCornerRadius 4.f
@interface JYPopupStyleMenuCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation JYPopupStyleMenuCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.imageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.size = CGSizeMake(self.contentView.width - 15, self.contentView.width - 15);
    _imageView.centerX = self.contentView.width / 2.f;
    _imageView.centerY = self.contentView.height / 2.f;

}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (void)updateViewWithModel:(JYMenu *)model {
    
    UIImage *image = [self styleImageWithStyleType:model.styleType];
    self.imageView.image = image;
}

- (UIImage *)styleImageWithStyleType:(JYFeelingStyleType)styleType {
    if (!self.imageView.image) {
        CGSize size = CGSizeMake(self.contentView.width - 15, self.contentView.width - 15);
        return [JYStyleImageFactory styleImageFactoryFromStyleType:styleType size:size];
    } else {
        return self.imageView.image;
    }
}

@end
