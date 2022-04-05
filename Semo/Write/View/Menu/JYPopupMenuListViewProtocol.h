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

@class JYPopupStyleMenuListView;
@protocol JYPopupMenuListViewProtocol;

@protocol JYPopupMenuListViewDelegate <NSObject>
@optional
- (void)menuListView:(id <JYPopupMenuListViewProtocol>)listView didSelectItem:(JYMenu *)item;
@end

@protocol JYPopupMenuListViewProtocol <NSObject>
@property (nonatomic, weak) id <JYPopupMenuListViewDelegate> delegate;
@property (nonatomic, strong) id <JYPopupListMenuDataProtocol> item;
@property (nonatomic, strong) UIImage *image;
+ (instancetype)itemViewWithItem:(id <JYPopupListMenuDataProtocol>)item;
- (instancetype)initWithItem:(id<JYPopupListMenuDataProtocol>)item;

@end

#endif /* JYPopupMenuListViewProtocol_h */
