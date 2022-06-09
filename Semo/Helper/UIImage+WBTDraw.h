//
//  UIImage+WBTDraw.h
//  WBTool
//
//  Created by kevin on 14-7-21.
//  Copyright (c) 2014年 Sina. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 *  绘制图片的一些工具方法。
 */
@interface UIImage (WBTDraw)

@property (nonatomic, copy) NSString * imageUrl;

/*!
 *  生成并返回一个图片朝向为UIImageOrientationUp的UIImage对象
 *
 *  @return 返回方向为UIImageOrientationUp的UIImage图片
 */
- (UIImage *)wbt_fixOrientation;

/*!
 *  在UIGraphicsGetCurrentContext上根据rect和contentMode和context绘制图片
 *
 *  @param rect        所要绘制的rect值
 *  @param contentMode 需要设置的contentMode
 */
- (void)wbt_drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode;

/*!
 *  在所给的context上根据rect和contentMode和context绘制图片
 *
 *  @param rect        所要绘制的rect值
 *  @param contentMode 需要设置的contentMode
 *  @param context     当前所要绘制的context
 */
- (void)wbt_drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode withContext:(CGContextRef)context;
- (void)wbt_drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode withContext:(CGContextRef)context isTileResizing:(BOOL)tile;

/*!
 *  根据要添加的文字字符串，文字字体，文字颜色，字体位置，生成一个添加文字后的UIImage对象
 *
 *  @param text  需要绘制的文本
 *  @param font  绘制文本的字体
 *  @param color 绘制文本的颜色
 *  @param point 绘制文本的位置
 *
 *  @return 根据相应参数生成的UIImage对象
 */
- (UIImage*)wbt_drawText:(NSString*)text withFont:(UIFont*)font andTextColor:(UIColor*)color atPosition:(CGPoint)point;

/*!
 *  根据指定的图片和位置，将指定图片绘制到当前图片并返回生成的UIImage对象
 *
 *  @param logo  要绘制的logo图片
 *  @param point 位置
 *
 *  @return 生成的图片
 */
- (UIImage*)wbt_drawImageLogo:(UIImage*)logo atPosition:(CGPoint)point;



- (UIImage*)wbt_drawImageLogo:(UIImage*)logo withRect:(CGRect)rect;


/*!
 *  根据指定的图片大小和绘制的block，生成并返回一个UIImage图片
 *
 *  @param size 图片尺寸
 *  @param scale 生成的图片的 scale (@1x, @2x)
 *  @param draw 绘制block
 *
 *  @return 绘制后的图片
 */
+ (UIImage *)wbt_imageWithSize:(CGSize)size scale:(CGFloat)scale drawing:(void(^)(CGContextRef ctx, CGRect bounds))draw;
+ (UIImage *)wbt_imageWithSize:(CGSize)size drawing:(void(^)(CGContextRef ctx, CGRect bounds))draw;

/*!
 *  Lazy Image 的 drawBlock 仅在第一次访问CGImage时调用，因此可以方便地和异步绘制逻辑结合
 *
 *  @param size 图片的尺寸
 *  @param draw 绘制block
 *
 *  @return 生成的UIImage对象
 */
+ (UIImage *)wbt_lazyImageWithSize:(CGSize)size drawing:(void(^)(CGContextRef ctx, CGRect bounds))draw;

/*!
 *  根据当前图片的orientation，生成图片orientation为UIImageOrientationUp的CGAffineTransform
 *
 *  @return 转换后的CGAffineTransform
 */
- (CGAffineTransform)wbt_affineTransformForCurrentOrientation;
/*!
 *  根据指定的颜色和radius(0~1)绘制圆角的image
 *
 *  @param color  图片颜色
 *  @param r 圆角半径
 *
 *  @return UIImage对象
 */
+ (UIImage *)wbt_createRoundCornerImagewithColor:(UIColor* )color radius:(CGFloat)r;
/*!
 *  通过颜色转成图片
 *
 *  @param color  图片颜色
 *
 *  @return UIImage对象
 */
+ (UIImage *)wbt_imageWithColor:(UIColor *)color;

/*
 * 根据contentMode转化rect
 */
- (CGRect)wbt_convertRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode;

- (UIImage *)wbt_imageWithColorSpace:(CGColorSpaceRef)colorSpaceRef;

- (UIImage *)wbt_maskImageWithColor:(UIColor *)maskColor;



/**
 *  生成一个可拥有圆角和渐变颜色的image
 *  @discussion 可生成两个颜色渐变的图片。可设置圆角，但圆角需小于宽和高的一半。
 *
 *  @param size             图片大小
 *  @param cornerRadius     圆角大小（半径）
 *  @param fromColor        初始渐变颜色，不可为空
 *  @param toColor          结束渐变颜色，不可为空
 *  @param isUpToBottom     颜色渐变是否为从上到下，YES为从上到下渐变，NO为从左到右渐变
 *
 *  @return 生成的图片
 */
+ (UIImage *)wbt_drawGradientCornersImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor isUpToBottom:(BOOL)isUpToBottom;

@end
