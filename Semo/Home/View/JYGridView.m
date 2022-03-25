//
//  JYGridView.m
//  Semo
//
//  Created by jiyang on 2022/3/18.
//

#import "JYGridView.h"
#import "JYPrefixHeader.h"

@implementation JYGridView

#pragma mark 绘制直线

- (CGSize)drawGridWithVerLineCount:(NSInteger)verLineCount horLineCount:(NSInteger)horLineCount scale:(CGFloat)scale {
    CGFloat lineWidth = 1.f;
    void (^addLineWidthRect)(CGPoint rect, CGPoint rects, BOOL dashPattern) = ^(CGPoint rect, CGPoint rects, BOOL dashPattern) {
        UIBezierPath *pathLine = [UIBezierPath bezierPath];
        [pathLine moveToPoint:rect];
        [pathLine addLineToPoint:rects];
        
        CAShapeLayer *layerLine = [CAShapeLayer layer];
        layerLine.path = pathLine.CGPath;
        layerLine.lineWidth = lineWidth;
        layerLine.lineCap = kCALineCapRound;
        if (dashPattern) {
            layerLine.lineDashPattern = @[@(5),@(5)];
        }
        layerLine.strokeColor = SMGridLineColor.CGColor;
        [self.layer addSublayer:layerLine];
    };
    CGFloat rVerlineCount = verLineCount * 2.f;
    CGFloat rHorLineCount = horLineCount * 2.f;
    CGFloat gridWidth = floorf(self.width / rVerlineCount);
    CGFloat rScale = scale > 0 ? scale : 1.f;
    CGFloat gridHeight = floorf(self.height / rHorLineCount / rScale);
    CGFloat rWidth = rVerlineCount * gridWidth;
    CGFloat rHeight = rHorLineCount * gridHeight;
    NSInteger count = 0;
    for (int i = 0; i <= rVerlineCount; i ++) {
        count ++;
        BOOL dashPattern = fmod(count, 2) == 0 ? YES : NO;
        addLineWidthRect(CGPointMake(i * gridWidth, 0.f), CGPointMake(i * gridWidth, rHeight), dashPattern);
    }
    
    count = 0;
    for (int i = 0; i <= rHorLineCount; i ++) {
        count ++;
        BOOL dashPattern = fmod(count, 2) == 0 ? YES : NO;
        addLineWidthRect(CGPointMake(0.f, i * gridHeight), CGPointMake(rWidth, i * gridHeight), dashPattern);
    }
    
    return CGSizeMake(rWidth, rHeight);
}

@end
