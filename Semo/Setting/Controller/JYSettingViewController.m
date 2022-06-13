//
//  JYSettingViewController.m
//  Semo
//
//  Created by jiyang on 2022/4/26.
//

#import "JYSettingViewController.h"
#import <StoreKit/StoreKit.h>
#import "JYSettingListView.h"
#import "JYSettingModel.h"
#import "JYHelpCenterViewController.h"
#import "JYUserFeedBackViewController.h"
#import "JYAboutUsViewController.h"
#import "JYPrefixHeader.h"

@interface JYSettingViewController () <JYSettingListViewDelegate>
@property (nonatomic, strong) JYSettingListView *settingListView;
@end

@implementation JYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self initSubviews];
}

- (void)initSubviews {
    [self.view addSubview:self.settingListView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _settingListView.size = CGSizeMake(self.view.width, self.view.height - NavigationBarHeight);
    _settingListView.top = NavigationBarHeight;
}

- (JYSettingListView *)settingListView {
    if (!_settingListView) {
        _settingListView = [[JYSettingListView alloc] initWithFrame:CGRectZero];
        _settingListView.backgroundColor = SMHomeBackgroudColor;
        _settingListView.delegate = self;
    }
    
    return _settingListView;
}

#pragma mark -- JYSettingListViewDelegate

- (void)settingListView:(JYSettingListView *)listView didSelectItem:(JYSettingModel *)item {
    if (item.type == JYSettingItemTypeComment) {
        [self gotoStoreComment];
    } else if (item.type == JYSettingItemTypeHelp) {
        [self gotoHelpCenter];
    } else if (item.type == JYSettingItemTypeFeedback) {
        [self gotoUserFeedBack];
    } else if (item.type == JYSettingItemTypeAbout) {
        [self gotoAboutUs];
    }
}

- (void)gotoStoreComment {
    NSString * nsStringToOpen = [NSString stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review", @"1573880428"];//替换为对应的APPID
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen] options:@{} completionHandler:^(BOOL success) {
        
    }];
}

- (void)gotoHelpCenter {
    JYHelpCenterViewController *vc = [[JYHelpCenterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoUserFeedBack {
    JYUserFeedBackViewController *vc = [[JYUserFeedBackViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoAboutUs {
    JYAboutUsViewController *vc = [[JYAboutUsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
