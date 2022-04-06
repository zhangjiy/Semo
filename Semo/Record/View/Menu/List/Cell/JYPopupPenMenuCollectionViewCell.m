//
//  JYPopupPenMenuCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/4/4.
//

#import "JYPopupPenMenuCollectionViewCell.h"
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

@interface JYPopupPenMenuCollectionViewCell ()
@property (nonatomic, strong) CAShapeLayer *selectedLayer;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) JYPopupMenuLabel *titleLabel;
@end

@implementation JYPopupPenMenuCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView.layer addSublayer:self.selectedLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.size = CGSizeMake(self.contentView.width - 4, self.contentView.height - 4);
    _titleLabel.left = 2;
    _titleLabel.top = 2;

    _selectedLayer.frame = self.contentView.bounds;
}

- (JYPopupMenuLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[JYPopupMenuLabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.backgroundColor = SMGridLineColor;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.layer.cornerRadius = 4;
    }
    return _titleLabel;
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
        _selectedLayer.cornerRadius = 5.f;
        _selectedLayer.borderWidth = 2.f;
        _selectedLayer.borderColor = [UIColor blueColor].CGColor;
        _selectedLayer.hidden = YES;
    }
    
    return _selectedLayer;
}

- (void)updateViewWithModel:(JYMenu *)model {
    _titleLabel.text = model.name;
}

@end

