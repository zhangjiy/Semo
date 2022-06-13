//
//  JYHelpCenterViewController.m
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import "JYHelpCenterViewController.h"
#import "JYHelpCenterListView.h"
#import "JYHelpDetailViewController.h"
#import "JYPrefixHeader.h"

@interface JYHelpCenterViewController () <JYHelpCenterListViewDelegate>
@property (nonatomic, strong) JYHelpCenterListView *helpCenterListView;
@end

@implementation JYHelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubviews];
}

- (void)initSubviews {
    [self.view addSubview:self.helpCenterListView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _helpCenterListView.size = CGSizeMake(self.view.width, self.view.height - NavigationBarHeight);
    _helpCenterListView.top = NavigationBarHeight;
}

- (JYHelpCenterListView *)helpCenterListView {
    if (!_helpCenterListView) {
        _helpCenterListView = [[JYHelpCenterListView alloc] initWithFrame:CGRectZero];
        _helpCenterListView.backgroundColor = SMHomeBackgroudColor;
        _helpCenterListView.delegate = self;
        
    }
    
    return _helpCenterListView;
}

#pragma mark -- JYHelpCenterListViewDelegate
- (void)helpCenterListView:(JYHelpCenterListView *)listView didSelectItem:(JYHelpCenterModel *)item {
    JYHelpDetailViewController *vc = [[JYHelpDetailViewController alloc] init];
    vc.helpCenterModel = item;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
