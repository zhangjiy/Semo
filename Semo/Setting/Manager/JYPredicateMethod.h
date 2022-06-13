//
//  JYPredicateMethod.h
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYPredicateMethod : NSObject
#pragma mark 判断邮箱，手机，QQ的格式
+ (BOOL)isValidateEmail:(NSString *)email;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;
@end

NS_ASSUME_NONNULL_END
