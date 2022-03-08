//
//  ViewController.m
//  Semo
//
//  Created by jiyang on 2022/3/7.
//

#import "ViewController.h"
#import "JYPlusControl.h"
#import "JYWriteFeelingViewController.h"
#import "JYPrefixHeader.h"

@interface ViewController ()
@property (nonatomic, strong) JYPlusControl * plusControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SMHomeBackgroudColor;
    [self initSubviews];
}

- (void)initSubviews {
    [self.view addSubview:self.plusControl];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _plusControl.width = SMPluginControlWidth;
    _plusControl.height = SMPluginControlHeight;
    _plusControl.centerX = self.view.width / 2.f;
    _plusControl.bottom = self.view.height - SafeAreaHeight;
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
    JYWriteFeelingViewController *controller = [[JYWriteFeelingViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
