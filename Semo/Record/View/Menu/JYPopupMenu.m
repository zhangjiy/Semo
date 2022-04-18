//
//  JYPopupListMenu.m
//  Semo
//
//  Created by jiyang on 2022/3/22.
//

#import "JYPopupMenu.h"
#import "JYPopupMenuOverlayView.h"
#import "JYPopupStyleMenuListView.h"
#import "JYPopupColorMenuListView.h"
#import "JYPopupSizeMenuListView.h"
#import "JYPopupPenMenuListView.h"

static const NSTimeInterval kQBPopupMenuAnimationDuration = 0.2;

@interface JYPopupMenu () <JYPopupMenuListViewDelegate>

@property (nonatomic, assign, getter = isVisible, readwrite) BOOL visible;
@property (nonatomic, strong) JYPopupMenuOverlayView *overlayView;

@property (nonatomic, weak) UIView *view;
@property (nonatomic, assign) CGRect targetRect;

@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) JYPopupMenuArrowDirection actualArrorDirection;
@property (nonatomic, assign) CGPoint arrowPoint;

@property (nonatomic, strong) UIView <JYPopupMenuListViewProtocol> * listView;

@end

@implementation JYPopupMenu

- (Class)itemViewClass {
    if (self.item.type == JYPaintingTypeStyle) {
        return [JYPopupStyleMenuListView class];
    }  else if (self.item.type == JYPaintingTypeSize) {
        return [JYPopupSizeMenuListView class];
    }  if (self.item.type == JYPaintingTypePen) {
        return [JYPopupPenMenuListView class];
    }
    
    return [JYPopupColorMenuListView class];
}

+ (instancetype)popupListMenuWithItem:(id <JYPopupMenuListDataProtocol>)item {
    return [[self alloc] initWithItem:item];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;

        self.height = 36;
        self.cornerRadius = 8;
        self.arrowSize = 9;
        self.arrowDirection = JYPopupMenuArrowDirectionDefault;
        self.popupMenuInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.margin = 2;
        
        self.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        self.highlightedColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.8];
    }
    
    return self;
}

- (instancetype)initWithItem:(id <JYPopupMenuListDataProtocol>)item {
    self = [self initWithFrame:CGRectZero];
    
    if (self) {
        self.item = item;
    }
    
    return self;
}


#pragma mark - Accessors

- (void)setItem:(id <JYPopupMenuListDataProtocol>)item {
    _item = item;
    
    // Create item views
    [self createListView];
}

