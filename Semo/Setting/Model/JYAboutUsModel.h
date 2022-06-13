//
//  JYAboutUsModel.h
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYAboutUsModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) UIColor *backgoundColor;
@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, assign) BOOL showBottomLine;
@property (nonatomic, assign) CGFloat cellHeight;
@end

NS_ASSUME_NONNULL_END
