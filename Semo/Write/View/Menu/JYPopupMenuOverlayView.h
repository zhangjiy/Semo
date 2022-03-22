//
//  JYPopupMenuOverlayView.h
//  Semo
//
//  Created by jiyang on 2022/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JYPopupMenu;

@interface JYPopupMenuOverlayView : UIView

@property (nonatomic, weak) JYPopupMenu *popupMenu;

@end

NS_ASSUME_NONNULL_END
