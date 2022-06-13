//
//  JYPhotoCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import "JYPhotoCollectionViewCell.h"

@implementation JYPhotoCollectionViewCell
//懒加载创建数据
- (UIImageView *)photoV {
    if (_photoV == nil) {
        self.photoV = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _photoV;
}

//创建自定义cell时调用该方法
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.photoV];
    }
    return self;
}

@end
