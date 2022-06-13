//
//  JYSettingModel.h
//  Semo
//
//  Created by jiyang on 2022/6/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JYSettingItemType) {
    JYSettingItemTypeNone = 0,
    JYSettingItemTypeArrow,
    JYSettingItemTypeSwitch,
    JYSettingItemTypeLine,
    JYSettingItemTypeSection,
};

@interface JYSettingModel : NSObject
@property (nonatomic, assign, readonly) JYSettingItemType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) UIColor *backgoundColor;
@property (nonatomic, assign) BOOL showBottomLine;
- (instancetype)initWithType:(JYSettingItemType)type;
@end

NS_ASSUME_NONNULL_END
