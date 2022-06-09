//
//  ViewController.m
//  Semo
//
//  Created by jiyang on 2022/3/7.
//

#import "JYMoodHomeViewController.h"
#import "JYHomeTopView.h"
#import "JYRecordMoodViewController.h"
#import "JYMonthCalendarViewManager.h"
#import "JYDetailMoodViewController.h"
#import "JYMonthMood.h"
#import "JYPrefixHeader.h"

@interface JYMoodHomeViewController () <JYRecordMoodViewControllerDelegate, JYMonthCalendarViewDelegate>
@property (nonatomic, strong) JYHomeTopView *topView;
@property (nonatomic, strong) id <JYMonthCalendarViewManagerProtocol> calendarViewManager;
@end

@implementation JYMoodHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self setupConfig];
    [self initSubviews];
}

- (void)setupConfig {
    self.view.backgroundColor = SMHomeBackgroudColor;
}

- (void)initSubviews {
    [self.view addSubview:self.calendarViewManager.containerView];
    [self.view addSubview:self.topView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    //_calendarViewManager.containerView.frame = self.view.bounds;
    [_calendarViewManager layoutSubviews];
    
    _topView.size = CGSizeMake(self.view.width, JYHomeTopViewHeight);
}

- (id <JYMonthCalendarViewManagerProtocol>)calendarViewManager {
    if (!_calendarViewManager) {
        _calendarViewManager = [[JYMonthCalendarViewManager alloc] initWithFrame:CGRectMake(0, JYHomeTopViewHeight + 10, self.view.width, self.view.height - JYHomeBottomViewHeight)];
        _calendarViewManager.delegate = self;
    }
    
    return _calendarViewManager;
}

- (JYHomeTopView *)topView {
    if (!_topView) {
        _topView = [[JYHomeTopView alloc] initWithFrame:CGRectZero];
        _topView.backgroundColor = [UIColor colorWithRed:223/255.f green:225/255.f blue:215/255.f alpha:1.f];
    }
    
    return _topView;
}

- (void)plusControlAction:(UIControl *)sender {
    [self presentRecordMoodViewController:self.calendarViewManager.todayName];
}

#pragma -- mark -- JYRecordMoodViewControllerDelegate

- (void)recordMoodViewController:(JYRecordMoodViewController *)controller dayMood:(JYDayMood *)dayMood {
    JYMoodMonthDate *monthDate = self.calendarViewManager.currentMonth;
    [monthDate.monthMood saveDayMood:dayMood forKey:dayMood.name];
    
    [self.calendarViewManager reloadDate];
}

#pragma -- mark -- JYMonthCalendarViewManagerDelegate

- (void)monthCalendarViewManager:(id <JYMonthCalendarViewManagerProtocol>)manager didSelectItemAtIndexPath:(NSString *)dayName jumpType:(JYMonthCalendarJumpType)jumpType {
    if (jumpType == JYMonthCalendarJumpTypeRecord) {
        [self presentRecordMoodViewController:dayName];
    } else if (jumpType == JYMonthCalendarJumpTypeDetail) {
        JYDetailMoodViewController *controller = [[JYDetailMoodViewController alloc] init];
        controller.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)presentRecordMoodViewController:(NSString *)dayName {
    JYMoodMonthDate *monthDate = (JYMoodMonthDate *)self.calendarViewManager.currentMonth;
    JYDayMood * dayMood = [monthDate.monthMood.dayMoodDict valueForKey:dayName];
    if (!dayMood) {
        dayMood = [[JYDayMood alloc] initWithName:dayName];
    }
    
    JYRecordMoodViewController *controller = [[JYRecordMoodViewController alloc] initWithDayMood:dayMood];
    controller.delegate = self;
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
