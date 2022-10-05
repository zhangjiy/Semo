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
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, strong) UISwitch *switchButton;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation JYSettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.containerView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.arrowButton];
    [self.containerView addSubview:self.switchButton];
    //[self.containerView addSubview:self.lineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _containerView.frame = self.containerView.bounds;
    
    [_titleLabel sizeToFit];
    _titleLabel.left = 15;
    _titleLabel.centerY = self.containerView.height / 2.f;
    
    _arrowButton.size = CGSizeMake(27, 51);
    _arrowButton.right = self.width;
    _arrowButton.centerY = self.containerView.height / 2.f;
    
    _switchButton.size = CGSizeMake(20, 20);
    _switchButton.right = self.width;
    _switchButton.centerY = self.containerView.height / 2.f;
    
    _lineView.size = CGSizeMake(self.containerView.width - 15, 0.5);
    _lineView.left = 15;
    _lineView.bottom = self.containerView.height;
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

- (void)setSettingModel:(JYSettingModel *)settingModel {
    if (_settingModel != settingModel) {
        _settingModel = settingModel;
        self.containerView.hidden = settingModel.type == JYSettingItemTypeSection ? YES:NO;
        self.switchButton.hidden = settingModel.rightViewType == JYSettingRightViewTypeSwitch ? NO:YES;
        //self.lineView.hidden = !settingModel.showBottomLine;
        self.titleLabel.text = settingModel.title;
        [self.arrowButton setImage:[UIImage imageNamed:settingModel.icon] forState:UIControlStateNormal];
        self.contentView.backgroundColor = settingModel.backgoundColor;
    }
}

@end
