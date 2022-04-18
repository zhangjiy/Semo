//
//  JYPopupMenuDataProtocol.h
//  Semo
//
//  Created by jiyang on 2022/4/18.
//

#ifndef JYPopupMenuDataProtocol_h
#define JYPopupMenuDataProtocol_h
#import "JYMenu.h"

@protocol JYPopupMenuDataProtocol <NSObject>
@optional

@property (nonatomic, assign, readonly) JYPaintingType type;
@property (nonatomic, strong, readonly) NSString *title;

@end

#endif /* JYPopupMenuDataProtocol_h */
