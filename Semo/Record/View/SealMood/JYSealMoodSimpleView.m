//
//  JYSealMoodSimpleView.m
//  Semo
//
//  Created by jiyang on 2022/3/29.
//

#import "JYSealMoodSimpleView.h"
#import "JYPrefixHeader.h"

@interface JYSealMoodSimpleView ()
@property (nonatomic, assign) ZHFigureDrawingType type;
@property (nonatomic, strong) ZHFigureDrawingLayer *drawingLayer;
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation JYSealMoodSimpleView

- (instancetype)initWithFrame:(CGRect)frame type:(ZHFigureDrawingType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self.layer addSublayer:self.drawingLayer];
    CGPoint point = CGPointMake(self.width, self.height);
    if (self.type == ZHFigureDrawingTypeRect) {
        point = CGPointMake((self.width - self.width / 30.f), (self.height - self.height / 30.f));
    } else if (self.type == ZHFigureDrawingTypeHexagon) {
        point = CGPointMake((self.width / 2.f + 0.5), self.height);
    }
    [self.drawingLayer movePathWithEndPoint:point];
    [self addSubview:self.textLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (ZHFigureDrawingLayer *)drawingLayer {
    if (!_drawingLayer){
        CGPoint point = CGPointZero;
        if (self.type == ZHFigureDrawingTypeRect) {
            point = CGPointMake(self.width / 30.f, self.height / 30.f);
        } else if (self.type == ZHFigureDrawingTypeHexagon) {
            point = CGPointMake((self.width / 2.f + 0.5), self.height / 2.f);
        }
        _drawingLayer = [ZHFigureDrawingLayer createLayerWithStartPoint:point type:self.type];
        _drawingLayer.paintSize = CGSizeMake(ScreenWidth, ScreenHeight);
        _drawingLayer.layerLineWidth = self.width / 30.f;
        _drawingLayer.lineColor = [UIColor blackColor];
    }
    
    return _drawingLayer;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        CGSize size = CGSizeMake(self.width * 0.68, self.width * 0.68);
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.width - size.width) / 2.f, (self.height - size.height) / 2.f, size.width, size.height)];
        _textLabel.font = [UIFont boldSystemFontOfSize:self.width * 0.42];
        _textLabel.textColor = SMSealBlueColor;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.hidden = YES;
    }
    return _textLabel;
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        self.textLabel.hidden = text.length > 0 ? NO:YES;
        self.textLabel.text = text;
    }
}

@end
