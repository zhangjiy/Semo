//
//  JYAboutUsTableViewCell.m
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import "JYAboutUsTableViewCell.h"
#import "JYAboutUsModel.h"
#import "JYPrefixHeader.h"

@interface JYAboutUsTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation JYAboutUsTableViewCell

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
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.arrowButton];
    [self.contentView addSubview:self.lineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    _titleLabel.left = 15;
    _titleLabel.top = 10;
    
    _contentLabel.width = self.contentView.width - 15 * 2;
    _contentLabel.height = self.contentView.height - _titleLabel.bottom - 5 - 10;
    _contentLabel.left = 15;
    _contentLabel.top = _titleLabel.bottom + 5;
    
    
    _arrowButton.size = CGSizeMake(27, 51);
    _arrowButton.right = self.width;
    _arrowButton.centerY = self.contentView.height / 2.f;
    
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

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
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

- (void)updateViewWithModel:(JYAboutUsModel *)model {
    self.lineView.hidden = !model.showBottomLine;
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.contentLabel.textColor = model.contentColor;
    [self.arrowButton setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    self.contentView.backgroundColor = model.backgoundColor;
}

@end
