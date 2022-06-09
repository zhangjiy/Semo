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
@property (nonatomic, strong) UIButton *selectedButton;
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
    [self.contentView addSubview:self.selectedButton];
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

- (UIButton *)selectedButton {
    if (!_selectedButton) {
        _selectedButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _selectedButton.layer.masksToBounds = YES;
        _selectedButton.layer.cornerRadius = self.contentView.width * 0.4 * 0.5;
        [_selectedButton setBackgroundImage:[UIImage wbt_imageWithColor:SMSealRedColor] forState:UIControlStateSelected];
        [_selectedButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _selectedButton;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _circleView.size = CGSizeMake(self.contentView.width * 0.5, self.contentView.width * 0.5);
    _circleView.top = (self.contentView.height - _circleView.size.height) / 2.f;
    _circleView.left = (self.contentView.width - _circleView.size.width) / 2.f;
    _selectedButton.size = CGSizeMake(self.contentView.width * 0.4, self.contentView.width * 0.4);
    _selectedButton.top = (self.contentView.height - _selectedButton.size.height) / 2.f;
    _selectedButton.left = (self.contentView.width - _selectedButton.size.width) / 2.f;
}

- (void)selectedButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
