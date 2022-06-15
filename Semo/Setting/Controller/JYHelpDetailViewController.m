//
//  JYHelpDetailViewController.m
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import "JYHelpDetailViewController.h"
#import "JYHelpCenterModel.h"
#import "JYPrefixHeader.h"

@interface JYHelpDetailViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation JYHelpDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.contentLabel];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _titleLabel.width = self.view.width - 15 * 2;
    _titleLabel.height = [_helpCenterModel.title wbt_sizeWithFont:_titleLabel.font forWidth:_titleLabel.width].height;
    _titleLabel.top = NavigationBarHeight + 60;
    _titleLabel.left = 15;
    
    _contentLabel.width = self.view.width - 15 * 2;
    _contentLabel.height = [_helpCenterModel.content wbt_sizeWithFont:_contentLabel.font forWidth:_contentLabel.width].height;
    _contentLabel.top = _titleLabel.bottom + 20;
    _contentLabel.left = 15;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
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

- (void)setHelpCenterModel:(JYHelpCenterModel *)helpCenterModel {
    if (_helpCenterModel != helpCenterModel) {
        _helpCenterModel = helpCenterModel;
    }
}

@end
