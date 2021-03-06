//
//  JYGradientCircleView.m
//  Semo
//
//  Created by jiyang on 2022/4/13.
//

#import "JYGradientCircleView.h"

@interface JYGradientCircleView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, assign) CGFloat startAngle;  //开始弧度
@property (nonatomic, assign) CGFloat endAngle;    //结束弧度

@end

@implementation JYGradientCircleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    //初始化话参数
    self.startDegree = 0;
    self.endDegree = 360;
    self.isClockwise = YES;
    self.margin = 3;
    
    //创建calayer
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.frame = self.bounds;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.shapeLayer.lineWidth = 10.f;
    
    //创建渐变层
    self.gradientLayer = [[CAGradientLayer alloc] init];
    self.gradientLayer.frame = self.bounds;
    
    self.gradientLayer.locations = @[@0, @0.5, @1];
    self.gradientLayer.mask = self.shapeLayer;
    [self.layer addSublayer:self.gradientLayer];
}

#pragma mark - Setter
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = progress;
}

//开始角度
-(void)setStartDegree:(CGFloat)startDegree{
    _startDegree = startDegree;
    self.startAngle = startDegree * M_PI/180;
}

//结束角度
-(void)setEndDegree:(CGFloat)endDegree{
    _endDegree = endDegree;
    self.endAngle = endDegree * M_PI/180;
}

-(void)setColors:(NSArray <UIColor *> *)colors{
    _colors = colors;
    NSMutableArray *colorsRef = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorsRef addObject:(__bridge id)color.CGColor];
    }
    self.gradientLayer.colors = colorsRef;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    if (_lineWidth != lineWidth) {
        _lineWidth = lineWidth;
        self.shapeLayer.lineWidth = lineWidth;
    }
}

#pragma mark -
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //重新设置位置
    self.shapeLayer.frame = self.bounds;
    self.gradientLayer.frame = self.bounds;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5) radius:self.bounds.size.width/2 - self.margin*2 startAngle:self.startAngle endAngle:self.endAngle clockwise:self.isClockwise];
    self.shapeLayer.path = bezierPath.CGPath;

}

@end
