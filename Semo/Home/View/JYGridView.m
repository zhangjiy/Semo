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

//- (void)drawLine:(CGContextRef) context {
//    CGFloat widthView = ScreenWidth;
//        CGFloat heightView = ScreenWidth;
//        CGFloat size = 3;
//
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//        CGContextSetFillColorWithColor(context,[UIColor blueColor].CGColor);
//
//        for (int i=0; i<widthView; i+=size) {
//            CGContextMoveToPoint(context,i+CENTERRECT.origin.x,+CENTERRECT.origin.y);
//            CGContextAddLineToPoint(context,i+CENTERRECT.origin.x,heightView+CENTERRECT.origin.y);
//        }
//        for (int i=0; i<heightView; i+=size) {
//            CGContextMoveToPoint(context,0+CENTERRECT.origin.x,i+CENTERRECT.origin.y);
//            CGContextAddLineToPoint(context,widthView+CENTERRECT.origin.x,i+CENTERRECT.origin.y);
//        }
//        CGContextSetLineWidth(context,1.0);
//        CGContextStrokePath(context);
//        CGContextFillPath(context);
//
////    NSInteger horCount = 15;
////    CGFloat maginInsert = 10;
////    CGFloat width = ScreenWidth - maginInsert * 2;
////    CGFloat gridWidth = width / (CGFloat)horCount;
////
////    CGFloat lineWidth = 1.f;
////
////    NSInteger verCount = 7;
////    //绘制底部表格横线
////    for (int i = 0; i < verCount; i ++){
////        //设置开始位置
////        CGContextMoveToPoint(context, maginInsert, gridWidth + gridWidth * i);
////        //设置结束位置
////        CGContextAddLineToPoint(context, (width + maginInsert), gridWidth + gridWidth * i);
////    }
////
////    //绘制底部表格竖线
////    for (int i = 0; i < (horCount + 1); i ++){
////        //设置开始位置
////        CGContextMoveToPoint(context, maginInsert + gridWidth * i, NavigationBarHeight + 15);
////        //设置结束位置
////        CGContextAddLineToPoint(context, maginInsert + gridWidth * i, (ScreenHeight - SafeAreaHeight - NavigationBarHeight) + 15);
////    }
////
////
////    [SMSealRedColor setStroke];//设置线条颜色
////    CGContextSetLineWidth(context, lineWidth);//设置线条宽度
////    CGContextDrawPath(context, kCGPathFillStroke);
//}
//
//#pragma mark 绘制底部背景色
//- (void)drawBackgroundColoc:(CGContextRef) context{
//    CGContextAddRect(context, self.bounds);//绘制矩形
//    CGContextSetFillColorWithColor(context, SMHomeBackgroudColor.CGColor);//填充颜色
//    [SMSealRedColor setStroke];//设置线条颜色
//    CGContextSetLineWidth(context, 1);//设置线条宽度
//    CGContextDrawPath(context, kCGPathFillStroke);
//}
//
//- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self drawBackgroundColoc:context];//绘制底部背景色
//    [self drawLine:context];//绘制底部网格线条
//}

- (void)ff:(CGFloat)width size:(CGSize)size{
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
        layerLine.strokeColor = [UIColor blueColor].CGColor;
        [self.layer addSublayer:layerLine];
    };
    
    CGFloat gridWidth = self.width / 8.f;
    CGFloat gridHeight = self.height / 8.f;
    
    NSInteger count = 0;
    for (int i = 0; i <= self.width; i += gridWidth) {
        count ++;
        BOOL dashPattern = fmod(count, 2) == 0 ? YES : NO;
        addLineWidthRect(CGPointMake(i, 0.f), CGPointMake(i, self.width), dashPattern);
    }
    
    count = 0;
    for (int i = 0; i <= self.height; i += gridHeight) {
        count ++;
        BOOL dashPattern = fmod(count, 2) == 0 ? YES : NO;
        addLineWidthRect(CGPointMake(0.f, i), CGPointMake(self.height, i), dashPattern);
    }
}

@end
