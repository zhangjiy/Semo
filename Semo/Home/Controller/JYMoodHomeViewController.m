//
//  ViewController.m
//  Semo
//
//  Created by jiyang on 2022/3/7.
//

#import "JYMoodHomeViewController.h"
#import "Semo-Swift.h"
#import "AppDelegate.h"
#import "CEBaseInteractionController.h"
#import "JYMoodSelectViewController.h"
#import "JYHomeTopView.h"
#import "JYRecordMoodViewController.h"
#import "JYMonthCalendarViewManager.h"
#import "JYDetailMoodViewController.h"
#import "JYMonthMood.h"
#import "JYPrefixHeader.h"

@interface JYMoodHomeViewController () <JYHomeTopViewDelegate, JYRecordMoodViewControllerDelegate, JYMonthCalendarViewDelegate, UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) JYHomeTopView *topView;
@property (nonatomic, strong) id <JYMonthCalendarViewManagerProtocol> calendarViewManager;
@end

@implementation JYMoodHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self setupConfig];
    [self initSubviews];
    self.topView.monthDate = self.calendarViewManager.currentMonth;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *view = [window viewWithTag:1000];
    [view removeFromSuperview];
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
        _calendarViewManager = [[JYMonthCalendarViewManager alloc] initWithFrame:CGRectMake(0, JYHomeTopViewHeight, self.view.width, self.view.height - JYHomeBottomViewHeight)];
        _calendarViewManager.delegate = self;
    }
    
    return _calendarViewManager;
}

- (JYHomeTopView *)topView {
    if (!_topView) {
        _topView = [[JYHomeTopView alloc] initWithFrame:CGRectZero];
        _topView.backgroundColor = [UIColor colorWithRed:223/255.f green:225/255.f blue:215/255.f alpha:1.f];
        _topView.delegate = self;
    }
    
    return _topView;
}


- (void)showSelectMoodMenuView {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *view = [window viewWithTag:1000];
    if (view) {
       [view removeFromSuperview];
    }
    JYCircleMenuView *selectMoodMenuView = [[JYCircleMenuView alloc] initWithFrame:window.bounds];
    selectMoodMenuView.tag = 1000;
    selectMoodMenuView.delegate = self;
    [window addSubview:selectMoodMenuView];
    [selectMoodMenuView onTap];
}

- (void)plusControlAction:(UIControl *)sender {
    [self presentRecordMoodViewController:self.calendarViewManager.todayName];
}

- (void)plusButtonAction:(UIButton *)sender {
    [self showSelectMoodMenuView];
//    NSString *className = [NSString stringWithFormat:@"CE%@AnimationController", @"Crossfade"];
//    id transitionInstance = [[NSClassFromString(className) alloc] init];
//
//    AppDelegateAccessor.settingsAnimationController = transitionInstance;
//    JYMoodSelectViewController *vc = [[JYMoodSelectViewController alloc] init];
//    vc.modalPresentationStyle = UIModalPresentationFullScreen;
//    vc.transitioningDelegate = self;
//    [self presentViewController:vc animated:YES completion:nil];
//    [self presentRecordMoodViewController:self.calendarViewManager.todayName];
}

#pragma -- mark -- JYHomeTopViewDelegate

- (void)homeTopView:(JYHomeTopView *)view rightButtonAction:(UIButton *)sender {
    //???????????????
     NSString *textToShare = @"??????????????????";
    //???????????????
     UIImage *imageToShare = [UIImage imageNamed:@"chartlet-2.png"];
     //?????????url
     NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
     //???????????? ????????????????????? ????????????????????????  ?????????????????????
     NSArray *activityItems = @[textToShare,imageToShare, urlToShare];
     UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
      //????????????????????????
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
     // ?????????????????????
        activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
            if (completed) {
                NSLog(@"completed");
                //?????? ??????
            } else  {
                NSLog(@"cancled");
                //?????? ??????
            }
        };
}

- (void)circleMenuView:(JYCircleMenuView *)circleMenu willDisplay:(UIButton *)button atIndex:(NSInteger)atIndex {
    
}

- (void)circleMenuView:(JYCircleMenuView *)circleMenu buttonWillSelected:(UIButton *)button atIndex:(NSInteger)atIndex {
    
}

- (void)circleMenuView:(JYCircleMenuView *)circleMenu buttonDidSelected:(UIButton *)button atIndex:(NSInteger)atIndex {
    
    [self presentRecordMoodViewController:self.calendarViewManager.todayName];
}

- (void)circleMenuViewCollapsed:(JYCircleMenuView *)circleMenu {
}

- (void)circleMenuViewOpened:(JYCircleMenuView *)circleMenu {
    
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
    JYMoodMonthDate *monthDate = self.calendarViewManager.currentMonth;
    JYDayMood * dayMood = [monthDate.monthMood.dayMoodDict valueForKey:dayName];
    if (!dayMood) {
        dayMood = [[JYDayMood alloc] initWithName:dayName];
    }
    //Fold
    //Cube
    //Portal
    //Crossfade
    //Explode
    //NatGeo
    //Reversible
    //Cards
    //Flip
    //Pan
    NSString *className = [NSString stringWithFormat:@"CE%@AnimationController", @"Portal"];
    id transitionInstance = [[NSClassFromString(className) alloc] init];
    AppDelegateAccessor.settingsAnimationController = transitionInstance;
    JYRecordMoodViewController *controller = [[JYRecordMoodViewController alloc] initWithDayMood:dayMood];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    controller.transitioningDelegate = self;
    controller.delegate = self;
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)monthCalendarViewManager:(id <JYMonthCalendarViewManagerProtocol>)manager didScrollItem:(JYMoodMonthDate *)moodMonthDate {
    self.topView.monthDate = moodMonthDate;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    if (AppDelegateAccessor.settingsInteractionController) {
        [AppDelegateAccessor.settingsInteractionController wireToViewController:presented forOperation:CEInteractionOperationDismiss];
    }
    
    AppDelegateAccessor.settingsAnimationController.reverse = NO;
    return AppDelegateAccessor.settingsAnimationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    AppDelegateAccessor.settingsAnimationController.reverse = YES;
    return AppDelegateAccessor.settingsAnimationController;
 }

 - (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
     return AppDelegateAccessor.settingsInteractionController && AppDelegateAccessor.settingsInteractionController.interactionInProgress ? AppDelegateAccessor.settingsInteractionController : nil;
 }

@end
