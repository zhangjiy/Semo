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

- (void)drawGridWithVerLineCount:(NSInteger)verLineCount horLineCount:(NSInteger)horLineCount {
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
    
    CGFloat gridWidth = self.width / (verLineCount * 2.f);
    CGFloat gridHeight = self.height / (horLineCount * 2.f);
    NSInteger count = 0;
    for (int i = 0; i <= self.width; i += gridWidth) {
        count ++;
        BOOL dashPattern = fmod(count, 2) == 0 ? YES : NO;
        addLineWidthRect(CGPointMake(i, 0.f), CGPointMake(i, self.height), dashPattern);
    }
    
    count = 0;
    for (int i = 0; i <= self.height; i += gridHeight) {
        count ++;
        BOOL dashPattern = fmod(count, 2) == 0 ? YES : NO;
        addLineWidthRect(CGPointMake(0.f, i), CGPointMake(self.width, i), dashPattern);
    }
}

@end
