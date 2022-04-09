//
//  JYRecordMoodViewController.m
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import "JYRecordMoodViewController.h"
#import "JYGridView.h"
#import "JYRecordMoodManager.h"
#import "LGDrawer.h"
#import "JYDayMood.h"
#import "JYPrefixHeader.h"

@interface JYRecordMoodViewController ()
@property (nonatomic, strong) JYGridView *gridView;
@property (nonatomic, strong) id <JYViewProtocol> recordManager;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) JYDayMood * dayMood;
@end

@implementation JYRecordMoodViewController

- (instancetype)initWithDayMood:(JYDayMood *)dayMood {
    if (self = [super init]) {
        self.dayMood = dayMood;
    }
    
    return self;
}

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
    self.gridView.size = [self.gridView drawGridWithVerLineCount:7 horLineCount:14 scale:1.f];
    [self.view addSubview:self.recordManager.containerView];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.confirmButton];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [_recordManager layoutSubviews];
    _gridView.centerX = self.view.width / 2.f;
    _cancelButton.size = CGSizeMake(30, 30);
    _cancelButton.left = 20;
    _cancelButton.top = StatusBarHeight;
    
    _confirmButton.size = CGSizeMake(30, 30);
    _confirmButton.right = self.view.width - 20;
    _confirmButton.top = StatusBarHeight;
}

- (JYGridView *)gridView {
    if (!_gridView) {
        _gridView = [[JYGridView alloc] initWithFrame:CGRectMake(0, 0, JYWriteGridWidth, JYWriteGridHeight)];
    }
    return _gridView;
}

- (id<JYViewProtocol>)recordManager {
    if (!_recordManager) {
        _recordManager = [[JYRecordMoodManager alloc] initWithFrame:self.view.bounds];
    }
    
    return _recordManager;
}


- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_cancelButton setImage:[self crossImage] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelButton;
}

- (void)cancelButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}

- (void)confirmButtonAction:(UIButton *)sender {
    NSMutableArray *moods = [[NSMutableArray alloc] init];
    if (self.dayMood.moods.count > 0) {
        [moods addObjectsFromArray:self.dayMood.moods];
    }
    
    UIImage *image = self.recordManager.resultMoodImage;
    NSData *data = UIImagePNGRepresentation(image);
    [moods addObject:data];
    self.dayMood.moods = [moods copy];
    if ([self.delegate respondsToSelector:@selector(recordMoodViewController:dayMood:)]) {
        [self.delegate recordMoodViewController:self dayMood:self.dayMood];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
