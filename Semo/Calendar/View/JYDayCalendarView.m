//
//  JYDayCalendarView.m
//  Semo
//
//  Created by jiyang on 2022/3/13.
//

#import "JYDayCalendarView.h"
#import "JYDayCalendarCollectionViewCell.h"
#import "JYYearCalendarCollectionViewCell.h"
#import "JYGridView.h"
#import "JYMonthMood.h"
#import "JYPrefixHeader.h"

@interface JYDayCalendarView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) JYGridView *gridView;
@property (nonatomic, strong) JYCalendar *calendar;
@end

@implementation JYDayCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {
    [self addSubview:self.gridView];
    [self.gridView drawGridWithVerLineCount:4 horLineCount:8 scale:4/3.f];
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _gridView.centerX = self.width / 2.f;
    _collectionView.frame = _gridView.frame;
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
        [_collectionView registerClass:[JYDayCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"JYDayCalendarCollectionViewCell"];
        [_collectionView registerClass:[JYYearCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"JYYearCalendarCollectionViewCell"];
        _collectionView.scrollsToTop = NO;
        _collectionView.contentInset = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return layout;
}

- (JYGridView *)gridView {
    if (!_gridView) {
        _gridView = [[JYGridView alloc] initWithFrame:CGRectMake(0, 0, JYHomeGridWidth, JYHomeGridHeight)];
        _gridView.backgroundColor = SMHomeBackgroudColor;
    }
    
    return _gridView;
}

- (void)setMonth:(JYMoodMonthDate *)month {
    //if (_month != month) {
        _month = month;
        [self.collectionView reloadData];
    //}
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger numberOfRows = [self.calculator numberOfRowsInMonth:self.month];
    return numberOfRows + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger numberOfRows = [self.calculator numberOfRowsInMonth:self.month];
    if (indexPath.row == numberOfRows) {
        JYYearCalendarCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYYearCalendarCollectionViewCell" forIndexPath:indexPath];

        NSString *text = [self.calculator monthNameForMonth:self.month];
        cell.text = text;
        return cell;
    }
    JYDayCalendarCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYDayCalendarCollectionViewCell" forIndexPath:indexPath];
    NSString *text = [self.calculator dayNameForMonth:self.month index:indexPath.row];
    if ([self.calculator isToday:self.month index:indexPath.row]) {
        
    }
    cell.text = text;
    NSDictionary *dayMoodDic = self.month.monthMood.dayMoodDict;
    JYDayMood *dayMood = [dayMoodDic valueForKey:text];
    NSData *data = dayMood.moods.lastObject;
    if (data) {
        UIImage *image = [UIImage imageWithData:data];
        cell.image = image;
    } else {
        cell.image = nil;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = _gridView.gridSize.width * 2;
    CGFloat height = _gridView.gridSize.height * 2;
    return CGSizeMake(width, height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id <JYMoodDate> moodDate = [self.calculator dayDayForIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(dayCalendarView:didSelectItem:didSelectItemAtIndexPath:)]) {
        [self.delegate dayCalendarView:self didSelectItem:moodDate didSelectItemAtIndexPath:indexPath];
    }
}

@end
