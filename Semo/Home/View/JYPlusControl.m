//
//  JYPlusControl.m
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import "JYPlusControl.h"
#import "JYPrefixHeader.h"

@interface JYPlusControl ()
@property (nonatomic, strong) CAShapeLayer *verticalLayer;
@property (nonatomic, strong) CAShapeLayer *horizeLayer;
@end

@implementation JYPlusControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = SMPluginControlBorderWidth;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self.layer addSublayer:self.horizeLayer];
    [self.layer addSublayer:self.verticalLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.horizeLayer.frame = CGRectMake(SMPluginControlInset, (self.height - SMPluginControlBorderWidth) / 2.f, self.width - SMPluginControlInset * 2, SMPluginControlBorderWidth);
    self.verticalLayer.frame = CGRectMake((self.width - SMPluginControlBorderWidth) / 2.f, SMPluginControlInset, SMPluginControlBorderWidth, self.width - SMPluginControlInset * 2);
}

- (CAShapeLayer *)horizeLayer {
    if (!_horizeLayer) {
        _horizeLayer = [[CAShapeLayer alloc] init];
        _horizeLayer.cornerRadius = 3.0;
        _horizeLayer.backgroundColor = [[UIColor blackColor] CGColor];
    }
    return _horizeLayer;
}

- (CAShapeLayer *)verticalLayer {
    if (!_verticalLayer) {
        _verticalLayer = [[CAShapeLayer alloc] init];
        _verticalLayer.cornerRadius = SMPluginControlBorderWidth / 2.f;
        _verticalLayer.backgroundColor = [[UIColor blackColor] CGColor];
    }
    return _verticalLayer;
}

@end
