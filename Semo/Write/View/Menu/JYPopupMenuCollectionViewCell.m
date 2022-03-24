//
//  JYPopupMenuCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/22.
//

#import "JYPopupMenuCollectionViewCell.h"
#import "UIImageView+CornerRadius.h"
#import "JYMenu.h"
#import "LGDrawer.h"
#import "JYPrefixHeader.h"

@interface JYPopupMenuCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation JYPopupMenuCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.size = CGSizeMake(self.contentView.width - 15, self.contentView.width - 15);
    _imageView.centerX = self.contentView.width / 2.f;
    _imageView.centerY = self.contentView.height / 2.f;
    
    _titleLabel.frame = _imageView.bounds;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = (self.contentView.width - 15) / 2.f;
        _imageView.hidden = YES;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor blackColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.layer.cornerRadius = (self.contentView.width - 15) / 2.f;
    }
    return _titleLabel;
}

- (void)updateViewWithModel:(JYMenu *)model {
    _titleLabel.text = model.name;
    if (model.type == JYPaintingTypeColor) {
        self.imageView.backgroundColor = model.color;
        self.imageView.hidden = NO;
    } else if (model.type == JYPaintingTypeSize) {
        self.imageView.image = [self ellipseImageWithSize:CGSizeMake(model.lineWidth, model.lineWidth)];
        self.imageView.hidden = NO;
    } else if (model.type == JYPaintingTypeStyle){
        self.imageView.hidden = YES;
    }
}

- (UIImage *)ellipseImageWithSize:(CGSize)size {
    if (!self.imageView.image) {
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
    } else {
        return self.imageView.image;
    }
}

@end