- (void)setHeight:(CGFloat)height {
    _height = height;
    
    // Update view
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


#pragma mark - Managing Popup Menu

- (void)showInView:(UIView *)view targetRect:(CGRect)targetRect animated:(BOOL)animated {
    if ([self isVisible]) {
        return;
    }
    
    self.view = view;
    self.targetRect = targetRect;
    
    // Decide arrow direction
    JYPopupMenuArrowDirection arrowDirection = self.arrowDirection;
    
    if (arrowDirection == JYPopupMenuArrowDirectionDefault) {
        if ((targetRect.origin.y - (self.height + self.arrowSize)) >= self.popupMenuInsets.top) {
            arrowDirection = JYPopupMenuArrowDirectionDown;
        }
        else if ((targetRect.origin.y + targetRect.size.height + (self.height + self.arrowSize)) < (view.bounds.size.height - self.popupMenuInsets.bottom)) {
            arrowDirection = JYPopupMenuArrowDirectionUp;
        }
        else {
            CGFloat left = targetRect.origin.x - self.popupMenuInsets.left;
            CGFloat right = view.bounds.size.width - (targetRect.origin.x + targetRect.size.width + self.popupMenuInsets.right);
            
            arrowDirection = (left > right) ? JYPopupMenuArrowDirectionLeft : JYPopupMenuArrowDirectionRight;
        }
    }
    
    self.actualArrorDirection = arrowDirection;
    
    // Calculate width
    CGFloat maximumWidth = 0;
    CGFloat minimumWidth = 40;
    
    switch (arrowDirection) {
        case JYPopupMenuArrowDirectionDown:
        case JYPopupMenuArrowDirectionUp:
            maximumWidth = view.bounds.size.width - (self.popupMenuInsets.left + self.popupMenuInsets.right);
            if (maximumWidth < minimumWidth) maximumWidth = minimumWidth;
            break;
            
        case JYPopupMenuArrowDirectionLeft:
            maximumWidth = targetRect.origin.x - self.popupMenuInsets.left;
            break;
            
        case JYPopupMenuArrowDirectionRight:
            maximumWidth = view.bounds.size.width - (targetRect.origin.x + targetRect.size.width + self.popupMenuInsets.right);
            break;
            
        default:
            break;
    }
    
    // Show page
    [self showPage:0];
    
    // Create overlay view
    self.overlayView = ({
        JYPopupMenuOverlayView *overlayView = [[JYPopupMenuOverlayView alloc] initWithFrame:view.bounds];
        overlayView.popupMenu = self;
        
        overlayView;
    });
    
    // Delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(popupMenuWillAppear:)]) {
        [self.delegate popupMenuWillAppear:self];
    }
    
    // Show
    [view addSubview:self.overlayView];
    [view sendSubviewToBack:self.overlayView];
    
    if (animated) {
        self.alpha = 0;
        [self.overlayView addSubview:self];
        
        [UIView animateWithDuration:kQBPopupMenuAnimationDuration animations:^(void) {
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            self.visible = YES;
            
            // Delegate
            if (self.delegate && [self.delegate respondsToSelector:@selector(popupMenuDidAppear:)]) {
                [self.delegate popupMenuDidAppear:self];
            }
        }];
    } else {
        [self.overlayView addSubview:self];
        
        self.visible = YES;
        
        // Delegate
        if (self.delegate && [self.delegate respondsToSelector:@selector(popupMenuDidAppear:)]) {
            [self.delegate popupMenuDidAppear:self];
        }
    }
}

- (void)dismissAnimated:(BOOL)animated {
    if (![self isVisible]) {
        return;
    }
    
    // Delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(popupMenuWillDisappear:)]) {
        [self.delegate popupMenuWillDisappear:self];
    }
    
    if (animated) {
        [UIView animateWithDuration:kQBPopupMenuAnimationDuration animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.overlayView removeFromSuperview];
            
            self.visible = NO;
            
            // Delegate
            if (self.delegate && [self.delegate respondsToSelector:@selector(popupMenuDidDisappear:)]) {
                [self.delegate popupMenuDidDisappear:self];
            }
        }];
    } else {
        [self removeFromSuperview];
        [self.overlayView removeFromSuperview];
        
        self.visible = NO;
        
        // Delegate
        if (self.delegate && [self.delegate respondsToSelector:@selector(popupMenuDidDisappear:)]) {
            [self.delegate popupMenuDidDisappear:self];
        }
    }
}

- (void)updateWithTargetRect:(CGRect)targetRect {
    self.targetRect = targetRect;
    
    [self updatePopupMenuFrameAndArrowPosition];
    [self updatePopupMenuImage];
}

- (void)showPreviousPage {
    [self showPage:(self.page - 1)];
}

- (void)showNextPage
{
    [self showPage:(self.page + 1)];
}

- (void)showPage:(NSUInteger)page {
    self.page = page;
    
    [self updateVisibleItemViewsWithPage:page];
    [self layoutVisibleItemViews];
    [self updatePopupMenuFrameAndArrowPosition];
    [self updatePopupMenuImage];
}

- (void)updateVisibleItemViewsWithPage:(NSUInteger)page {
    [self.listView removeFromSuperview];
    [self addSubview:self.listView];
}


#pragma mark - Updating Content

- (void)createListView {
    UIView <JYPopupMenuListViewProtocol> * listView = [[self itemViewClass] itemViewWithItem:self.item];
    listView.delegate = self;
    self.listView = listView;
}


