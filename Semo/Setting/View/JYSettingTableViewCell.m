//
//  JYSettingTableViewCell.m
//  Semo
//
//  Created by jiyang on 2022/6/10.
//

#import "JYSettingTableViewCell.h"
#import "JYSettingModel.h"
#import "JYPrefixHeader.h"

@interface JYSettingTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, strong) UISwitch *switchButton;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation JYSettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.arrowButton];
    [self.contentView addSubview:self.switchButton];
    [self.contentView addSubview:self.lineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    _titleLabel.left = 15;
    _titleLabel.centerY = self.contentView.height / 2.f;
    
    _arrowButton.size = CGSizeMake(27, 51);
    _arrowButton.right = self.width;
    _arrowButton.centerY = self.contentView.height / 2.f;
    
    _switchButton.size = CGSizeMake(20, 20);
    _switchButton.right = self.width;
    _switchButton.centerY = self.contentView.height / 2.f;
    
    _lineView.size = CGSizeMake(self.contentView.width - 15, 0.5f);
    _lineView.left = 15;
    _lineView.bottom = self.contentView.height;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _titleLabel;
}

- (UIButton *)arrowButton {
    if (!_arrowButton) {
        _arrowButton = [[UIButton alloc] initWithFrame:CGRectZero];
    }
    return _arrowButton;
}

- (UISwitch *)switchButton {
    if (!_switchButton) {
        _switchButton = [[UISwitch alloc] initWithFrame:CGRectZero];
    }
    return _switchButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (void)updateViewWithModel:(JYSettingModel *)model {
    self.switchButton.hidden = model.type == JYSettingItemTypeSwitch ? NO:YES;
    self.lineView.hidden = !model.showBottomLine;
    self.titleLabel.text = model.title;
    [self.arrowButton setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    self.contentView.backgroundColor = model.backgoundColor;
}

@end
