//
//  ViewController.m
//  Semo
//
//  Created by jiyang on 2022/3/7.
//

#import "ViewController.h"
#import "JYPlusControl.h"
#import "JYRecordMoodViewController.h"
#import "JYMonthCalendarViewManager.h"
#import "JYDetailMoodViewController.h"
#import "JYMonthMood.h"
#import "JYPrefixHeader.h"

@interface ViewController () <JYRecordMoodViewControllerDelegate, JYMonthCalendarViewDelegate>
@property (nonatomic, strong) JYPlusControl * plusControl;
@property (nonatomic, strong) id <JYMonthCalendarViewManagerProtocol> calendarViewManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupConfig];
    [self initSubviews];
}

- (void)setupConfig {
    self.view.backgroundColor = SMHomeBackgroudColor;
}

- (void)initSubviews {
    [self.view addSubview:self.calendarViewManager.containerView];
    [self.view addSubview:self.plusControl];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _calendarViewManager.containerView.frame = self.view.bounds;
    [_calendarViewManager layoutSubviews];
    
    _plusControl.width = SMPluginControlWidth;
    _plusControl.height = SMPluginControlHeight;
    _plusControl.centerX = self.view.width / 2.f;
    _plusControl.bottom = self.view.height - SafeAreaHeight;
}

- (id <JYMonthCalendarViewManagerProtocol>)calendarViewManager {
    if (!_calendarViewManager) {
        _calendarViewManager = [[JYMonthCalendarViewManager alloc] initWithFrame:self.view.bounds];
        _calendarViewManager.delegate = self;
    }
    
    return _calendarViewManager;
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
        [self pushViewController:controller animated:YES];
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
