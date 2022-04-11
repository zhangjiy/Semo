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
@property (nonatomic, strong, readonly) UIImage * resultMoodImage;

@end

#endif /* JYRecordMoodManagerProtocol_h */
