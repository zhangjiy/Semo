//
//  JYSettingListView.m
//  Semo
//
//  Created by jiyang on 2022/6/10.
//

#import "JYSettingListView.h"
#import "JYSettingTableViewCell.h"
#import "JYSettingModel.h"
#import "JYPrefixHeader.h"

static NSString *const kJYSettingTableViewCell = @"kJYSettingTableViewCell";

@interface JYSettingListView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray * settings;
@end

@implementation JYSettingListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        
        JYSettingModel *model0 = [[JYSettingModel alloc] init];
        model0.title = @"密码";
        JYSettingModel *model1 = [[JYSettingModel alloc] init];
        model1.title = @"导出日记";
        JYSettingModel *model2 = [[JYSettingModel alloc] init];
        model2.title = @"数据备份与恢复";
        
        
        JYSettingModel *model3 = [[JYSettingModel alloc] init];
        model1.title = @"好评鼓励";
        JYSettingModel *model4 = [[JYSettingModel alloc] init];
        model2.title = @"帮助中心";
        JYSettingModel *model5 = [[JYSettingModel alloc] init];
        model3.title = @"意见反馈";
        JYSettingModel *model6 = [[JYSettingModel alloc] init];
        model4.title = @"关于我们";
        
        self.settings = @[model0, model1, model2, model3, model4, model5, model6];
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
        [_tableView registerClass:[JYSettingTableViewCell class] forCellReuseIdentifier:kJYSettingTableViewCell];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settings.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SMMoodListCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYSettingTableViewCell forIndexPath:indexPath];
    JYSettingModel *model = self.settings[indexPath.row];
    [cell updateViewWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