- (void)layoutVisibleItemViews {
    CGSize size = [self.listView sizeThatFits:CGSizeZero];
    self.height = size.height;
    CGFloat height = size.height;
    if (self.actualArrorDirection == JYPopupMenuArrowDirectionDown || self.actualArrorDirection == JYPopupMenuArrowDirectionUp) {
        height += self.arrowSize;
    }
    CGFloat width = size.width;
    if ((self.actualArrorDirection == JYPopupMenuArrowDirectionLeft) ||
        (self.actualArrorDirection == JYPopupMenuArrowDirectionRight)) {
        width += self.arrowSize;
    }
    
    self.listView.frame = CGRectMake(0, 0, width, height);
}

- (void)updatePopupMenuImage {
    UIImage *popupMenuImage = [self popupMenuImageWithHighlighted:NO];
    UIImage *image = [self cropImageFromImage:popupMenuImage inRect:self.listView.frame];
    self.listView.image = image;
    
}

- (UIImage *)popupMenuImageWithHighlighted:(BOOL)highlighted {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    
    CGFloat y = (self.actualArrorDirection == JYPopupMenuArrowDirectionUp) ? self.arrowSize : 0;
    CGFloat height = self.height;
    CGRect frame = self.listView.frame;
    
    CGRect headRect;
    CGRect bodyRect;
    CGRect tailRect;
    if (self.actualArrorDirection == JYPopupMenuArrowDirectionLeft) {
        headRect = CGRectMake(self.arrowSize, y, self.cornerRadius, height);
        bodyRect = CGRectMake(self.arrowSize + self.cornerRadius, y, frame.size.width - (self.arrowSize + self.cornerRadius * 2.0), height);
        tailRect = CGRectMake(frame.size.width - self.cornerRadius, y, self.cornerRadius, height);
    }
    else if (self.actualArrorDirection == JYPopupMenuArrowDirectionRight) {
        headRect = CGRectMake(0, y, self.cornerRadius, height);
        bodyRect = CGRectMake(self.cornerRadius, y, frame.size.width - (self.arrowSize + self.cornerRadius * 2.0), height);
        tailRect = CGRectMake(frame.size.width - (self.arrowSize + self.cornerRadius), y, self.cornerRadius, height);
    }
    else {
        headRect = CGRectMake(0, y, self.cornerRadius, height);
        bodyRect = CGRectMake(self.cornerRadius, y, frame.size.width - self.cornerRadius * 2.0, height);
        tailRect = CGRectMake(frame.size.width - self.cornerRadius, y, self.cornerRadius, height);
    }
    
    // Draw head
    [self drawHeadInRect:headRect cornerRadius:self.cornerRadius highlighted:highlighted];
    
    // Draw body
    [self drawBodyInRect:bodyRect firstItem:YES lastItem:YES highlighted:highlighted];
    
    // Draw tail
    [self drawTailInRect:tailRect cornerRadius:self.cornerRadius highlighted:highlighted];
    
    
    // Draw arrow
    [self drawArrowAtPoint:self.arrowPoint arrowSize:self.arrowSize arrowDirection:self.actualArrorDirection highlighted:highlighted];
    
    // Create image from buffer
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)updatePopupMenuFrameAndArrowPosition {
    // Calculate popup frame
    CGRect popupMenuFrame = CGRectZero;
    CGPoint arrowPoint = CGPointZero;
    
    UIView *itemView = self.listView;
    CGFloat width = itemView.frame.origin.x + itemView.frame.size.width;
    CGFloat height = itemView.frame.origin.y + itemView.frame.size.height;
    
    switch (self.actualArrorDirection) {
        case JYPopupMenuArrowDirectionDown: {
            popupMenuFrame = CGRectMake(self.targetRect.origin.x + (self.targetRect.size.width - width) / 2.0,
                                        self.targetRect.origin.y - (height + self.margin),
                                        width,
                                        height);
            
            if (popupMenuFrame.origin.x + popupMenuFrame.size.width > self.view.frame.size.width - self.popupMenuInsets.right) {
                popupMenuFrame.origin.x = self.view.frame.size.width - self.popupMenuInsets.right - popupMenuFrame.size.width;
            }
            if (popupMenuFrame.origin.x < self.popupMenuInsets.left) {
                popupMenuFrame.origin.x = self.popupMenuInsets.left;
            }
            
            CGFloat centerOfTargetRect = self.targetRect.origin.x + self.targetRect.size.width / 2.0;
            arrowPoint = CGPointMake(MAX(self.cornerRadius, MIN(popupMenuFrame.size.width - self.cornerRadius, centerOfTargetRect - popupMenuFrame.origin.x)),
                                     popupMenuFrame.size.height);
        }
            break;
            
        case JYPopupMenuArrowDirectionUp: {
            popupMenuFrame = CGRectMake(self.targetRect.origin.x + (self.targetRect.size.width - width) / 2.0,
                                        self.targetRect.origin.y + (self.targetRect.size.height + self.margin),
                                        width,
                                        height);
            
            if (popupMenuFrame.origin.x + popupMenuFrame.size.width > self.view.frame.size.width - self.popupMenuInsets.right) {
                popupMenuFrame.origin.x = self.view.frame.size.width - self.popupMenuInsets.right - popupMenuFrame.size.width;
            }
            if (popupMenuFrame.origin.x < self.popupMenuInsets.left) {
                popupMenuFrame.origin.x = self.popupMenuInsets.left;
            }
            
            CGFloat centerOfTargetRect = self.targetRect.origin.x + self.targetRect.size.width / 2.0;
            arrowPoint = CGPointMake(MAX(self.cornerRadius, MIN(popupMenuFrame.size.width - self.cornerRadius, centerOfTargetRect - popupMenuFrame.origin.x)),
                                     0);
        }
            break;
            
        case JYPopupMenuArrowDirectionLeft: {
            popupMenuFrame = CGRectMake(self.targetRect.origin.x + (self.targetRect.size.width + self.margin),
                                        self.targetRect.origin.y + (self.targetRect.size.height - height) / 2.0,
                                        width,
                                        height);
            
            if (popupMenuFrame.origin.y + popupMenuFrame.size.height > self.view.frame.size.height - self.popupMenuInsets.bottom) {
                popupMenuFrame.origin.y = self.view.frame.size.height - self.popupMenuInsets.bottom - popupMenuFrame.size.height;
            }
            if (popupMenuFrame.origin.y < self.popupMenuInsets.top) {
                popupMenuFrame.origin.y = self.popupMenuInsets.top;
            }
            
            CGFloat centerOfTargetRect = self.targetRect.origin.y + self.targetRect.size.height / 2.0;
            arrowPoint = CGPointMake(0,
                                     MAX(self.cornerRadius, MIN(popupMenuFrame.size.height - self.cornerRadius, centerOfTargetRect - popupMenuFrame.origin.y)));
        }
            break;
            
        case JYPopupMenuArrowDirectionRight: {
            popupMenuFrame = CGRectMake(self.targetRect.origin.x - (width + self.margin),
                                        self.targetRect.origin.y + (self.targetRect.size.height - height) / 2.0,
                                        width,
                                        height);
            
            if (popupMenuFrame.origin.y + popupMenuFrame.size.height > self.view.frame.size.height - self.popupMenuInsets.bottom) {
                popupMenuFrame.origin.y = self.view.frame.size.height - self.popupMenuInsets.bottom - popupMenuFrame.size.height;
            }
            if (popupMenuFrame.origin.y < self.popupMenuInsets.top) {
                popupMenuFrame.origin.y = self.popupMenuInsets.top;
            }
            
            CGFloat centerOfTargetRect = self.targetRect.origin.y + self.targetRect.size.height / 2.0;
            arrowPoint = CGPointMake(popupMenuFrame.size.width,
                                     MAX(self.cornerRadius, MIN(popupMenuFrame.size.height - self.cornerRadius, centerOfTargetRect - popupMenuFrame.origin.y)));
        }
            break;
            
        default:
            break;
    }
    
    // Round coordinates
    popupMenuFrame = CGRectMake(round(popupMenuFrame.origin.x),
                                round(popupMenuFrame.origin.y),
                                round(popupMenuFrame.size.width),
                                round(popupMenuFrame.size.height));
    arrowPoint = CGPointMake(round(arrowPoint.x),
                             round(arrowPoint.y));
    
    self.frame = popupMenuFrame;
    self.arrowPoint = arrowPoint;
}


