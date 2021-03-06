//
//  JYDayMoodImageCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/4/22.
//

#import "JYDayMoodImageCollectionViewCell.h"
#import "TYCyclePagerView.h"
#import "JYCyclePagerCollectionViewCell.h"
#import "JYMood.h"
#import "JYPrefixHeader.h"

@interface JYDayMoodImageCollectionViewCell () <TYCyclePagerViewDataSource, TYCyclePagerViewDelegate, JYCyclePagerCollectionViewCellDelegate>
@property (nonatomic, strong) TYCyclePagerView * cyclePagerView;
@end

@implementation JYDayMoodImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithSubViews];
    }
    return self;
}

- (void)initWithSubViews {
    [self.contentView addSubview:self.cyclePagerView];
}

- (TYCyclePagerView *)cyclePagerView {
    if (!_cyclePagerView) {
        _cyclePagerView = [[TYCyclePagerView alloc] initWithFrame:CGRectZero];
        _cyclePagerView.isInfiniteLoop = NO;
        _cyclePagerView.dataSource = self;
        _cyclePagerView.delegate = self;
        [_cyclePagerView registerClass:[JYCyclePagerCollectionViewCell class] forCellWithReuseIdentifier:@"JYCyclePagerCollectionViewCell"];
    }
    
    return _cyclePagerView;
}

- (void)setMoods:(NSArray *)moods {
    if (_moods != moods) {
        _moods = moods;
        [self.cyclePagerView reloadData];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _cyclePagerView.frame = self.contentView.bounds;
}

#pragma mark -- JYCyclePagerCollectionViewCellDelegate

- (CGRect)targetRect {
    if ([self.delegate respondsToSelector:@selector(inView:)]) {
        UIView *inview = [self.delegate inView:self];
        CGRect rect = [inview convertRect:self.frame toView:inview];
        return rect;
    }

    return CGRectZero;
}

- (UIView *)inView:(JYCyclePagerCollectionViewCell *)cell {
    if ([self.delegate respondsToSelector:@selector(inView:)]) {
        return [self.delegate inView:self];
    }
    return nil;
}

- (void)cyclePagerCollectionViewCell:(JYCyclePagerCollectionViewCell *)cell didDeleteAction:(id)sender {
    NSIndexPath *indexPath = [self.cyclePagerView.collectionView indexPathForCell:cell];
    if ([self.delegate respondsToSelector:@selector(dayMoodImageCollectionViewCell:didDeletedItemAtIndex:)]) {
        [self.delegate dayMoodImageCollectionViewCell:self didDeletedItemAtIndex:indexPath.row];
    }
}

#pragma mark -- TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.moods.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    JYMood *mood = self.moods[index];
    UIImage *image = [UIImage imageWithData:mood.data];
    JYCyclePagerCollectionViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"JYCyclePagerCollectionViewCell" forIndex:index];
    cell.delegate = self;
    cell.image = image;
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = pageView.size;
    layout.itemSpacing = 0;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(dayMoodImageCollectionViewCell:didSelectedItemAtIndex:)]) {
        [self.delegate dayMoodImageCollectionViewCell:self didSelectedItemAtIndex:index];
    }
}

@end
