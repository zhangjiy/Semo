//
//  JYPopupStyleMenuCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/27.
//

#import "JYPopupStyleMenuCollectionViewCell.h"
#import "UIImageView+CornerRadius.h"
#import "JYMenu.h"
#import "LGDrawer.h"
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
        CGSize imageSize = CGSizeMake(60, 60);
        CGSize size = CGSizeMake(58, 58);
        if (styleType == JYFeelingStyleTypeEllipse) {
            return [LGDrawer drawEllipseWithImageSize:imageSize
                                                 size:size
                                               offset:JYOffset
                                               rotate:JYRotate
                                      backgroundColor:[UIColor clearColor]
                                            fillColor:[UIColor clearColor]
                                          strokeColor:SMSealRedColor
                                      strokeThickness:2.f
                                           strokeDash:nil
                                           strokeType:JYStrokeType
                                          shadowColor:[UIColor clearColor]
                                         shadowOffset:CGPointMake(0, 0)
                                           shadowBlur:0];
        } else if (styleType == JYFeelingStyleTypeRectangle) {
            return [LGDrawer drawRectangleWithImageSize:imageSize
                                                   size:size
                                                 offset:JYOffset
                                                 rotate:JYRotate
                                         roundedCorners:UIRectCornerAllCorners
                                           cornerRadius:0.f
                                        backgroundColor:[UIColor clearColor]
                                              fillColor:[UIColor clearColor]
                                            strokeColor:SMSealRedColor
                                        strokeThickness:2.f
                                             strokeDash:nil
                                             strokeType:JYStrokeType
                                            shadowColor:[UIColor clearColor]
                                           shadowOffset:CGPointMake(0, 0)
                                             shadowBlur:0];
        } else if (styleType == JYFeelingStyleTypeTriangle) {
            return [LGDrawer drawTriangleWithImageSize:imageSize
                                                  size:size
                                                offset:JYOffset
                                                rotate:JYRotate
                                          cornerRadius:0
                                             direction:LGDrawerDirectionTop
                                       backgroundColor:[UIColor clearColor]
                                             fillColor:[UIColor clearColor]
                                           strokeColor:SMSealRedColor
                                       strokeThickness:2.f
                                            strokeDash:nil
                                           shadowColor:[UIColor clearColor]
                                          shadowOffset:CGPointMake(0, 0)
                                            shadowBlur:0];
        } else {
            return [LGDrawer drawHeartWithImageSize:imageSize
                                               size:size
                                             offset:JYOffset
                                             rotate:JYRotate
                                    backgroundColor:[UIColor clearColor]
                                          fillColor:[UIColor clearColor]
                                        strokeColor:SMSealRedColor
                                    strokeThickness:2.f
                                         strokeDash:nil
                                        shadowColor:[UIColor clearColor]
                                       shadowOffset:CGPointMake(0, 0)
                                         shadowBlur:0];
        }
    } else {
        return self.imageView.image;
    }
}

@end
