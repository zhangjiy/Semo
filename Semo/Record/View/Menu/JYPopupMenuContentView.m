//
//  JYPopupMenuContentView.m
//  Semo
//
//  Created by jiyang on 2022/4/18.
//

#import "JYPopupMenuContentView.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYPopupMenuContentView ()
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * titleLabel;
@end

@implementation JYPopupMenuContentView
@synthesize item = _item;
@synthesize imageView = _imageView;
@synthesize image = _image;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    [_titleLabel sizeToFit];
    _titleLabel.left = JYViewInset;
    _titleLabel.top = JYViewInset;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

- (void)setItem:(id<JYPopupMenuListDataProtocol>)item {
    if (_item != item) {
        _item = item;
        self.titleLabel.text = item.title;
    }
}

#pragma mark - Updating the View

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = _titleLabel.intrinsicContentSize.height + JYViewItemInset;
    CGFloat viewWidth = _titleLabel.intrinsicContentSize.width + JYViewInset * 2;
    CGSize viewSize = CGSizeMake(MIN(viewWidth, ScreenWidth - JYViewItemInset * 2), height);
    return viewSize;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    
    return _titleLabel;
}

@end

