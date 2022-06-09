//
//  UIImage+WBTDraw.m
//  WBTool
//
//  Created by kevin on 14-7-21.
//  Copyright (c) 2014年 Sina. All rights reserved.
//

#import "UIImage+WBTDraw.h"
#import <objc/runtime.h>

static NSString * imageUrlNameKey = @"imageUrlNameKey";

@interface NSThread ()
- (void)setStackAssociateInfo:(NSString *)info;
@end

@interface WBTLazyDrawingImage : UIImage

+ (instancetype)_lazyImageWithSize:(CGSize)size drawing:(void (^)(CGContextRef ctx, CGRect bounds))draw;

@end

@implementation UIImage (WBTDraw)

- (NSString *)imageUrl
{
    return objc_getAssociatedObject(self, &imageUrlNameKey);
}

- (void)setImageUrl:(NSString *)imageUrl
{
    objc_setAssociatedObject(self, &imageUrlNameKey, imageUrl, OBJC_ASSOCIATION_COPY);
}

- (CGRect)wbt_convertRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode {
	if (self.size.width != rect.size.width || self.size.height != rect.size.height) {
		if (contentMode == UIViewContentModeLeft) {
			return CGRectMake(rect.origin.x,
							  rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeRight) {
			return CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
							  rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeTop) {
			return CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
							  rect.origin.y,
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeBottom) {
			return CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
							  rect.origin.y + floor(rect.size.height - self.size.height),
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeCenter) {
			return CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
							  rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeBottomLeft) {
			return CGRectMake(rect.origin.x,
							  rect.origin.y + floor(rect.size.height - self.size.height),
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeBottomRight) {
			return CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
							  rect.origin.y + (rect.size.height - self.size.height),
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeTopLeft) {
			return CGRectMake(rect.origin.x,
							  rect.origin.y,
							  
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeTopRight) {
			return CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
							  rect.origin.y,
							  self.size.width, self.size.height);
		} else if (contentMode == UIViewContentModeScaleAspectFill) {
			CGSize imageSize = self.size;
            if ((imageSize.height / rect.size.height) == (imageSize.width / rect.size.width))
            {// 如果比例相同，直接返回要绘制的尺寸
                return rect;
            }else if ((imageSize.height / rect.size.height) < (imageSize.width / rect.size.width)) {
				imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
				imageSize.height = rect.size.height;
			} else {
				imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
				imageSize.width = rect.size.width;
			}
			return CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
							  rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
							  imageSize.width, imageSize.height);
		} else if (contentMode == UIViewContentModeScaleAspectFit) {
			CGSize imageSize = self.size;
			if ((imageSize.height / rect.size.height) < (imageSize.width / rect.size.width)) {
				imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
				imageSize.width = rect.size.width;
			} else {
				imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
				imageSize.height = rect.size.height;
			}
			return CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
							  rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
							  imageSize.width, imageSize.height);
		}
	}
	return rect;
}

- (void)wbt_drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode
{
    [self wbt_drawInRect:rect contentMode:contentMode withContext:UIGraphicsGetCurrentContext()];
}

- (CGAffineTransform)wbt_affineTransformForCurrentOrientation
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
        default:
            break;
    }
    
    return transform;
}

- (UIImage *)wbt_fixOrientation
{
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = [self wbt_affineTransformForCurrentOrientation];
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (void)wbt_drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode withContext:(CGContextRef)context isTileResizing:(BOOL)tile
{
    @synchronized (self)
    {
        BOOL clip = NO;
        CGRect originalRect = rect;
        if (self.size.width != rect.size.width || self.size.height != rect.size.height) {
            clip = contentMode != UIViewContentModeScaleAspectFill
            && contentMode != UIViewContentModeScaleAspectFit;
            rect = [self wbt_convertRect:rect withContentMode:contentMode];
        }
        if (context == NULL) {
            return;
        }
        
        CGContextSaveGState(context);
        if (clip)
        {
            CGContextAddRect(context, originalRect);
            CGContextClip(context);
        }
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, originalRect.size.height);
        CGContextScaleCTM(context, 1, -1);
        if (tile)
        {
            CGContextDrawTiledImage(context, rect, self.CGImage);
        }
        else
        {
            CGContextDrawImage(context, rect, self.CGImage);
        }
        CGContextRestoreGState(context);

        CGContextRestoreGState(context);
    }
    return;
}

