//
//  JYFeelingListView.m
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import "JYFeelingListView.h"
#import "JYFeelingTableViewCell.h"
#import "JYFeelingModel.h"
#import "JYPrefixHeader.h"

static NSString *const kJYFeelingTableViewCell = @"kJYFeelingTableViewCell";

@interface JYFeelingListView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray * testFeelings;
@end

@implementation JYFeelingListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        
        JYFeelingModel *model0 = [[JYFeelingModel alloc] init];
        model0.feelingString = @"喜";
        model0.weak = @"星期一";
        model0.month = @"三月";
        model0.outline = @"啥也不说了，都是眼泪";
        JYFeelingModel *model1 = [[JYFeelingModel alloc] init];
        model1.feelingString = @"怒";
        model1.weak = @"星期二";
        model1.month = @"三月";
        model1.outline = @"此时无声胜有声";
        JYFeelingModel *model2 = [[JYFeelingModel alloc] init];
        model2.feelingString = @"忧";
        model2.weak = @"星期三";
        model2.month = @"三月";
        JYFeelingModel *model3 = [[JYFeelingModel alloc] init];
        model3.feelingString = @"思";
        model3.weak = @"星期四";
        model3.month = @"三月";
        JYFeelingModel *model4 = [[JYFeelingModel alloc] init];
        model4.feelingString = @"悲";
        model4.weak = @"星期五";
        model4.month = @"三月";
        JYFeelingModel *model5 = [[JYFeelingModel alloc] init];
        model5.feelingString = @"恐";
        model5.weak = @"星期六";
        model5.month = @"三月";
        JYFeelingModel *model6 = [[JYFeelingModel alloc] init];
        model6.feelingString = @"惧";
        model6.weak = @"星期日";
        model6.month = @"三月";
        
        self.testFeelings = @[model0, model1, model2, model3, model4, model5, model6];
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
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[JYFeelingTableViewCell class] forCellReuseIdentifier:kJYFeelingTableViewCell];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.testFeelings.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SMFeelingListCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYFeelingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYFeelingTableViewCell forIndexPath:indexPath];
    JYFeelingModel *model = self.testFeelings[indexPath.row];
    [cell updateViewWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
