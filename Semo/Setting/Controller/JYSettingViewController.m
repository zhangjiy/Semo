//
//  JYSettingViewController.m
//  Semo
//
//  Created by jiyang on 2022/4/26.
//

#import "JYSettingViewController.h"
#import "JYSettingListView.h"

@interface JYSettingViewController ()
@property (nonatomic, strong) JYSettingListView *settingListView;
@end

@implementation JYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubviews];
}

- (void)initSubviews {
    [self.view addSubview:self.settingListView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _settingListView.frame = self.view.bounds;
    _settingListView.backgroundColor = [UIColor redColor];
}

- (JYSettingListView *)settingListView {
    if (!_settingListView) {
        _settingListView = [[JYSettingListView alloc] initWithFrame:CGRectZero];
        
    }
    
    return _settingListView;
}

@end
