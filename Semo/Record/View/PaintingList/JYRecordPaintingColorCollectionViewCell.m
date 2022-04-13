//
//  JYRecordPaintingColorCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/4/13.
//

#import "JYRecordPaintingColorCollectionViewCell.h"
#import "JYGradientCircleView.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

#define TYColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface JYRecordPaintingColorCollectionViewCell ()
@property (nonatomic, strong) JYGradientCircleView *gradientCircleView;
@property (nonatomic, strong) UIView *colorView;
@end

@implementation JYRecordPaintingColorCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.gradientCircleView];
    [self.contentView addSubview:self.colorView];
    NSArray *colors = @[
        (id)TYColorFromRGB(0x349CF7),//浅蓝色
        (id)TYColorFromRGB(0xFE5858),//深橙色
        (id)TYColorFromRGB(0x72DC4F) //浅绿色,
    ];
    
    self.gradientCircleView.lineWidth = 3.f;
    self.gradientCircleView.startDegree = 0;
    self.gradientCircleView.endDegree = 360;
    self.gradientCircleView.isClockwise = YES;
    
    //设置渐变效果
    self.gradientCircleView.colors = colors;
    //设置
    self.gradientCircleView.progress = 1;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _colorView.size = CGSizeMake(self.contentView.width * 0.35, self.contentView.width * 0.35);
    _colorView.centerX = self.contentView.width / 2.f;
    _colorView.centerY = self.contentView.height / 2.f;
}

- (JYGradientCircleView *)gradientCircleView {
    if (!_gradientCircleView) {
        CGSize size = CGSizeMake(self.contentView.width * 0.75, self.contentView.height * 0.75);
        _gradientCircleView = [[JYGradientCircleView alloc] initWithFrame:CGRectMake((self.contentView.width - size.width) / 2.f, (self.contentView.height - size.height) / 2.f, size.width, size.height)];
    }
     
    return _gradientCircleView;
}

- (UIView *)colorView {
    if (!_colorView) {
        _colorView = [[UIView alloc] initWithFrame:CGRectZero];
        _colorView.backgroundColor = [UIColor whiteColor];
        _colorView.layer.masksToBounds = YES;
        _colorView.layer.cornerRadius = self.contentView.width * 0.35 / 2.f;
        _colorView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _colorView.layer.shadowOffset = CGSizeMake(0.5, 0.3);
        _colorView.layer.shadowOpacity = 0.1;
        _colorView.layer.shadowRadius = 0;
    }
    
    return _colorView;
}

@end
