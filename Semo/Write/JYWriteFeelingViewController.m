//
//  JYWriteFeelingViewController.m
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import "JYWriteFeelingViewController.h"
#import "JYGridView.h"
#import "JYWriteFeelingView.h"
#import "JYPrefixHeader.h"

@interface JYWriteFeelingViewController ()
@property (nonatomic, strong) JYGridView *gridView;
@property (nonatomic, strong) JYWriteFeelingView *writeFeelingView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@end

@implementation JYWriteFeelingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupConfig];
    [self initSubviews];
}

- (void)setupConfig {
    self.view.backgroundColor = SMHomeBackgroudColor;
}

- (void)initSubviews {
    [self.view addSubview:self.gridView];
    [self.gridView drawGridWithVerLineCount:7 horLineCount:14];
    [self.view addSubview:self.writeFeelingView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _writeFeelingView.frame = self.view.bounds;
}

- (JYGridView *)gridView {
    if (!_gridView) {
        _gridView = [[JYGridView alloc] initWithFrame:CGRectMake(-1, -1, JYWriteGridWidth, JYWriteGridHeight)];
        //_gridView.backgroundColor = SMHomeBackgroudColor;
    }
    return _gridView;
}

- (JYWriteFeelingView *)writeFeelingView {
    if (!_writeFeelingView) {
        _writeFeelingView = [[JYWriteFeelingView alloc] initWithFrame:CGRectZero];
    }
    return _writeFeelingView;
}

@end
