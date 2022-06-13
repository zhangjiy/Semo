//
//  JYSettingViewController.m
//  Semo
//
//  Created by jiyang on 2022/4/26.
//

#import "JYSettingViewController.h"
#import "JYSettingTopView.h"
#import "JYSettingListView.h"
#import "JYPrefixHeader.h"

@interface JYSettingViewController ()
@property (nonatomic, strong) JYSettingTopView *topView;
@property (nonatomic, strong) JYSettingListView *settingListView;
@end

@implementation JYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self initSubviews];
}

- (void)initSubviews {
    [self.view addSubview:self.settingListView];
    [self.view addSubview:self.topView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _topView.size = CGSizeMake(self.view.width, NavigationBarHeight);
    _settingListView.height = self.view.height;
    _settingListView.width = self.view.width;
    _settingListView.top = NavigationBarHeight;
}

- (JYSettingTopView *)topView {
    if (!_topView) {
        _topView = [[JYSettingTopView alloc] initWithFrame:CGRectZero];
        _topView.backgroundColor = [UIColor colorWithRed:223/255.f green:225/255.f blue:215/255.f alpha:1.f];
    }
    
    return _topView;
}

- (JYSettingListView *)settingListView {
    if (!_settingListView) {
        _settingListView = [[JYSettingListView alloc] initWithFrame:CGRectZero];
        _settingListView.backgroundColor = SMHomeBackgroudColor;
        
    }
    
    return _settingListView;
}

@end