#pragma mark - Creating Popup Menu Image

- (UIImage *)cropImageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGRect scaledRect = CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, scaledRect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    
    return croppedImage;
}

#pragma mark - Creating Paths

- (CGMutablePathRef)arrowPathInRect:(CGRect)rect direction:(JYPopupMenuArrowDirection)direction {
    // Create arrow path
    CGMutablePathRef path = CGPathCreateMutable();
    
    switch (direction) {
        case JYPopupMenuArrowDirectionDown:
        {
            CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y);
            CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y);
            CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width / 2.0, rect.origin.y + rect.size.height);
            CGPathCloseSubpath(path);
        }
            break;
            
        case JYPopupMenuArrowDirectionUp:
        {
            CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height);
            CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
            CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width / 2.0, rect.origin.y);
            CGPathCloseSubpath(path);
        }
            break;
            
        case JYPopupMenuArrowDirectionLeft:
        {
            CGPathMoveToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y);
            CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
            CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height / 2.0);
            CGPathCloseSubpath(path);
        }
            break;
            
        case JYPopupMenuArrowDirectionRight:
        {
            CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y);
            CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height);
            CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height / 2.0);
            CGPathCloseSubpath(path);
        }
            break;
            
        default:
            break;
    }
    
    return path;
}

- (CGMutablePathRef)headPathInRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y + cornerRadius);
    CGPathAddArcToPoint(path, NULL, rect.origin.x, rect.origin.y, rect.origin.x + cornerRadius, rect.origin.y, cornerRadius);
    CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y);
    CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGPathAddLineToPoint(path, NULL, rect.origin.x + cornerRadius, rect.origin.y + rect.size.height);
    CGPathAddArcToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height, rect.origin.x, rect.origin.y + rect.size.height - cornerRadius, cornerRadius);
    CGPathCloseSubpath(path);
    
    return path;
}

