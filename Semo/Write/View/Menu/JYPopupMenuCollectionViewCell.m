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

@interface JYPopupMenuLabel : UILabel

@end

@implementation JYPopupMenuLabel

- (void)setText:(NSString *)text {
    [super setText:text];
    self.hidden = text.length > 0 ? NO:YES;
}

@end

@interface JYPopupMenuCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) JYPopupMenuLabel *titleLabel;
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
    
    _titleLabel.size = CGSizeMake(self.contentView.width, self.contentView.height * 0.65);
    _titleLabel.centerX = self.contentView.width / 2.f;

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

- (JYPopupMenuLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[JYPopupMenuLabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.backgroundColor = SMGridLineColor;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.layer.cornerRadius = 5;
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
    } else if (model.type == JYPaintingTypePen){
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
