//
//  ViewController.m
//  Semo
//
//  Created by jiyang on 2022/3/7.
//

#import "ViewController.h"
#import "JYHomeBottomView.h"
#import "JYPrefixHeader.h"

@interface ViewController ()
@property (nonatomic, strong) JYHomeBottomView * bottomView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubviews];
}

- (void)initSubviews {
    [self initLineViews];
    [self.view addSubview:self.bottomView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _bottomView.width = self.view.width;
    _bottomView.height = SMHomeBottomViewHeight;
    _bottomView.bottom = self.view.height - SafeAreaHeight;
    
    [self layoutLinViews];
}

- (void)initLineViews {
    for (int i = 0; i < 2; i ++) {
        UIView *lineView = [self createLineView];
        lineView.tag = 1000 + i;
        [self.view addSubview:lineView];
    }
    
    for (int i = 0; i < 2; i ++) {
        UIView *lineView = [self createLineView];
        lineView.tag = 2000 + i;
        [self.view addSubview:lineView];
    }
}

- (UIView *)createLineView {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = [UIColor lightGrayColor];
    return lineView;
}

- (void)layoutLinViews {
    CGFloat top = StatusBarHeight + SMHomeHeaderViewHeight;
    for (int i = 0; i < 2; i ++) {
        NSInteger viewTag = 1000 + i;
        UIView *lineView = [self.view viewWithTag:viewTag];
        lineView.height = 1.f;
        lineView.width = self.view.width - SMHomeLeft * 2;
        lineView.top = top;
        lineView.left = SMHomeLeft;
        
        top = self.view.height - (SMHomeBottomViewHeight + SafeAreaHeight + 20);
    }
    
    CGFloat left = SMHomeLeft;
    for (int i = 0; i < 2; i ++) {
        NSInteger viewTag = 2000 + i;
        UIView *lineView = [self.view viewWithTag:viewTag];
        lineView.height = self.view.height - (SMHomeHeaderViewHeight + SMHomeBottomViewHeight + StatusBarHeight + SafeAreaHeight + 20);
        lineView.width = 1.f;
        lineView.top = (StatusBarHeight + SMHomeHeaderViewHeight);
        lineView.left = left;
        
        left = self.view.width - SMHomeLeft;
    }
}

- (JYHomeBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[JYHomeBottomView alloc] initWithFrame:CGRectZero];
    }
    
    return _bottomView;
}

@end
