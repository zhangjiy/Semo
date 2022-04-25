//
//  UIColor+Extensions.m
//  Comhe
//
//  Created by jiyang on 2022/3/1.
//

#import "UIColor+Extensions.h"

#define ColorValue(value)  MAX(0, MIN(1, value))

UIColor *wbt_UIColorMakeRGB(CGFloat red, CGFloat green, CGFloat blue) {
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
}

UIColor *wbt_UIColorMakeRGBA(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

@implementation UIColor (Extensions)

+ (CGFloat)wbt_redColorFromHexRGBColor:(NSInteger)color {
    return (((color & 0xff0000) >> 16) / 255.0);
}

+ (CGFloat)wbt_greenColorFromRGBColor:(NSInteger)color {
    return (((color & 0x00ff00) >> 8) / 255.0);
}

+ (CGFloat)wbt_blueColorFromRGBColor:(NSInteger)color {
    return ((color & 0x0000ff) / 255.0);
}

+ (CGFloat)wbt_alphaValueFromRGBAColor:(NSInteger)color {
    return (((color & 0xff000000) >> 24) / 255.0);
}

+ (UIColor *)wbt_colorWithHexValue:(NSInteger)color alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:[UIColor wbt_redColorFromHexRGBColor:color]
                           green:[UIColor wbt_greenColorFromRGBColor:color]
                            blue:[UIColor wbt_blueColorFromRGBColor:color]
                           alpha:alpha];
}

+ (UIColor *)wbt_ColorFromHexString:(NSString *)HexString{
    // 原先调用均为 6 位
    return [self wbt_colorWithHexString:HexString alpha:1.0];
}

+ (UIColor *)wbt_ColorFromRGBAHexString:(NSString *)HexString
{
    return [self wbt_ColorWithHexString:HexString];
}

+ (UIColor *)wbt_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    if (hexString == nil ||
        [hexString isEqualToString:@""] ||
        [hexString isEqualToString:@"#"]) {
        return nil;
    }
    
    NSMutableCharacterSet *set = [[NSCharacterSet whitespaceAndNewlineCharacterSet] mutableCopy];
    [set addCharactersInString:@"#"];
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:set] uppercaseString];
    
    // 转换 3/4 位为 6/8 位
    if (cString.length == 3) {
        cString = [self transferToNewString:cString];
    } else if (cString.length == 4) {
        cString = [self transferToNewString:cString];
    }
    
    unsigned long hexValue = strtoul([cString UTF8String], 0, 16);
    if (cString.length <= 6) {
        return [UIColor wbt_colorWithHexValue:hexValue alpha:alpha];
    } else {
        return [UIColor wbt_colorWithHexValue:hexValue alpha:[self wbt_alphaValueFromRGBAColor:hexValue]];
    }
    
    return [UIColor wbt_colorWithHexValue:hexValue alpha:alpha];
}

+ (UIColor *)wbt_ColorWithHexString:(NSString *)hexString {
    return [self wbt_colorWithHexString:hexString alpha:1.0];
}

- (void)wbt_getColorComponentsWithRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:red green:green blue:blue alpha:alpha];
    } else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        *red = components[0];
        *green = components[1];
        *blue = components[2];
        *alpha = components[3];
    }
}

+ (NSString *)transferToNewString:(NSString *)oldString {
    NSInteger length = oldString.length;
    if (length == 3) {
        NSString *subString1 = [oldString substringWithRange:NSMakeRange(0, 1)];
        NSString *subString2 = [oldString substringWithRange:NSMakeRange(1, 1)];
        NSString *subString3 = [oldString substringWithRange:NSMakeRange(2, 1)];
        NSString *newString = [NSString stringWithFormat: @"%@%@%@%@%@%@", subString1, subString1, subString2, subString2, subString3, subString3];
        
        return newString;
    } else if (length == 4) {
        NSString *subString1 = [oldString substringWithRange:NSMakeRange(0, 1)];
        NSString *subString2 = [oldString substringWithRange:NSMakeRange(1, 1)];
        NSString *subString3 = [oldString substringWithRange:NSMakeRange(2, 1)];
        NSString *subString4 = [oldString substringWithRange:NSMakeRange(3, 1)];
        NSString *newString = [NSString stringWithFormat: @"%@%@%@%@%@%@%@%@", subString1, subString1, subString2, subString2, subString3, subString3, subString4, subString4];
        
        return newString;
    }
    return nil;
}

- (NSArray *)HSBArray {

    CGFloat h = 0.0,s = 0.0,b = 0.0,a = 0.0;
    
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    
    return @[@(ColorValue(h)), @(ColorValue(s)),@(ColorValue(b)),@(ColorValue(a))];
}

- (NSArray *)RGBArray {
    CGFloat r = 0.0,g = 0.0,b = 0.0,a = 0.0;
    
    [self getRed:&r green:&g blue:&b alpha:&a];
    
    return @[@(ColorValue(r)), @(ColorValue(g)), @(ColorValue(b)), @(ColorValue(a))];
}

- (CGFloat)whiteValue {
    CGFloat whiteValue = -1;
    
    NSArray * rgbArray = self.RGBArray;
    
    if (rgbArray.count == 4) {
        
        CGFloat red = [rgbArray[0] floatValue];
        CGFloat green = [rgbArray[1] floatValue];
        CGFloat blue = [rgbArray[2] floatValue];
        
        if (red == green && red == blue) {
            whiteValue = [rgbArray[0] floatValue];
        }
    }
    return whiteValue;
}

@end
