//
//  JYGridView.m
//  Semo
//
//  Created by jiyang on 2022/3/18.
//

#import "JYGridView.h"
#import "JYPrefixHeader.h"

@implementation JYGridView {
    NSInteger _verLineCount;
    NSInteger _horLineCount;
    CGFloat _scale;
}

#pragma mark 绘制直线

- (void)drawGridWithVerLineCount:(NSInteger)verLineCount horLineCount:(NSInteger)horLineCount scale:(CGFloat)scale {
    _verLineCount = verLineCount;
    _horLineCount = horLineCount;
    _scale = scale;
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
    CGFloat gridWidth = self.gridSize.width;
    CGFloat gridHeight = self.gridSize.height;
    CGFloat rWidth = rVerlineCount * gridWidth;
    CGFloat rHeight = rHorLineCount * gridHeight;
    CGFloat gap = (self.width - rWidth) / 2.f;
    NSInteger count = 0;
    for (int i = 0; i <= rVerlineCount; i ++) {
        count ++;
        BOOL dashPattern = fmod(count, 2) == 0 ? YES : NO;
        addLineWidthRect(CGPointMake(i * gridWidth + gap, 0), CGPointMake(i * gridWidth + gap, rHeight), dashPattern);
    }
    
    count = 0;
    for (int i = 0; i <= rHorLineCount; i ++) {
        count ++;
        BOOL dashPattern = fmod(count, 2) == 0 ? YES : NO;
        addLineWidthRect(CGPointMake(gap, i * gridHeight), CGPointMake(rWidth + gap, i * gridHeight), dashPattern);
    }
}

- (CGSize)gridSize {
    CGFloat rVerlineCount = _verLineCount * 2.f;
    CGFloat rHorLineCount = _horLineCount * 2.f;
    CGFloat rScale = _scale > 0 ? _scale : 1.f;
    CGFloat gridWidth = floorf(self.width / rVerlineCount);
    CGFloat gridHeight = floorf(self.height / rHorLineCount / rScale);
    return CGSizeMake(gridWidth, gridHeight);
}

@end
