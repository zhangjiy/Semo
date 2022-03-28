//
//  JYPopupMenuListViewProtocol.h
//  Semo
//
//  Created by jiyang on 2022/3/27.
//

#ifndef JYPopupMenuListViewProtocol_h
#define JYPopupMenuListViewProtocol_h

#import <Foundation/Foundation.h>
#import "JYPopupListMenuDataProtocol.h"

@protocol JYPopupMenuListViewProtocol <NSObject>

@property (nonatomic, strong) id <JYPopupListMenuDataProtocol> item;
@property (nonatomic, strong) UIImage *image;
+ (instancetype)itemViewWithItem:(id <JYPopupListMenuDataProtocol>)item;
- (instancetype)initWithItem:(id<JYPopupListMenuDataProtocol>)item;

@end

#endif /* JYPopupMenuListViewProtocol_h */