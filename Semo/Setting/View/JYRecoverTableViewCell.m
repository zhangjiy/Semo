//
//  JYRecoverTableViewCell.m
//  Semo
//
//  Created by jiyang on 2022/10/11.
//

#import "JYRecoverTableViewCell.h"
#import "JYPrefixHeader.h"

@interface JYRecoverTableViewCell ()
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *newLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *selectedButton;
@end

@implementation JYRecoverTableViewCell

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
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.newLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.selectedButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_countLabel sizeToFit];
    _countLabel.left = 20;
    _countLabel.centerX = self.contentView.width / 2.f;
    
    [_timeLabel sizeToFit];
    _timeLabel.left = _countLabel.right + 20;
    _timeLabel.top = 10;
    
    [_newLabel sizeToFit];
    _newLabel.left = _timeLabel.right + 5;
    _newLabel.centerY = _timeLabel.centerY;
    
    [_nameLabel sizeToFit];
    _nameLabel.left = _countLabel.right + 20;
    _nameLabel.top = _timeLabel.bottom + 5;
    
    _selectedButton.size = CGSizeMake(50, 50);
    _selectedButton.right = self.width - 20;
    _selectedButton.centerY = self.contentView.height / 2.f;
    
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _countLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _timeLabel;
}

- (UILabel *)newLabel {
    if (!_newLabel) {
        _newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _newLabel.text = NSLocalizedString(@"最新", nil);
    }
    return _newLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _nameLabel;
}

- (UIButton *)selectedButton {
    if (!_selectedButton) {
        _selectedButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_selectedButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedButton;
}

- (void)selectedButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(recoverTableViewCell:didSelectAction:)]) {
        [self.delegate recoverTableViewCell:self didSelectAction:sender];
    }
}

@end
