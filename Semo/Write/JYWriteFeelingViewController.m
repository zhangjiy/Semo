//
//  JYWriteFeelingViewController.m
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import "JYWriteFeelingViewController.h"
#import "JYWriteFeelingView.h"
#import "JYPrefixHeader.h"

@interface JYWriteFeelingViewController ()
@property (nonatomic, strong) JYWriteFeelingView *writeFeelingView;
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
    [self.view addSubview:self.writeFeelingView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _writeFeelingView.frame = self.view.bounds;
}

- (JYWriteFeelingView *)writeFeelingView {
    if (!_writeFeelingView) {
        _writeFeelingView = [[JYWriteFeelingView alloc] initWithFrame:CGRectZero];
    }
    
    return _writeFeelingView;
        
}

@end
