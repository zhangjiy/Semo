//
//  JYFeelingTableViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import "JYFeelingTableViewCell.h"
#import "JYFeelingView.h"
#import "JYFeelingModel.h"
#import "JYPrefixHeader.h"

@interface JYFeelingTableViewCell ()
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) JYFeelingView *feelingView;
@property (nonatomic, strong) UILabel *weakLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *outlineLabel;
@property (nonatomic, strong) UIView *dateLineView;
@end

@implementation JYFeelingTableViewCell

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
    [self.contentView addSubview:self.borderView];
    [self.contentView addSubview:self.feelingView];
    [self.contentView addSubview:self.weakLabel];
    [self.contentView addSubview:self.dateLineView];
    [self.contentView addSubview:self.monthLabel];
    [self.contentView addSubview:self.outlineLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _borderView.width = self.contentView.width - 15 * 2;
    _borderView.height = self.contentView.height - 15 - 20;
    _borderView.left = 15;
    _borderView.top = 15;
    
    _feelingView.size = CGSizeMake(60, 60);
    _feelingView.top = _borderView.top + 15;
    _feelingView.centerX = self.contentView.width / 2.f;
    
    [_weakLabel sizeToFit];
    _weakLabel.left = _borderView.left + 15;
    _weakLabel.top = _borderView.top + 15;
    
    _dateLineView.size = CGSizeMake(33, 1);
    _dateLineView.centerX = _weakLabel.centerX;
    _dateLineView.top = _weakLabel.bottom + 5;
    
    [_monthLabel sizeToFit];
    _monthLabel.centerX = _weakLabel.centerX;
    _monthLabel.top = _dateLineView.bottom + 5;
    
    [_outlineLabel sizeToFit];
    _outlineLabel.centerX = self.contentView.width / 2.f;;
    _outlineLabel.top = _feelingView.bottom + 15;
}

- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [[UIView alloc] initWithFrame:CGRectZero];
        _borderView.layer.borderColor = [[UIColor blackColor] CGColor];
        _borderView.layer.borderWidth = 1.f;
    }
    return _borderView;
}

- (JYFeelingView *)feelingView {
    if (!_feelingView) {
        _feelingView = [[JYFeelingView alloc] initWithFrame:CGRectZero];
        _feelingView.font = [UIFont systemFontOfSize:30 weight:UIFontWeightBlack];
    }
    
    return _feelingView;
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
    if (feelingModel.feelingImageUrl) {
        
    } else {
        self.feelingView.text = feelingModel.feelingString;
    }
    self.weakLabel.text = feelingModel.weak;
    self.monthLabel.text = feelingModel.month;
    self.outlineLabel.text = feelingModel.outline;
}

@end
