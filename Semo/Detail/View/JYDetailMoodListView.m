//
//  JYDetailMoodListView.m
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import "JYDetailMoodListView.h"
#import "JYDetailMoodTableViewCell.h"
#import "JYMoodModel.h"
#import "JYPrefixHeader.h"

static NSString *const kJYDetailMoodTableViewCell = @"kJYDetailMoodTableViewCell";

@interface JYDetailMoodListView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation JYDetailMoodListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)setDayMood:(JYDayMood *)dayMood {
    if (_dayMood != dayMood) {
        _dayMood = dayMood;
    }
}

- (void)initSubviews {
    [self addSubview:self.tableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _tableView.frame = self.bounds;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[JYDetailMoodTableViewCell class] forCellReuseIdentifier:kJYDetailMoodTableViewCell];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dayMood.moods.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SMMoodListCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYDetailMoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYDetailMoodTableViewCell forIndexPath:indexPath];
    JYMood *mood = self.dayMood.moods[indexPath.row];
    cell.mood = mood;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    JYMood *mood = self.dayMood.moods[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(detailMoodListView:didSelectItem:)]) {
        [self.delegate detailMoodListView:self didSelectItem:mood];
    }
}

@end
