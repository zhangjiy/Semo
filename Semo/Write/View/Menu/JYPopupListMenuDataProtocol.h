//
//  JYPopupListMenuDataProtocol.h
//  Semo
//
//  Created by jiyang on 2022/3/22.
//

#ifndef JYPopupListMenuDataProtocol_h
#define JYPopupListMenuDataProtocol_h
#import "JYMenu.h"

@protocol JYPopupListMenuDataProtocol <NSObject>
@optional

@property (nonatomic, assign, readonly) JYPaintingType type;
@property (nonatomic, copy) NSArray <JYMenu *> * menus;

@end

#endif /* JYPopupListMenuDataProtocol_h */
