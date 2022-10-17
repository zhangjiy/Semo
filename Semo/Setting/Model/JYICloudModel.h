//
//  JYICloudModel.h
//  Semo
//
//  Created by jiyang on 2022/10/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYICloudModel : NSObject
@property (nonatomic, strong, readonly) NSString *dateString;
@property (nonatomic, strong) NSString *jsonString;
@property (nonatomic, assign) NSInteger moodCount;
@end

NS_ASSUME_NONNULL_END
