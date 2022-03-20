//
//  ViewController.m
//  Semo
//
//  Created by jiyang on 2022/3/7.
//

#import "ViewController.h"
#import "JYGridView.h"
#import "JYPlusControl.h"
#import "JYFeelingListView.h"
#import "JYMonthCalendarView.h"
#import "JYWriteFeelingViewController.h"
#import "JYCalendar.h"
#import "JYPrefixHeader.h"

@interface ViewController ()
@property (nonatomic, strong) JYGridView *gridView;
@property (nonatomic, strong) JYPlusControl * plusControl;
@property (nonatomic, strong) JYFeelingListView * feelingListView;
@property (nonatomic, strong) JYMonthCalendarView *monthCalendarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupConfig];
    [self initSubviews];
}

- (void)setupConfig {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initSubviews {
    [self.view addSubview:self.gridView];
    [self.view addSubview:self.monthCalendarView];
    [self.view addSubview:self.plusControl];
    [self.gridView drawGridWithVerLineCount:4 horLineCount:8];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _monthCalendarView.width = self.gridView.width;
    _monthCalendarView.height = self.gridView.height + 25;
    _monthCalendarView.top = StatusBarHeight;
    _monthCalendarView.left = JYViewInset;
    _plusControl.width = SMPluginControlWidth;
    _plusControl.height = SMPluginControlHeight;
    _plusControl.centerX = self.view.width / 2.f;
    _plusControl.top = _monthCalendarView.bottom + 10;
}

- (JYGridView *)gridView {
    if (!_gridView) {
        _gridView = [[JYGridView alloc] initWithFrame:CGRectMake(JYViewInset, NavigationBarHeight, JYHomeGridWidth, JYHomeGridHeight)];
        _gridView.backgroundColor = SMHomeBackgroudColor;
    }
    
    return _gridView;
}

- (JYMonthCalendarView *)monthCalendarView {
    if (!_monthCalendarView) {
        JYCalendar *calendar = [[JYCalendar alloc] init];
        _monthCalendarView = [[JYMonthCalendarView alloc] initWithFrame:CGRectZero calendar:calendar];
    }
    
    return _monthCalendarView;
}

- (JYPlusControl *)plusControl {
    if (!_plusControl) {
        _plusControl = [[JYPlusControl alloc] initWithFrame:CGRectZero];
        _plusControl.layer.masksToBounds = YES;
        _plusControl.layer.cornerRadius = SMPluginControlWidth / 2.f;
        [_plusControl addTarget:self action:@selector(plusControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _plusControl;
}

- (JYFeelingListView *)feelingListView {
    if (!_feelingListView) {
        _feelingListView = [[JYFeelingListView alloc] initWithFrame:CGRectMake(JYViewInset, NavigationBarHeight, JYHomeGridWidth, JYHomeGridHeight)];
    }
    
    return _feelingListView;
}

- (void)plusControlAction:(UIControl *)sender {
    JYWriteFeelingViewController *controller = [[JYWriteFeelingViewController alloc] init];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
