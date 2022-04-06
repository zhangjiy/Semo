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
@property (nonatomic, strong) CAShapeLayer *selectedLayer;
@property (nonatomic, strong) UIView *colorView;
@end

@implementation JYPopupMenuCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.colorView];
    [self.contentView.layer addSublayer:self.selectedLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _colorView.size = CGSizeMake(self.contentView.width - 15, self.contentView.width - 15);
    _colorView.centerX = self.contentView.width / 2.f;
    _colorView.centerY = self.contentView.height / 2.f;

    _selectedLayer.frame = CGRectMake(5, 5, ceilf(self.contentView.width - 10), ceilf(self.contentView.width - 10));
}

- (UIView *)colorView {
    if (!_colorView) {
        _colorView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _colorView.layer.masksToBounds = YES;
        _colorView.layer.cornerRadius = (self.contentView.width - 15) / 2.f;
    }
    return _colorView;
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
        _selectedLayer.cornerRadius = ceilf((self.contentView.width - 10)) / 2.f;
        _selectedLayer.borderWidth = 3.f;
        _selectedLayer.borderColor = SMGridLineColor.CGColor;
        _selectedLayer.hidden = YES;
    }
    
    return _selectedLayer;
}

- (void)updateViewWithModel:(JYMenu *)model {
    self.colorView.backgroundColor = model.color;
}

@end