- (void)wbt_drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode withContext:(CGContextRef)context
{
    [self wbt_drawInRect:rect contentMode:contentMode withContext:context isTileResizing:NO];
}

//- (UIImage*)wbt_drawText:(NSString*)text withFont:(UIFont*)font andTextColor:(UIColor*)color atPosition:(CGPoint)point
//{
//    if (!self.size.height || !self.size.width) {
//        return self;
//    }
//    UIGraphicsBeginImageContextWithOptions(self.size, FALSE, self.scale);
//    [self drawInRect:CGRectMake(0,0,self.size.width,self.size.height)];
//    CGRect rect = CGRectMake(point.x, point.y, self.size.width - point.x, self.size.height - point.y);
//    
//    
//    CGFloat height = [text wbt_sizeWithFont:font forWidth:50 lineBreakMode:NSLineBreakByTruncatingTail].height;
//    rect.size.height = height;
//    
//    
//    //用label处理截断的问题
//    UILabel *tempLabel = [[UILabel alloc] initWithFrame:rect];
//    tempLabel.textColor = color;
//    tempLabel.text = text;
//    tempLabel.numberOfLines = 1;
//    tempLabel.font = font;
//    [tempLabel drawTextInRect:rect];
//    
//    // [text drawInRect:CGRectIntegral(rect) withFont:font];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
////    [tempLabel release];
//    return newImage;
//}

- (UIImage*)wbt_drawImageLogo:(UIImage*)logo atPosition:(CGPoint)point
{
    if (!self.size.height || !self.size.width) {
        return self;
    }
    UIGraphicsBeginImageContextWithOptions(self.size, FALSE, self.scale);
    [self drawInRect:CGRectMake(0,0,self.size.width,self.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, logo.size.width, logo.size.height);
    
    [logo drawInRect:rect];
    
    
    // [text drawInRect:CGRectIntegral(rect) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)wbt_drawImageLogo:(UIImage*)logo withRect:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(self.size, FALSE, self.scale);
    [self drawInRect:CGRectMake(0,0,self.size.width,self.size.height)];

    [logo drawInRect:rect];
    
    
    // [text drawInRect:CGRectIntegral(rect) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)wbt_imageWithSize:(CGSize)size drawing:(void(^)(CGContextRef ctx, CGRect bounds))draw
{
    return [self wbt_imageWithSize:size scale:[[UIScreen mainScreen] scale] drawing:draw];
}

+ (UIImage *)wbt_imageWithSize:(CGSize)size scale:(CGFloat)scale drawing:(void (^)(CGContextRef, CGRect))draw
{
    if (!size.height || !size.width) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
	if (draw) draw(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height));
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
	return image;
}

+ (UIImage *)wbt_lazyImageWithSize:(CGSize)size drawing:(void(^)(CGContextRef ctx, CGRect bounds))draw
{
    return [WBTLazyDrawingImage _lazyImageWithSize:size drawing:draw];
}

+ (UIImage *)wbt_createRoundCornerImagewithColor:(UIColor* )color radius:(CGFloat)r
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 10.0f, 10.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1);//画笔线宽
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
    CGFloat radius = 10*r;
    
    CGFloat minx = CGRectGetMinX(rect);
    CGFloat maxx = CGRectGetMaxX(rect);
    
    CGFloat miny = CGRectGetMinY(rect);
    CGFloat maxy = CGRectGetMaxY(rect);
    
    //绘制四个圆角
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, minx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, miny, maxx, miny, radius);
    
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)wbt_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)wbt_imageWithColorSpace:(CGColorSpaceRef)colorSpaceRef
{
    if (!colorSpaceRef) {
        return self;
    }
    
    UIImage *image = self;
    
    CGColorSpaceRef currentColorSpace = CGImageGetColorSpace(image.CGImage);
    
    if (!currentColorSpace) {
        return self;
    }
    
    
    NSData *currentColorSpaceData = (__bridge_transfer NSData *)CGColorSpaceCopyICCProfile(currentColorSpace);
    NSData *targetColorSpaceData = (__bridge_transfer NSData *)CGColorSpaceCopyICCProfile(colorSpaceRef);
    if (currentColorSpaceData.length == 0 || targetColorSpaceData.length == 0) {
        return self;
    }

    if ([targetColorSpaceData isEqualToData:currentColorSpaceData]) { //color space is same
        return self;
    }
    
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, CGImageGetWidth(image.CGImage), CGImageGetHeight(image.CGImage));
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(NULL, imageRect.size.width, imageRect.size.height, 8, 0, colorSpaceRef, kCGImageAlphaNoneSkipLast);
    
    // Draw image into current context, with specified rectangle
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // Create bitmap image info from pixel data in current context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // Create a new UIImage object
    UIImage *newImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    
    // Release colorspace, context and bitmap information
    CGContextRelease(context);
    CGImageRelease(imageRef);
    
    if (!newImage) {
        return self;
    }
    
    // Return the new image
    return newImage;
}

