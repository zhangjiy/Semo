//
//  JYMoodView.m
//  Semo
//
//  Created by jiyang on 2022/3/9.
//

#import "JYMoodView.h"

@interface JYMoodView ()
@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation JYMoodView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self addSubview:self.label];
    [self addSubview:self.imageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = self.bounds;
    _imageView.frame = self.bounds;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    
    return _label;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imageView;
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        _label.text = text;
        _label.hidden = NO;
        _imageView.hidden = YES;
    }
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        _imageView.image = image;
        _imageView.hidden = NO;
        _label.hidden = YES;
    }
}

- (void)setTextColor:(UIColor *)textColor {
    if (_textColor != textColor) {
        _textColor = textColor;
        _label.textColor = textColor;
    }
}

- (void)setFont:(UIFont *)font {
    if (_font != font) {
        _font = font;
        _label.font = font;
    }
}

@end
