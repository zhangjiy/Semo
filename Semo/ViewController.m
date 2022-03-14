//
//  ViewController.m
//  Semo
//
//  Created by jiyang on 2022/3/7.
//

#import "ViewController.h"
#import "JYPlusControl.h"
#import "JYFeelingListView.h"
#import "JYMonthCalendarView.h"
#import "JYWriteFeelingViewController.h"
#import "JYCalendar.h"
#import "JYPrefixHeader.h"

@interface ViewController ()
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
    self.view.backgroundColor = SMHomeBackgroudColor;
    //self.calendar = [[JYCalendar alloc] init];
}

- (void)initSubviews {
//    [self.view addSubview:self.plusControl];
//    [self.view addSubview:self.feelingListView];
    [self.view addSubview:self.monthCalendarView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    _monthCalendarView.size = CGSizeMake(self.view.width - 15 * 2, self.view.height);
//    _monthCalendarView.left = 15;
    
    _monthCalendarView.frame = self.view.bounds;
    
    _plusControl.width = SMPluginControlWidth;
    _plusControl.height = SMPluginControlHeight;
    _plusControl.centerX = self.view.width / 2.f;
    _plusControl.bottom = self.view.height - SafeAreaHeight;
    
    _feelingListView.width = self.view.width;
    _feelingListView.height = self.view.height - (StatusBarHeight);
    _feelingListView.top = StatusBarHeight;
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
        _feelingListView = [[JYFeelingListView alloc] initWithFrame:CGRectZero];
    }
    
    return _feelingListView;
}

- (void)plusControlAction:(UIControl *)sender {
    JYWriteFeelingViewController *controller = [[JYWriteFeelingViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