- (UIImage *)wbt_maskImageWithColor:(UIColor *)maskColor
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [maskColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    [self drawInRect:bounds blendMode:kCGBlendModeMultiply alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

+ (UIImage *)wbt_drawGradientCornersImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor isUpToBottom:(BOOL)isUpToBottom
{
    if (cornerRadius>size.width/2.f || cornerRadius>size.height/2.f || fromColor==nil || toColor==nil) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, cornerRadius, 0);
    CGPathAddLineToPoint(path, NULL, size.width-cornerRadius, 0);
    CGPathAddArc(path, NULL, size.width-cornerRadius, cornerRadius, cornerRadius, M_PI*1.5f, 0, 0);
    CGPathAddLineToPoint(path, NULL, size.width, size.height-cornerRadius);
    CGPathAddArc(path, NULL, size.width-cornerRadius, size.height-cornerRadius, cornerRadius, 0, M_PI_2, 0);
    CGPathAddLineToPoint(path, NULL, cornerRadius, size.height);
    CGPathAddArc(path, NULL, cornerRadius, size.height-cornerRadius, cornerRadius, M_PI_2, M_PI, 0);
    CGPathAddLineToPoint(path, NULL, 0, cornerRadius);
    CGPathAddArc(path, NULL, cornerRadius, cornerRadius, cornerRadius, M_PI, M_PI*1.5f, 0);
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGPathRelease(path);
    
    CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){fromColor.CGColor,toColor.CGColor}, 2, nil);
    CGGradientRef gradient = CGGradientCreateWithColors(rgb, colorArray, (CGFloat[]){0.0,1.0});
    CGPoint startPoint,endPoint;
    if (isUpToBottom) {
        startPoint = CGPointMake(size.width/2.f, 0);
        endPoint = CGPointMake(size.width/2.f, size.height);
    }else{
        startPoint = CGPointMake(0, size.height/2.f);
        endPoint = CGPointMake(size.width, size.height/2.f);
    }
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(rgb);
    CFRelease(colorArray);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

#pragma mark - Lazy Drawing Image

@interface WBTLazyDrawingImage ()

@property (nonatomic, assign) CGSize drawingSize;
@property (nonatomic, copy) void (^drawBlock)(CGContextRef ctx, CGRect bounds);
@property (nonatomic, retain) UIImage * internalImage; // 让UIImage做内存管理

@end

@implementation WBTLazyDrawingImage

- (void)dealloc
{
//    [_drawBlock release],
    _drawBlock = nil;
//    [_internalImage release],
    _internalImage = nil;
//    [super dealloc];
}

+ (instancetype)_lazyImageWithSize:(CGSize)size drawing:(void (^)(CGContextRef ctx, CGRect bounds))draw
{
    WBTLazyDrawingImage * image = [[self alloc] init] ;//autorelease];
    image.drawingSize = size;
    image.drawBlock = draw;
    
    return image;
}

- (UIImage *)internalImage
{
    if (!_internalImage)
    {
        _internalImage = [UIImage wbt_imageWithSize:_drawingSize drawing:self.drawBlock];//retain];
    }
    return _internalImage;
}

- (CGImageRef)CGImage
{
    return self.internalImage.CGImage;
}

// for iOS 5, iOS 5 不会通过getter取 CGImage，因此还需要重写此方法完成绘制
- (void)drawInRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha
{
    [self.internalImage drawInRect:rect blendMode:blendMode alpha:alpha];
}

- (CGSize)size
{
    return _drawingSize;
}

@end
