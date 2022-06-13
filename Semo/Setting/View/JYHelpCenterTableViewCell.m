//
//  JYHelpCenterTableViewCell.m
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import "JYHelpCenterTableViewCell.h"
#import "JYHelpCenterModel.h"
#import "JYPrefixHeader.h"

@interface JYHelpCenterTableViewCell ()
@property (nonatomic, strong) UILabel *lineMarkLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation JYHelpCenterTableViewCell

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
    [self.contentView addSubview:self.lineMarkLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.arrowButton];
    [self.contentView addSubview:self.lineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_lineMarkLabel sizeToFit];
    _lineMarkLabel.left = 15;
    _lineMarkLabel.centerY = self.contentView.height / 2.f;
    
    [_titleLabel sizeToFit];
    _titleLabel.left = _lineMarkLabel.right + 3;
    _titleLabel.centerY = self.contentView.height / 2.f;
    
    _arrowButton.size = CGSizeMake(27, 51);
    _arrowButton.right = self.width;
    _arrowButton.centerY = self.contentView.height / 2.f;
    
    _lineView.size = CGSizeMake(self.contentView.width - 15, 0.5f);
    _lineView.left = 15;
    _lineView.bottom = self.contentView.height;
}

- (UILabel *)lineMarkLabel {
    if (!_lineMarkLabel) {
        _lineMarkLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _lineMarkLabel;
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

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (void)updateViewWithModel:(JYHelpCenterModel *)model {
    self.lineView.hidden = !model.showBottomLine;
    self.lineMarkLabel.text = model.lineMark;
    self.titleLabel.text = model.title;
    [self.arrowButton setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    self.contentView.backgroundColor = model.backgoundColor;
}

@end

