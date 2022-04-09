//
//  JYMonthCalendarView.m
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import "JYMonthCalendarView.h"
#import "JYCalendarCollectionViewLayout.h"
#import "JYMonthCalendarCollectionViewCell.h"
#import "JYPrefixHeader.h"

@interface JYMonthCalendarView () <UICollectionViewDelegate, UICollectionViewDataSource, JYCalendarCollectionViewLayoutDelegate, JYCalendarCalculatorDelegate, JYMonthCalendarCollectionViewCellDelegate>
@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) JYCalendarCalculator * calculator;

@property (nonatomic, strong) id <JYMoodDate> dayDate;

@end

@implementation JYMonthCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        JYCalendar *calendar = [[JYCalendar alloc] init];
        self.calculator = [[JYCalendarCalculator alloc] initWithCalendar:calendar];
        self.calculator.delegate = self;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
}

- (JYMoodMonthDate *)currentMonth {
    NSInteger index = self.calculator.currentMonthName;
    return [self.calculator monthDateForIndex:index];
}

- (NSString *)dayName {
    NSString *dayName = [self.calculator dayNameForDate:self.dayDate];
    return dayName;
}

- (NSString *)todayName {
    return [NSString stringWithFormat:@"%ld", (long)self.calculator.todayName];
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
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return layout;
}

- (void)reloadDate {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.calculator.numberOfSectionsIn;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYMonthCalendarCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    JYMoodMonthDate *moth = [self.calculator monthDateForIndex:indexPath.row];
    [cell updateViewWithMonth:moth calculator:self.calculator];
   
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.width, self.height);
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

#pragma mark - JYMonthCalendarCollectionViewCellDelegate

- (void)monthCalendarCollectionViewCell:(JYMonthCalendarCollectionViewCell *)cell didSelectItemAtIndexPath:(id <JYMoodDate>)date {
    self.dayDate = date;
    if ([self.delegate respondsToSelector:@selector(monthCalendarView:didSelectItemAtIndexPath:)]) {
        [self.delegate monthCalendarView:self didSelectItemAtIndexPath:self.dayName];
    }
}

@end
