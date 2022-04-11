//
//  JYCalendarCollectionViewLayout.m
//  Semo
//
//  Created by jiyang on 2022/3/13.
//

#import "JYCalendarCollectionViewLayout.h"

@implementation JYCalendarCollectionViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    if ([self.delegate respondsToSelector:@selector(calendarCollectionViewDidPrepareLayout:)]) {
        [self.delegate calendarCollectionViewDidPrepareLayout:self];
    }
}

@end
