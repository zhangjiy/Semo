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

@property (nonatomic, strong) NSArray * testmoods;
@end

@implementation JYDetailMoodListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        
        JYMoodModel *model0 = [[JYMoodModel alloc] init];
        model0.moodString = @"喜";
        model0.weak = @"星期一";
        model0.month = @"三月";
        model0.outline = @"啥也不说了，都是眼泪";
        JYMoodModel *model1 = [[JYMoodModel alloc] init];
        model1.moodString = @"怒";
        model1.weak = @"星期二";
        model1.month = @"三月";
        model1.outline = @"此时无声胜有声";
        JYMoodModel *model2 = [[JYMoodModel alloc] init];
        model2.moodString = @"忧";
        model2.weak = @"星期三";
        model2.month = @"三月";
        JYMoodModel *model3 = [[JYMoodModel alloc] init];
        model3.moodString = @"思";
        model3.weak = @"星期四";
        model3.month = @"三月";
        JYMoodModel *model4 = [[JYMoodModel alloc] init];
        model4.moodString = @"悲";
        model4.weak = @"星期五";
        model4.month = @"三月";
        JYMoodModel *model5 = [[JYMoodModel alloc] init];
        model5.moodString = @"恐";
        model5.weak = @"星期六";
        model5.month = @"三月";
        JYMoodModel *model6 = [[JYMoodModel alloc] init];
        model6.moodString = @"惧";
        model6.weak = @"星期日";
        model6.month = @"三月";
        
        self.testmoods = @[model0, model1, model2, model3, model4, model5, model6];
    }
    
    return self;
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
    return self.testmoods.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SMMoodListCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYDetailMoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYDetailMoodTableViewCell forIndexPath:indexPath];
    JYMoodModel *model = self.testmoods[indexPath.row];
    [cell updateViewWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
