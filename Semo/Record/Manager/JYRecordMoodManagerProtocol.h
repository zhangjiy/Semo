//
//  JYRecordMoodManagerProtocol.h
//  Semo
//
//  Created by jiyang on 2022/4/10.
//

#ifndef JYRecordMoodManagerProtocol_h
#define JYRecordMoodManagerProtocol_h

#import "JYViewProtocol.h"

@protocol JYRecordMoodManagerProtocol <JYViewProtocol>
@optional
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong, readonly) UIImage * resultMoodImage;
@property (nonatomic, assign, readonly) NSInteger index;
@end

#endif /* JYRecordMoodManagerProtocol_h */