- (CGMutablePathRef)tailPathInRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y);
    CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width - cornerRadius, rect.origin.y);
    CGPathAddArcToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y, rect.origin.x + rect.size.width, rect.origin.y + cornerRadius, cornerRadius);
    CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - cornerRadius);
    CGPathAddArcToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height, rect.origin.x + rect.size.width - cornerRadius, rect.origin.y + rect.size.height, cornerRadius);
    CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height);
    CGPathCloseSubpath(path);
    
    return path;
}

- (CGMutablePathRef)bodyPathInRect:(CGRect)rect {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y);
    CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y);
    CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height);
    CGPathCloseSubpath(path);
    
    return path;
}


#pragma mark - Drawing

- (void)drawArrowAtPoint:(CGPoint)point arrowSize:(CGFloat)arrowSize arrowDirection:(JYPopupMenuArrowDirection)arrowDirection highlighted:(BOOL)highlighted {
    CGRect arrowRect = CGRectZero;
    
    switch (arrowDirection) {
        case JYPopupMenuArrowDirectionDown: {
            arrowRect = CGRectMake(point.x - arrowSize + 1.0,
                                   point.y - arrowSize,
                                   arrowSize * 2.0 - 1.0,
                                   arrowSize);
            
            arrowRect.origin.x = MIN(MAX(arrowRect.origin.x, self.cornerRadius),
                                     self.frame.size.width - self.cornerRadius - arrowRect.size.width);
        }
            break;
            
        case JYPopupMenuArrowDirectionUp: {
            arrowRect = CGRectMake(point.x - arrowSize + 1.0,
                                   0,
                                   arrowSize * 2.0 - 1.0,
                                   arrowSize);
            
            arrowRect.origin.x = MIN(MAX(arrowRect.origin.x, self.cornerRadius),
                                     self.frame.size.width - self.cornerRadius - arrowRect.size.width);
        }
            break;
            
        case JYPopupMenuArrowDirectionLeft: {
            arrowRect = CGRectMake(0,
                                   point.y - arrowSize + 1.0,
                                   arrowSize,
                                   arrowSize * 2.0 - 1.0);
        }
            break;
            
        case JYPopupMenuArrowDirectionRight: {
            arrowRect = CGRectMake(point.x - arrowSize,
                                   point.y - arrowSize + 1.0,
                                   arrowSize,
                                   arrowSize * 2.0 - 1.0);
        }
            break;
            
        default:
            break;
    }
    
    [self drawArrowInRect:arrowRect direction:arrowDirection highlighted:highlighted];
}

