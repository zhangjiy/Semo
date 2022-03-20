//
//  JYWriteFeelingViewController.m
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import "JYWriteFeelingViewController.h"
#import "JYGridView.h"
#import "JYWriteFeelingView.h"
#import "LGDrawer.h"
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
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.confirmButton];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _writeFeelingView.frame = self.view.bounds;
    
    _cancelButton.size = CGSizeMake(30, 30);
    _cancelButton.left = 20;
    _cancelButton.top = 20;
    
    _confirmButton.size = CGSizeMake(30, 30);
    _confirmButton.right = self.view.width - 20;
    _confirmButton.top = 20;
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

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_cancelButton setImage:[self crossImage] forState:UIControlStateNormal];
    }
    
    return _cancelButton;
}

- (UIImage *)crossImage {
    return [LGDrawer drawCrossWithImageSize:CGSizeMake(30.f, 30.f)
                                       size:CGSizeMake(20.f, 20.f)
                                     offset:JYOffset
                                     rotate:JYRotate
                                  thickness:3.f
                             roundedCorners:UIRectCornerBottomLeft|UIRectCornerTopRight
                               cornerRadius:JYCornerRadius
                            backgroundColor:[UIColor clearColor]
                                  fillColor:[UIColor blackColor]
                                strokeColor:[UIColor clearColor]
                            strokeThickness:0.f
                                 strokeDash:nil
                                 strokeType:JYStrokeType
                                shadowColor:JYShadowColor
                               shadowOffset:JYShadowOffset
                                 shadowBlur:JYShadowBlur];
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_confirmButton setImage:[self tickImage] forState:UIControlStateNormal];
    }
    
    return _confirmButton;
}

- (UIImage *)tickImage {
    return [LGDrawer drawTickWithImageSize:CGSizeMake(30.f, 30.f)
                                      size:CGSizeMake(20.f, 20.f)
                                    offset:JYOffset
                                    rotate:JYRotate
                                 thickness:3.f
                           backgroundColor:[UIColor clearColor]
                                     color:[UIColor blackColor]
                                      dash:nil
                               shadowColor:JYShadowColor
                              shadowOffset:JYShadowOffset
                                shadowBlur:JYShadowBlur];
}

@end
