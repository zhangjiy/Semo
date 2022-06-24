//
//  JYMoodSelectViewController.m
//  Semo
//
//  Created by jiyang on 2022/6/22.
//

#import "JYMoodSelectViewController.h"
#import "Semo-Swift.h"

@interface JYMoodSelectViewController () <JYCircleMenuViewDelegate>
@property (nonatomic, strong) JYCircleMenuView *selectMoodMenuView;
@end

@implementation JYMoodSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubviews];
    self.view.backgroundColor = [UIColor greenColor];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.selectMoodMenuView onTap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)initSubviews {
    //[self.view addSubview:self.selectMoodMenuView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _selectMoodMenuView.frame = self.view.bounds;
}

- (JYCircleMenuView *)selectMoodMenuView {
    if (!_selectMoodMenuView) {
        _selectMoodMenuView = [[JYCircleMenuView alloc] initWithFrame:self.view.bounds];
        _selectMoodMenuView.delegate = self;
    }
    
    return _selectMoodMenuView;
}

#pragma mark -- JYCircleMenuViewDelegate

- (void)circleMenuView:(JYCircleMenuView *)circleMenu willDisplay:(UIButton *)button atIndex:(NSInteger)atIndex {
    
}

- (void)circleMenuView:(JYCircleMenuView *)circleMenu buttonWillSelected:(UIButton *)button atIndex:(NSInteger)atIndex {
    
}

- (void)circleMenuView:(JYCircleMenuView *)circleMenu buttonDidSelected:(UIButton *)button atIndex:(NSInteger)atIndex {
    
}

- (void)circleMenuViewCollapsed:(JYCircleMenuView *)circleMenu {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)circleMenuViewOpened:(JYCircleMenuView *)circleMenu {
    
}

@end
