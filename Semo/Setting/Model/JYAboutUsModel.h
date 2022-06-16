//
//  JYAboutUsModel.h
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JYAboutUsItemType) {
    JYAboutUsItemTypeNone = 0,
    JYAboutUsItemTypeContact,
};

@interface JYAboutUsModel : NSObject
@property (nonatomic, assign, readonly) JYAboutUsItemType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) UIColor *backgoundColor;
@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, assign) BOOL showBottomLine;
- (instancetype)initWithType:(JYAboutUsItemType)type;
@end

NS_ASSUME_NONNULL_END
