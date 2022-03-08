//
//  JYFeelingTableViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import "JYFeelingTableViewCell.h"
#import "JYPrefixHeader.h"

@interface JYFeelingTableViewCell ()
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UIImageView *feelingImageView;
@property (nonatomic, strong) UILabel *weakLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *outlineLabel;
@property (nonatomic, strong) UIView *dateLineView;
@end

@implementation JYFeelingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    
    return self;
}

- (void)initSubViews {
    [self.contentView addSubview:self.borderView];
    [self.contentView addSubview:self.feelingImageView];
    [self.contentView addSubview:self.weakLabel];
    [self.contentView addSubview:self.dateLineView];
    [self.contentView addSubview:self.monthLabel];
    [self.contentView addSubview:self.outlineLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _borderView.width = self.contentView.width - 15 * 2;
    _borderView.height = self.contentView.width - 15 - 30;
    _borderView.left = 15;
    _borderView.top = 15;
    
    _feelingImageView.size = CGSizeMake(60, 60);
    _feelingImageView.top = _borderView.bottom + 30;
    _feelingImageView.centerX = self.contentView.width / 2.f;
    
    [_weakLabel sizeToFit];
    _weakLabel.left = _borderView.left + 20;
    _weakLabel.top = _borderView.top + 20;
    
    _dateLineView.size = CGSizeMake(33, 1);
    _dateLineView.centerX = _weakLabel.centerX;
    _dateLineView.top = _weakLabel.bottom + 5;
    
    [_monthLabel sizeToFit];
    _monthLabel.centerX = _weakLabel.centerX;
    _monthLabel.top = _dateLineView.bottom + 5;
    
    [_outlineLabel sizeToFit];
    _outlineLabel.centerX = self.contentView.width / 2.f;;
    _outlineLabel.top = _feelingImageView.bottom + 30;
}

- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [[UIView alloc] initWithFrame:CGRectZero];
        _borderView.layer.borderColor = [[UIColor blackColor] CGColor];
        _borderView.layer.borderWidth = 2.f;
    }
    return _borderView;
}

- (UIImageView *)feelingImageView {
    if (!_feelingImageView) {
        _feelingImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    return _feelingImageView;
}

- (UILabel *)weakLabel {
    if (!_weakLabel) {
        _weakLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _weakLabel;
}

- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _monthLabel;
}

- (UILabel *)outlineLabel {
    if (!_outlineLabel) {
        _outlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _outlineLabel;
}

- (UIView *)dateLineView {
    if (!_dateLineView) {
        _dateLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _dateLineView.backgroundColor = [UIColor blackColor];
    }
    
    return _dateLineView;
}

- (void)updateViewWithModel:(JYFeelingModel *)feelingModel {
    self.feelingImageView.image = [UIImage imag]
}

@end
