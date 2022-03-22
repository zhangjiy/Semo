//
//  JYPopupMenuListView.h
//  Semo
//
//  Created by jiyang on 2022/3/22.
//

#import <Foundation/Foundation.h>
#import "JYPopupListMenuDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class JYPopupMenu;

@interface JYPopupMenuListView : UIView

@property (nonatomic, weak) JYPopupMenu *popupMenu;

@property (nonatomic, strong) id <JYPopupListMenuDataProtocol> item;
@property (nonatomic, strong) UIImage *image;
+ (instancetype)itemViewWithItem:(id <JYPopupListMenuDataProtocol>)item;
- (instancetype)initWithItem:(id<JYPopupListMenuDataProtocol>)item;

@end

NS_ASSUME_NONNULL_END
