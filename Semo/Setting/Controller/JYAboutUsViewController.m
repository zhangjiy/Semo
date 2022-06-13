//
//  JYAboutUsViewController.m
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import "JYAboutUsViewController.h"
#import "JYAboutUsListView.h"
#import "JYPrefixHeader.h"

@interface JYAboutUsViewController ()
@property (nonatomic, strong) JYAboutUsListView *aboutUsListView;
@end

@implementation JYAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self initSubviews];
}

- (void)initSubviews {
    [self.view addSubview:self.aboutUsListView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _aboutUsListView.size = CGSizeMake(self.view.width, self.view.height - NavigationBarHeight);
    _aboutUsListView.top = NavigationBarHeight;
}

- (JYAboutUsListView *)aboutUsListView {
    if (!_aboutUsListView) {
        _aboutUsListView = [[JYAboutUsListView alloc] initWithFrame:CGRectZero];
        _aboutUsListView.backgroundColor = SMHomeBackgroudColor;
        
    }
    
    return _aboutUsListView;
}

@end
