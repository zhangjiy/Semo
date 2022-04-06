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
@property (nonatomic, strong) CAShapeLayer *selectedLayer;
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
    _imageView.size = CGSizeMake(self.contentView.width, self.contentView.height);
    _imageView.centerX = self.contentView.width / 2.f;
    _imageView.centerY = self.contentView.height / 2.f;
}

- (void)setIsSelected:(BOOL)isSelected {
    if (_isSelected != isSelected) {
        _isSelected = isSelected;
        _selectedLayer.hidden = isSelected ? NO : YES;
    }
}

- (CAShapeLayer *)selectedLayer {
    if (!_selectedLayer) {
        _selectedLayer = [[CAShapeLayer alloc] init];
        _selectedLayer.hidden = YES;
    }
    
    return _selectedLayer;
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
    
    if (!model.image) {
        model.image = [self styleImageWithStyleType:model.styleType];
    }
    self.imageView.image = model.image;
}

- (UIImage *)styleImageWithStyleType:(JYMoodStyleType)styleType {
    CGSize size = CGSizeMake(self.contentView.width - JYViewInset, self.contentView.height - JYViewInset);
    return [JYStyleImageFactory styleImageFactoryFromStyleType:styleType size:size borderWidth:(self.contentView.width - JYViewInset) / 40.f];
}

@end
