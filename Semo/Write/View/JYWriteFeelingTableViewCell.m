//
//  JYWriteFeelingTableViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYWriteFeelingTableViewCell.h"
#import "JYSealFeelingPassView.h"
#import "JYWriteFeelingListView.h"
#import "JYPrefixHeader.h"

@interface JYWriteFeelingTableViewCell ()
@property (nonatomic, strong) UIView *sealFeelingBackgroundView;
@property (nonatomic, strong) UIView *feelingListBackgroundView;
@property (nonatomic, strong) JYSealFeelingPassView * sealFeelingPassView;
@property (nonatomic, strong) JYWriteFeelingListView *feelingListView;
@end

@implementation JYWriteFeelingTableViewCell

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
    [self.contentView addSubview:self.sealFeelingBackgroundView];
    [self.contentView addSubview:self.feelingListBackgroundView];
    
    [self.sealFeelingBackgroundView addSubview:self.sealFeelingPassView];
    [self.feelingListBackgroundView addSubview:self.feelingListView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _sealFeelingBackgroundView.size = CGSizeMake(self.contentView.width - 15 * 2, 200);
    _sealFeelingBackgroundView.top = 44;
    _sealFeelingBackgroundView.left = 15;
    
    _sealFeelingPassView.size = CGSizeMake(120, 120);
    _sealFeelingPassView.top = 30;
    _sealFeelingPassView.centerX = _sealFeelingBackgroundView.width / 2.f;
    
    _feelingListBackgroundView.size = CGSizeMake(self.contentView.width - 15 * 2, 64);
    _feelingListBackgroundView.top = _sealFeelingBackgroundView.bottom + 20;
    _feelingListBackgroundView.left = 15;
    
    _feelingListView.frame = _feelingListBackgroundView.bounds;
}

- (UIView *)sealFeelingBackgroundView {
    if (!_sealFeelingBackgroundView) {
        _sealFeelingBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _sealFeelingBackgroundView.backgroundColor = SMHomeBackgroudColor;
        _sealFeelingBackgroundView.layer.cornerRadius = 5.f;
        _sealFeelingBackgroundView.layer.shadowColor = [UIColor grayColor].CGColor;
        _sealFeelingBackgroundView.layer.shadowOpacity = 0.8f;
        _sealFeelingBackgroundView.layer.shadowRadius = 5.f;
        _sealFeelingBackgroundView.layer.shadowOffset = CGSizeMake(0,0);
    }
    
    return _sealFeelingBackgroundView;
}

- (UIView *)feelingListBackgroundView {
    if (!_feelingListBackgroundView) {
        _feelingListBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _feelingListBackgroundView.backgroundColor = SMHomeBackgroudColor;
        _feelingListBackgroundView.layer.cornerRadius = 5.f;
        _feelingListBackgroundView.layer.shadowColor = [UIColor grayColor].CGColor;
        _feelingListBackgroundView.layer.shadowOpacity = 0.8f;
        _feelingListBackgroundView.layer.shadowRadius = 5.f;
        _feelingListBackgroundView.layer.shadowOffset = CGSizeMake(0,0);
    }
    
    return _feelingListBackgroundView;
}

- (JYSealFeelingPassView *)sealFeelingPassView {
    if (!_sealFeelingPassView) {
        _sealFeelingPassView = [[JYSealFeelingPassView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    }
    
    return _sealFeelingPassView;
}

- (JYWriteFeelingListView *)feelingListView {
    if (!_feelingListView) {
        _feelingListView = [[JYWriteFeelingListView alloc] initWithFrame:CGRectZero];
    }
    
    return _feelingListView;
}

@end
