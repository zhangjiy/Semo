//
//  JYRecordPaintingCustomCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/6/8.
//

#import "JYRecordPaintingCustomCollectionViewCell.h"
#import "JYPrefixHeader.h"

#define Scale [UIScreen mainScreen].scale

@interface JYRecordPaintingCustomCollectionViewCell ()
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) UIImageView *selectedImageView;
@end

@implementation JYRecordPaintingCustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.circleView];
    [self.contentView addSubview:self.selectedImageView];
}

- (UIView *)circleView {
    if (!_circleView) {
        _circleView = [[UIView alloc] initWithFrame:CGRectZero];
        _circleView.layer.masksToBounds = YES;
        _circleView.layer.cornerRadius = self.contentView.width * 0.5 * 0.5;
        _circleView.layer.borderWidth = 1.f;
        _circleView.layer.borderColor = [UIColor blackColor].CGColor;
    }
     
    return _circleView;
}

- (UIImageView *)selectedImageView {
    if (!_selectedImageView) {
        _selectedImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _selectedImageView.layer.masksToBounds = YES;
        _selectedImageView.layer.cornerRadius = self.contentView.width * 0.4 * 0.5;
    }
    
    return _selectedImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _circleView.size = CGSizeMake(self.contentView.width * 0.5, self.contentView.width * 0.5);
    _circleView.top = (self.contentView.height - _circleView.size.height) / 2.f;
    _circleView.left = (self.contentView.width - _circleView.size.width) / 2.f;
    _selectedImageView.size = CGSizeMake(self.contentView.width * 0.4, self.contentView.width * 0.4);
    _selectedImageView.top = (self.contentView.height - _selectedImageView.size.height) / 2.f;
    _selectedImageView.left = (self.contentView.width - _selectedImageView.size.width) / 2.f;
}

- (void)setIsSelected:(BOOL)isSelected {
    if (_isSelected != isSelected) {
        _isSelected = isSelected;
        _selectedImageView.image = isSelected ? [UIImage wbt_imageWithColor:SMSealRedColor] : nil;
    }
}

- (void)selectedButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
