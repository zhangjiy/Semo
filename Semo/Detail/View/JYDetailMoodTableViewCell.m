//
//  JYMoodTableViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import "JYDetailMoodTableViewCell.h"
#import "JYMoodView.h"
#import "JYPrefixHeader.h"

@interface JYDetailMoodTableViewCell ()
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UIImageView *moodImageView;
@property (nonatomic, strong) UILabel *weakLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *outlineLabel;
@property (nonatomic, strong) UIView *dateLineView;
@end

@implementation JYDetailMoodTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

- (void)initSubViews {
    [self.contentView addSubview:self.borderView];
    [self.contentView addSubview:self.moodImageView];
//    [self.contentView addSubview:self.weakLabel];
//    [self.contentView addSubview:self.dateLineView];
//    [self.contentView addSubview:self.monthLabel];
//    [self.contentView addSubview:self.outlineLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _borderView.width = self.contentView.width - 15 * 2;
    _borderView.height = self.contentView.height - 15 * 2;
    _borderView.left = 15;
    _borderView.top = 15;
    
    _moodImageView.size = CGSizeMake(self.contentView.height - 40, self.contentView.height - 40);
    _moodImageView.centerY = self.contentView.height / 2.f;
    _moodImageView.centerX = self.contentView.width / 2.f;
    
}

- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [[UIView alloc] initWithFrame:CGRectZero];
        _borderView.layer.borderColor = [[UIColor blackColor] CGColor];
        _borderView.layer.borderWidth = 1.f;
    }
    return _borderView;
}

- (UIImageView *)moodImageView {
    if (!_moodImageView) {
        _moodImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    return _moodImageView;
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

- (void)setMood:(JYMood *)mood {
    if (_mood != mood) {
        _mood = mood;
        _moodImageView.image = [UIImage imageWithData:mood.data];
    }
}

@end