- (void)drawArrowInRect:(CGRect)rect direction:(JYPopupMenuArrowDirection)direction highlighted:(BOOL)highlighted {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Arrow
    CGContextSaveGState(context); {
        CGMutablePathRef path = [self arrowPathInRect:rect direction:direction];
        CGContextAddPath(context, path);
        
        UIColor *color = highlighted ? self.highlightedColor : self.color;
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillPath(context);
        
        CGPathRelease(path);
    } CGContextRestoreGState(context);
    
    // Separator
    if (direction == JYPopupMenuArrowDirectionDown || direction == JYPopupMenuArrowDirectionUp) {
        [self drawSeparatorInRect:CGRectMake(self.listView.frame.origin.x + self.listView.frame.size.width - 1, rect.origin.y, 1, rect.size.height)];
    }
}

- (void)drawHeadInRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius highlighted:(BOOL)highlighted {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Head
    CGContextSaveGState(context); {
        CGMutablePathRef path = [self headPathInRect:rect cornerRadius:cornerRadius];
        CGContextAddPath(context, path);
        
        UIColor *color = highlighted ? self.highlightedColor : self.color;
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillPath(context);
        
        CGPathRelease(path);
    } CGContextRestoreGState(context);
}

- (void)drawTailInRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius highlighted:(BOOL)highlighted {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Tail
    CGContextSaveGState(context); {
        CGMutablePathRef path = [self tailPathInRect:rect cornerRadius:cornerRadius];
        CGContextAddPath(context, path);
        
        UIColor *color = highlighted ? self.highlightedColor : self.color;
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillPath(context);
        
        CGPathRelease(path);
    } CGContextRestoreGState(context);
}

- (void)drawBodyInRect:(CGRect)rect firstItem:(BOOL)firstItem lastItem:(BOOL)lastItem highlighted:(BOOL)highlighted {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Body
    CGContextSaveGState(context); {
        CGMutablePathRef path = [self bodyPathInRect:rect];
        CGContextAddPath(context, path);
        
        UIColor *color = highlighted ? self.highlightedColor : self.color;
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillPath(context);
        
        CGPathRelease(path);
    } CGContextRestoreGState(context);
    
    // Separator
    if (!lastItem) {
        [self drawSeparatorInRect:CGRectMake(rect.origin.x + rect.size.width - 1, rect.origin.y, 1, rect.size.height)];
    }
}

- (void)drawSeparatorInRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Separator
    CGContextSaveGState(context); {
        CGContextClearRect(context, rect);
    } CGContextRestoreGState(context);
}

#pragma -- mark - JYPopupMenuListViewDelegate

- (void)menuListView:(id <JYPopupMenuListViewProtocol>)listView didSelectItem:(JYMenu *)item {
    if ([self.delegate respondsToSelector:@selector(popupMenu:didSelectItem:)]) {
        [self.delegate popupMenu:self didSelectItem:item];
    }
}

@end
