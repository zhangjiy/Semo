//
//  JYDetailMoodViewController.m
//  Semo
//
//  Created by jiyang on 2022/4/25.
//

#import "JYDetailMoodViewController.h"
#import "JYDetailMoodListView.h"
#import "JYPrefixHeader.h"

@interface JYDetailMoodViewController () <JYDetailMoodListViewDelegate>
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) JYDetailMoodListView *detailMoodListView;
@property (nonatomic, strong) JYDayMood *dayMood;
@end

@implementation JYDetailMoodViewController

- (instancetype)initWithDayMood:(JYDayMood *)dayMood {
    if (self = [super init]) {
        self.dayMood = dayMood;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = SMHomeBackgroudColor;
    [self initSubviews];
}

- (void)initSubviews {
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.detailMoodListView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _backButton.size = CGSizeMake(30, 30);
    _backButton.left = 15;
    _backButton.top = StatusBarHeight;
    
    _detailMoodListView.top = NavigationBarHeight;
    _detailMoodListView.width = self.view.width;
    _detailMoodListView.height = self.view.height - NavigationBarHeight;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_backButton setImage:[UIImage imageNamed:@"wbp_navigationbar_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backButton;
}

- (void)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setDayMood:(JYDayMood *)dayMood {
    if (_dayMood != dayMood) {
        _dayMood = dayMood;
        self.detailMoodListView.dayMood = dayMood;
    }
}

- (JYDetailMoodListView *)detailMoodListView {
    if (!_detailMoodListView) {
        _detailMoodListView = [[JYDetailMoodListView alloc] initWithFrame:CGRectZero];
        _detailMoodListView.delegate = self;
    }
    
    return _detailMoodListView;
}

#pragma mark - JYDetailMoodListViewDelegate

- (void)detailMoodListView:(JYDetailMoodListView *)view didSelectItem:(JYMood *)item {
    if ([self.delegate respondsToSelector:@selector(detailMoodViewController:didSelectItem:)]) {
        [self.delegate detailMoodViewController:self didSelectItem:item];
    }
}

@end
