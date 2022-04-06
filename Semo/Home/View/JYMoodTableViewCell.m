//
//  JYMoodTableViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import "JYMoodTableViewCell.h"
#import "JYMoodView.h"
#import "JYMoodModel.h"
#import "JYPrefixHeader.h"

@interface JYMoodTableViewCell ()
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) JYMoodView *moodView;
@property (nonatomic, strong) UILabel *weakLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *outlineLabel;
@property (nonatomic, strong) UIView *dateLineView;
@end

@implementation JYMoodTableViewCell

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
    [self.contentView addSubview:self.moodView];
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
    
    _moodView.size = CGSizeMake(60, 60);
    _moodView.top = _borderView.top + 15;
    _moodView.centerX = self.contentView.width / 2.f;
    
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
    _outlineLabel.top = _moodView.bottom + 15;
}

- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [[UIView alloc] initWithFrame:CGRectZero];
        _borderView.layer.borderColor = [[UIColor blackColor] CGColor];
        _borderView.layer.borderWidth = 1.f;
    }
    return _borderView;
}

- (JYMoodView *)moodView {
    if (!_moodView) {
        _moodView = [[JYMoodView alloc] initWithFrame:CGRectZero];
        _moodView.font = [UIFont systemFontOfSize:30 weight:UIFontWeightBlack];
    }
    
    return _moodView;
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

- (void)updateViewWithModel:(JYMoodModel *)moodModel {
    if (moodModel.moodImageUrl) {
        
    } else {
        self.moodView.text = moodModel.moodString;
    }
    self.weakLabel.text = moodModel.weak;
    self.monthLabel.text = moodModel.month;
    self.outlineLabel.text = moodModel.outline;
}

@end
