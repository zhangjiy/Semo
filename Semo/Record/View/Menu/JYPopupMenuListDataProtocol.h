//
//  JYPopupMenuListDataProtocol.h
//  Semo
//
//  Created by jiyang on 2022/3/22.
//

#ifndef JYPopupMenuListDataProtocol_h
#define JYPopupMenuListDataProtocol_h
#import "JYPopupMenuDataProtocol.h"
@class JYMenuLocal;
@protocol JYPopupMenuListDataProtocol <JYPopupMenuDataProtocol>
@optional
@property (nonatomic, copy) NSArray <JYMenu *> * menus;
@property (nonatomic, strong) JYMenuLocal *menuLocal;
- (instancetype)initWithType:(JYPaintingType)type;
@end

#endif /* JYPopupMenuListDataProtocol_h */
