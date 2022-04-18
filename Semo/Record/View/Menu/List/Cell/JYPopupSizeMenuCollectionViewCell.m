//
//  JYPopupSizeMenuCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/4/4.
//

#import "JYPopupSizeMenuCollectionViewCell.h"
#import "UIImageView+CornerRadius.h"
#import "JYMenu.h"
#import "LGDrawer.h"
#import "JYPrefixHeader.h"

@interface JYPopupSizeMenuCollectionViewCell ()
@property (nonatomic, strong) CAShapeLayer *selectedLayer;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation JYPopupSizeMenuCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.imageView];
    [self.contentView.layer addSublayer:self.selectedLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.size = CGSizeMake(self.contentView.width, self.contentView.width);
    _imageView.centerX = self.contentView.width / 2.f;
    _imageView.centerY = self.contentView.height / 2.f;

}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = (self.contentView.width) / 2.f;
    }
    return _imageView;
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
        _selectedLayer.backgroundColor = [UIColor blueColor].CGColor;
        _selectedLayer.hidden = YES;
    }
    
    return _selectedLayer;
}

- (void)updateViewWithModel:(JYMenu *)model {
    if (!model.sizeImage) {
        model.sizeImage = [self sizeImageWithSize:CGSizeMake(model.lineWidth, model.lineWidth)];
    }
    self.imageView.image = model.sizeImage;
    
    _selectedLayer.frame = CGRectMake((self.contentView.width - model.lineWidth) / 2.f, (self.contentView.height - model.lineWidth) / 2.f, model.lineWidth, model.lineWidth);
    _selectedLayer.cornerRadius = model.lineWidth / 2.f;
}

- (UIImage *)sizeImageWithSize:(CGSize)size {
    return [LGDrawer drawEllipseWithImageSize:size
                                         size:size
                                       offset:JYOffset
                                       rotate:JYRotate
                              backgroundColor:[UIColor clearColor]
                                    fillColor:[UIColor blackColor]
                                  strokeColor:[UIColor clearColor]
                              strokeThickness:0.f
                                   strokeDash:nil
                                   strokeType:JYStrokeType
                                  shadowColor:[UIColor clearColor]
                                 shadowOffset:CGPointMake(0, 0)
                                   shadowBlur:0];
}

@end

