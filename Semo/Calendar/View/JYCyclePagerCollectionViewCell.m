//
//  JYCyclePagerCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/4/22.
//

#import "JYCyclePagerCollectionViewCell.h"
#import "QBPopupMenu.h"
#import "JYPrefixHeader.h"

@interface JYCyclePagerCollectionViewCell ()
@property (nonatomic, strong) UIImageView * imageView;
@end

@implementation JYCyclePagerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithSubViews];
    }
    return self;
}

- (void)initWithSubViews {
    [self.contentView addSubview:self.imageView];
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] init];
    [self addGestureRecognizer:longGesture];
    [longGesture addTarget:self action:@selector(longAction:)];
}

- (void)longAction:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(targetRect)]) {
            UIView *inview = [self.delegate inView:self];
            CGRect rect = self.delegate.targetRect;
            QBPopupMenuItem *item = [QBPopupMenuItem itemWithTitle:@"Delete" target:self action:@selector(popupMenuAction:)];
            QBPopupMenu *popupMenu = [[QBPopupMenu alloc] initWithItems:@[item]];
            [popupMenu showInView:inview targetRect:rect animated:YES];
        }
    }
}

- (void)popupMenuAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cyclePagerCollectionViewCell:didDeleteAction:)]) {
        [self.delegate cyclePagerCollectionViewCell:self didDeleteAction:sender];
    }
}

- (void)setImage:(nullable UIImage *)image {
    if (_image != image) {
        _image = image;
        self.imageView.image = image;
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    return _imageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.size = CGSizeMake(self.contentView.height, self.contentView.height);
    _imageView.centerX = self.contentView.width / 2.f;
    _imageView.centerY = self.contentView.height / 2.f;
}

@end
