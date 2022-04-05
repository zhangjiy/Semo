//
//  JYStyleImageFactory.h
//  Semo
//
//  Created by jiyang on 2022/3/29.
//

#import <Foundation/Foundation.h>
#import "JYMenu.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYStyleImageFactory : NSObject
+ (UIImage *)styleImageFactoryFromStyleType:(JYFeelingStyleType)styleType size:(CGSize)size borderWidth:(CGFloat)borderWidth;
+ (UIColor *)textColorFactoryFromStyleType:(JYFeelingStyleType)styleType;
+ (NSInteger)indexFactoryFromPenName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
