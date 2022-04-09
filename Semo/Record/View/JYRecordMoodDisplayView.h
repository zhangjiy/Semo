//
//  JYRecordMoodDisplayView.h
//  Semo
//
//  Created by jiyang on 2022/4/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYRecordMoodDisplayView : UIView
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) UIColor * textColor;
@property (nonatomic, assign, readonly) CGSize imageSize;
@end

NS_ASSUME_NONNULL_END
