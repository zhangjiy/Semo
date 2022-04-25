//
//  JYDetailMoodViewController.m
//  Semo
//
//  Created by jiyang on 2022/4/25.
//

#import "JYDetailMoodViewController.h"
#import "JYDetailMoodListView.h"

@interface JYDetailMoodViewController ()
@property (nonatomic, strong) JYDetailMoodListView *detailMoodListView;
@end

@implementation JYDetailMoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubviews];
}

- (void)initSubviews {
    [self.view addSubview:self.detailMoodListView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _detailMoodListView.frame = self.view.bounds;
    _detailMoodListView.backgroundColor = [UIColor redColor];
}

- (JYDetailMoodListView *)detailMoodListView {
    if (!_detailMoodListView) {
        _detailMoodListView = [[JYDetailMoodListView alloc] initWithFrame:CGRectZero];
        
    }
    
    return _detailMoodListView;
}

@end
