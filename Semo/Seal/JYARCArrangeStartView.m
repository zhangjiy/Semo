//
//  JYARCArrangeStartView.m
//  Deme
//
//  Created by jiyang on 2022/3/12.
//

#import "JYARCArrangeStartView.h"

@interface JYARCArrangeStartView()

@end

@implementation JYARCArrangeStartView {
    NSArray *views;
    NSInteger textLength;
    CGFloat viewWidth;
    CGFloat viewHeight;
    CGFloat arcRadius;
    CGFloat textHeight;
    CGFloat totalRadian;
    CGFloat eachRadian;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self setupConfig];
        [self setupView];
    }
        
    return self;
}

- (void)setupConfig {
    views = @[@1, @1, @1, @1, @1];
    textHeight = 20;
    viewWidth = self.frame.size.width - textHeight * 2;
    viewHeight = self.frame.size.height - textHeight;
    arcRadius = viewHeight / 2.f + viewWidth * viewWidth / 8.f / viewHeight; // 根据垂径定理得到
    textLength = views.count == 0 ? 1 : views.count;

    totalRadian =  asin(viewWidth / 2.f / arcRadius) * 2 * 4 / 5.f;
    eachRadian = totalRadian / (textLength - 1);
}

- (void)setupView {
    // 先移除之前创建的
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }

    CGFloat startAngle = -M_PI / 2.f - totalRadian / 2.f; // 起始角度，从左到右，取第一个字符的位置为起始角度

    for (int i = 0; i < textLength; i ++) {
        CGFloat angle = startAngle + eachRadian * i;
        CGFloat x = arcRadius * cos(angle);
        CGFloat y = arcRadius * sin(angle);
        CGPoint center = CGPointMake((self.frame.size.width / 2.f + x), (arcRadius + textHeight + y)); // 各个label中点坐标
        
        if (views.count == 0) {
            return;
        }
        
        
        CAShapeLayer *startLayer = [[CAShapeLayer alloc] init];
        startLayer.bounds = CGRectMake(0, 0, 20, 20);
        
        CGPoint arcCenter = CGPointMake(startLayer.position.x + startLayer.frame.size.width / 2.f, startLayer.position.y + startLayer.frame.size.height / 2.f);
        CGFloat radius = 10;
        CGFloat rate = 0.3;
        startLayer.strokeColor = [UIColor clearColor].CGColor;
        startLayer.fillColor = [UIColor redColor].CGColor;
        startLayer.path = ({
            UIBezierPath *path = [UIBezierPath bezierPath];
            
            //五角星最上面的点
            CGPoint first  = CGPointMake(arcCenter.x, arcCenter.y - radius);
            [path moveToPoint:first];
            
            //点与点之间点夹角为2*M_PI/5.0,要隔一个点才连线
            CGFloat angle = 4 * M_PI / 5.f;
            if (rate > 1.5) {
                rate = 1.5;
            }
            for (int i= 1; i <= 5; i++) {
                CGFloat x = arcCenter.x - sinf(i * angle) * radius;
                CGFloat y = arcCenter.y - cosf(i * angle) * radius;
                
                CGFloat midx = arcCenter.x - sinf(i * angle - 2 * M_PI / 5.f) * radius * rate;
                CGFloat midy = arcCenter.y - cosf(i * angle -2 * M_PI / 5.f) * radius*rate;
                [path addQuadCurveToPoint:CGPointMake(x, y) controlPoint:CGPointMake(midx, midy)];
            }
            
            path.CGPath;
        });
        startLayer.lineWidth = 1.f;
        startLayer.lineJoin = kCALineJoinRound;
        
        startLayer.backgroundColor = [UIColor greenColor].CGColor;
        startLayer.position = center;

        [self.layer addSublayer:startLayer];
        // 旋转
        CGFloat alpha = angle + M_PI / 2.f;
        CATransform3D trans = CATransform3DIdentity;
        startLayer.transform = CATransform3DRotate(trans, alpha, 0, 0, 1);
    }
}

@end
