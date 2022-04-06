//
//  JYRecordMoodTableViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYRecordMoodTableViewCell.h"

@interface JYRecordMoodTableViewCell ()

@end

@implementation JYRecordMoodTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
