//
//  JYHelpCenterModel.h
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYHelpCenterModel : NSObject
@property (nonatomic, strong) NSString *lineMark;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) UIColor *backgoundColor;
@property (nonatomic, assign) BOOL showBottomLine;
@end

NS_ASSUME_NONNULL_END
