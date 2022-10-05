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
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation JYHelpCenterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    //[self.contentView addSubview:self.arrowButton];
    //[self.contentView addSubview:self.lineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.width = self.contentView.width - 15 * 2;
    _titleLabel.height = [_helpCenterModel.title wbt_sizeWithFont:_titleLabel.font forWidth:_titleLabel.width].height;
    _titleLabel.top = 10;
    _titleLabel.left = 15;
    
    _contentLabel.width = self.contentView.width - 15 * 2;
    _contentLabel.height = [_helpCenterModel.content wbt_sizeWithFont:_contentLabel.font forWidth:_contentLabel.width].height;
    _contentLabel.top = _titleLabel.bottom + 5;
    _contentLabel.left = 15;
    
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
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
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

- (void)setHelpCenterModel:(JYHelpCenterModel *)helpCenterModel {
    if (_helpCenterModel != helpCenterModel) {
        _helpCenterModel = helpCenterModel;
        //self.lineView.hidden = !helpCenterModel.showBottomLine;
        self.titleLabel.text = helpCenterModel.title;
        self.contentLabel.text = helpCenterModel.content;
        [self.arrowButton setImage:[UIImage imageNamed:helpCenterModel.icon] forState:UIControlStateNormal];
        self.contentView.backgroundColor = helpCenterModel.backgoundColor;
    }
}

@end

