//
//  JYDayCalendarView.m
//  Semo
//
//  Created by jiyang on 2022/3/13.
//

#import "JYDayCalendarView.h"
#import "JYDayCalendarCollectionViewCell.h"
#import "JYGridView.h"
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
    self.gridView.size = [self.gridView drawGridWithVerLineCount:4 horLineCount:8 scale:4/3.f];
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _gridView.centerX = self.width / 2.f;
    _collectionView.frame = self.bounds;
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
        [_collectionView registerClass:[JYDayCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
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

- (void)setMonth:(NSDate *)month {
    if (_month != month) {
        _month = month;
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger numberOfRows = [self.calculator numberOfRowsInMonth:self.month];
    return 32;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYDayCalendarCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString *text = [self.calculator dayTextForMonth:self.month index:indexPath.row];
    [cell updateViewWithText:text];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = JYHomeGridWidth / 4.f;
    CGFloat height = width / 4.f * 3.f;
    return CGSizeMake(width, height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

@end
