//
//  JYICloudFileModel.h
//  Semo
//
//  Created by jiyang on 2022/10/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYICloudFileModel : NSObject
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) NSInteger moodCount;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, assign) BOOL selected;
@end

NS_ASSUME_NONNULL_END
