//
//  JYMonthCalendarViewManager.m
//  Semo
//
//  Created by jiyang on 2022/4/10.
//

#import "JYMonthCalendarViewManager.h"
#import "JYCalendarCollectionViewLayout.h"
#import "JYMonthCalendarCollectionViewCell.h"
#import "JYCalendarCalculator.h"
#import "JYMonthMood.h"
#import "JYPrefixHeader.h"

@interface JYMonthCalendarViewManager () <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, JYCalendarCollectionViewLayoutDelegate, JYCalendarCalculatorDelegate, JYMonthCalendarCollectionViewCellDelegate>
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) JYCalendarCalculator *calculator;
@property (nonatomic, strong) id <JYMoodDate> dayDate;
@end

@implementation JYMonthCalendarViewManager

@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.containerView = [[UIView alloc] initWithFrame:frame];
        [self initSubviews];
        [self initConfig];
        [self layoutSubviews];
    }
    
    return self;
}

- (void)initConfig {
    
}

- (void)initSubviews {
    [self.containerView addSubview:self.collectionView];
}

- (void)layoutSubviews {
    _collectionView.frame = self.containerView.bounds;
}

- (JYCalendarCalculator *)calculator {
    if (!_calculator) {
        _calculator = [[JYCalendarCalculator alloc] init];
        _calculator.delegate = self;
    }
    
    return _calculator;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[JYMonthCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.scrollsToTop = NO;
        _collectionView.contentInset = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _collectionView;
}

- (JYCalendarCollectionViewLayout *)collectionViewFlowLayout {
    JYCalendarCollectionViewLayout * layout = [[JYCalendarCollectionViewLayout alloc] init];
    layout.delegate = self;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return layout;
}

- (JYMoodMonthDate *)currentMonth {
    NSInteger index = self.calculator.currentPage;
    return [self.calculator monthDateForIndex:index];
}

- (NSString *)dayName {
    NSString *dayName = [self.calculator dayNameForDate:self.dayDate];
    return dayName;
}

- (NSString *)todayName {
    return [NSString stringWithFormat:@"%ld", (long)self.calculator.todayName];
}

- (void)reloadDate {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.calculator.numberOfMonths;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYMonthCalendarCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    JYMoodMonthDate *moth = [self.calculator monthDateForIndex:indexPath.row];
    [cell updateViewWithMonth:moth calculator:self.calculator];
   
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.containerView.width, self.containerView.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - JYCalendarCollectionViewLayoutDelegate

- (void)calendarCollectionViewDidPrepareLayout:(JYCalendarCollectionViewLayout *)layout {
    [self.calculator adjustMonthPosition];
}

#pragma mark - JYCalendarCalculatorDelegate

- (void)calendarCalculator:(JYCalendarCalculator *)calculator setContentOffset:(NSInteger)scrollOffset animated:(BOOL)animated {
    switch (self.collectionViewFlowLayout.scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            [self.collectionView setContentOffset:CGPointMake(0, scrollOffset * self.collectionView.height) animated:animated];
            break;
        }
        case UICollectionViewScrollDirectionHorizontal: {
            [self.collectionView setContentOffset:CGPointMake(scrollOffset * self.collectionView.width, 0) animated:animated];
            break;
        }
    }
    [self.collectionView setContentOffset:CGPointMake(0, scrollOffset * self.collectionView.height) animated:animated];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewEndScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ( !decelerate ) {
        [self scrollViewEndScroll:scrollView];
    }
}

- (void)scrollViewEndScroll:(UIScrollView *)scrollView {
    
    if (!scrollView.pagingEnabled) {
        return;
    }
    CGFloat targetOffset = 0, contentSize = 0;
    switch (self.collectionViewFlowLayout.scrollDirection) {
        case UICollectionViewScrollDirectionHorizontal: {
            targetOffset = scrollView.contentOffset.x;
            contentSize = scrollView.width;
            break;
        }
        case UICollectionViewScrollDirectionVertical: {
            targetOffset = scrollView.contentOffset.y;
            contentSize = scrollView.height;
            break;
        }
    }
    
    NSInteger index = lrint(targetOffset/contentSize);
    [self.calculator endScroll:index];
}

#pragma mark - JYMonthCalendarCollectionViewCellDelegate

- (void)monthCalendarCollectionViewCell:(JYMonthCalendarCollectionViewCell *)cell didSelectedItem:(id <JYMoodDate>)date didSelectedItemAtIndex:(NSInteger)index {
    self.dayDate = date;
    NSInteger todayIndex = JYCalendarDataIndexFromDateName(self.calculator.todayName);
    if (self.calculator.currentPage == MonthsAgo && index > todayIndex) {
        return;
    }
    
    if (index < todayIndex) {
        NSString *text = date.name;
        NSDictionary *dayMoodDic = self.currentMonth.monthMood.dayMoodDict;
        JYDayMood *dayMood = [dayMoodDic valueForKey:text];
        JYMood *mood = dayMood.moods.lastObject;
        if (mood) {
            if ([self.delegate respondsToSelector:@selector(monthCalendarViewManager:didSelectItemAtIndexPath:jumpType:)]) {
                [self.delegate monthCalendarViewManager:self didSelectItemAtIndexPath:self.dayName jumpType:JYMonthCalendarJumpTypeDetail];
            }
            return;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(monthCalendarViewManager:didSelectItemAtIndexPath:jumpType:)]) {
        [self.delegate monthCalendarViewManager:self didSelectItemAtIndexPath:self.dayName jumpType:JYMonthCalendarJumpTypeRecord];
    }
}

- (void)monthCalendarCollectionViewCell:(JYMonthCalendarCollectionViewCell *)cell didDeletedItem:(id <JYMoodDate>)date didDeletedItemAtIndex:(NSInteger)index {
    JYMoodMonthDate *moth = self.currentMonth;
    [moth.monthMood deleteDayMoodForKey:date.name itemAtIndex:index];
    [self reloadDate];
}

@end
