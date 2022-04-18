//
//  JYPopupMenuContentViewProtocol.h
//  Semo
//
//  Created by jiyang on 2022/4/18.
//

#ifndef JYPopupMenuContentViewProtocol_h
#define JYPopupMenuContentViewProtocol_h

#import "JYPopupMenuDataProtocol.h"

@protocol JYPopupMenuContentViewProtocol <NSObject>
@property (nonatomic, strong) id <JYPopupMenuDataProtocol> item;
@property (nonatomic, strong) UIImage *image;
- (void)initSubViews;
@end

#endif /* JYPopupMenuContentViewProtocol_h */
