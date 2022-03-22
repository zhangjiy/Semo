//
//  JYPopupMenu.h
//  Semo
//
//  Created by jiyang on 2022/3/22.
//

#import <Foundation/Foundation.h>
#import "JYPopupListMenuDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class JYPopupMenu, JYPopupMenuListView;

@protocol JYPopupMenuDelegate <NSObject>

@optional
- (void)popupMenuWillAppear:(JYPopupMenu *)popupMenu;
- (void)popupMenuDidAppear:(JYPopupMenu *)popupMenu;
- (void)popupMenuWillDisappear:(JYPopupMenu *)popupMenu;
- (void)popupMenuDidDisappear:(JYPopupMenu *)popupMenu;

@end

typedef NS_ENUM(NSUInteger, JYPopupMenuArrowDirection) {
    JYPopupMenuArrowDirectionDefault,
    JYPopupMenuArrowDirectionUp,
    JYPopupMenuArrowDirectionDown,
    JYPopupMenuArrowDirectionLeft,
    JYPopupMenuArrowDirectionRight
};

@interface JYPopupMenu : UIView

@property (nonatomic, weak) id<JYPopupMenuDelegate> delegate;
@property (nonatomic, strong) id <JYPopupListMenuDataProtocol> item;
@property (nonatomic, assign, getter = isVisible, readonly) BOOL visible;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat arrowSize;
@property (nonatomic, assign) JYPopupMenuArrowDirection arrowDirection;
@property (nonatomic, assign) UIEdgeInsets popupMenuInsets;
@property (nonatomic, assign) CGFloat margin;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *highlightedColor;

+ (instancetype)popupListMenuWithItem:(id <JYPopupListMenuDataProtocol>)item;
- (instancetype)initWithItem:(id <JYPopupListMenuDataProtocol>)item;

- (void)showInView:(UIView *)view targetRect:(CGRect)targetRect animated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated;
- (void)updateWithTargetRect:(CGRect)targetRect;

+ (Class)itemViewClass;

- (CGMutablePathRef)arrowPathInRect:(CGRect)rect direction:(JYPopupMenuArrowDirection)direction CF_RETURNS_RETAINED;
- (CGMutablePathRef)headPathInRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius CF_RETURNS_RETAINED;
- (CGMutablePathRef)tailPathInRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius CF_RETURNS_RETAINED;
- (CGMutablePathRef)bodyPathInRect:(CGRect)rect CF_RETURNS_RETAINED;

- (void)drawArrowAtPoint:(CGPoint)point arrowSize:(CGFloat)arrowSize arrowDirection:(JYPopupMenuArrowDirection)arrowDirection highlighted:(BOOL)highlighted;
- (void)drawArrowInRect:(CGRect)rect direction:(JYPopupMenuArrowDirection)direction highlighted:(BOOL)highlighted;
- (void)drawHeadInRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius highlighted:(BOOL)highlighted;
- (void)drawTailInRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius highlighted:(BOOL)highlighted;
- (void)drawBodyInRect:(CGRect)rect firstItem:(BOOL)firstItem lastItem:(BOOL)lastItem highlighted:(BOOL)highlighted;

@end

NS_ASSUME_NONNULL_END
