//
//  JYDayMoodImageCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/4/22.
//

#import "JYDayMoodImageCollectionViewCell.h"
#import "TYCyclePagerView.h"
#import "JYCyclePagerCollectionViewCell.h"
#import "QBPopupMenu.h"
#import "JYPrefixHeader.h"

@interface JYDayMoodImageCollectionViewCell () <TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>
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
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] init];
    [self.cyclePagerView addGestureRecognizer:longGesture];
    [longGesture addTarget:self action:@selector(longAction:)];
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

- (void)longAction:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(inView:)]) {
            UIView *inview = [self.delegate inView:self];
            CGRect rect = [inview convertRect:self.frame toView:inview];
            QBPopupMenuItem *item = [QBPopupMenuItem itemWithTitle:@"Delete" target:self action:@selector(popupMenuAction:)];
            QBPopupMenu *popupMenu = [[QBPopupMenu alloc] initWithItems:@[item]];
            popupMenu.tag = 1000;
            [popupMenu showInView:inview targetRect:rect animated:YES];
        }
    }
}

- (void)popupMenuAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(dayMoodImageCollectionViewCell:didDeleteAction:)]) {
        [self.delegate dayMoodImageCollectionViewCell:self didDeleteAction:sender];
    }
}

- (void)setImages:(NSArray *)images {
    if (_images != images) {
        _images = images;
        [self.cyclePagerView reloadData];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _cyclePagerView.frame = self.contentView.bounds;
}

#pragma mark -- TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.images.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    NSData *data = self.images[index];
    UIImage *image = [UIImage imageWithData:data];
    JYCyclePagerCollectionViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"JYCyclePagerCollectionViewCell" forIndex:index];
    cell.image = image;
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = pageView.size;
    layout.itemSpacing = 0;
    return layout;
}

@end
