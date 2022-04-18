//
//  JYPopupMenuListViewProtocol.h
//  Semo
//
//  Created by jiyang on 2022/3/27.
//

#ifndef JYPopupMenuListViewProtocol_h
#define JYPopupMenuListViewProtocol_h

#import <Foundation/Foundation.h>
#import "JYPopupMenuContentViewProtocol.h"
#import "JYPopupMenuListDataProtocol.h"

@class JYPopupStyleMenuListView;
@protocol JYPopupMenuListViewProtocol;

@protocol JYPopupMenuListViewDelegate <NSObject>
@optional
- (void)menuListView:(id <JYPopupMenuListViewProtocol>)listView didSelectItem:(JYMenu *)item;
@end

@protocol JYPopupMenuListViewProtocol <JYPopupMenuContentViewProtocol>
@property (nonatomic, weak) id <JYPopupMenuListViewDelegate> delegate;
@property (nonatomic, strong) id <JYPopupMenuListDataProtocol> item;
+ (instancetype)itemViewWithItem:(id <JYPopupMenuListDataProtocol>)item;
- (instancetype)initWithItem:(id<JYPopupMenuListDataProtocol>)item;

@end

#endif /* JYPopupMenuListViewProtocol_h */
