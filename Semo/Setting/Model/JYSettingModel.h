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
    JYSettingItemTypeSection = 0,
    JYSettingItemTypePassword,
    JYSettingItemTypeExport,
    JYSettingItemTypeBackups,
    JYSettingItemTypeComment,
    JYSettingItemTypeHelp,
    JYSettingItemTypeFeedback,
    JYSettingItemTypeAbout
};

typedef NS_ENUM(NSInteger, JYSettingRightViewType) {
    JYSettingRightViewTypeNone = 0,
    JYSettingRightViewTypeArrow,
    JYSettingRightViewTypeSwitch,
};

@interface JYSettingModel : NSObject
@property (nonatomic, assign, readonly) JYSettingItemType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) UIColor *backgoundColor;
@property (nonatomic, assign) JYSettingRightViewType rightViewType;
@property (nonatomic, assign) BOOL showBottomLine;
- (instancetype)initWithType:(JYSettingItemType)type;
@end

NS_ASSUME_NONNULL_END
