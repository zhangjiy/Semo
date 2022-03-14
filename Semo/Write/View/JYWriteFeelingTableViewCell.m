//
//  JYWriteFeelingTableViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYWriteFeelingTableViewCell.h"
#import "JYSealFeelingPassView.h"
#import "JYPrefixHeader.h"

@interface JYWriteFeelingTableViewCell ()
@property (nonatomic, strong) UIView *sealFeelingBackgroundView;
@property (nonatomic, strong) UIView *feelingListBackgroundView;
@property (nonatomic, strong) JYSealFeelingPassView * sealFeelingPassView;
@end

@implementation JYWriteFeelingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor grayColor];
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {
    [self.contentView addSubview:self.sealFeelingBackgroundView];
    [self.contentView addSubview:self.feelingListBackgroundView];
    
    [self.sealFeelingBackgroundView addSubview:self.sealFeelingPassView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _sealFeelingBackgroundView.size = CGSizeMake(self.contentView.width - 15 * 2, 200);
    _sealFeelingBackgroundView.top = 44;
    _sealFeelingBackgroundView.left = 15;
    
    _sealFeelingPassView.size = CGSizeMake(120, 120);
    _sealFeelingPassView.top = 30;
    _sealFeelingPassView.centerX = self.contentView.width / 2.f;
    
    _feelingListBackgroundView.size = CGSizeMake(self.contentView.width - 15 * 2, 80);
    _feelingListBackgroundView.top = _sealFeelingBackgroundView.bottom + 20;
    _feelingListBackgroundView.left = 15;
}

- (UIView *)sealFeelingBackgroundView {
    if (!_sealFeelingBackgroundView) {
        _sealFeelingBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _sealFeelingBackgroundView.backgroundColor = [UIColor whiteColor];
        _sealFeelingBackgroundView.layer.masksToBounds = YES;
        _sealFeelingBackgroundView.layer.cornerRadius = 10;
    }
    
    return _sealFeelingBackgroundView;
}

- (UIView *)feelingListBackgroundView {
    if (!_feelingListBackgroundView) {
        _feelingListBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _feelingListBackgroundView.backgroundColor = [UIColor whiteColor];
        _feelingListBackgroundView.layer.masksToBounds = YES;
        _feelingListBackgroundView.layer.cornerRadius = 10;
    }
    
    return _feelingListBackgroundView;
}

- (JYSealFeelingPassView *)sealFeelingPassView {
    if (!_sealFeelingPassView) {
        _sealFeelingPassView = [[JYSealFeelingPassView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    }
    
    return _sealFeelingPassView;
}

@end
