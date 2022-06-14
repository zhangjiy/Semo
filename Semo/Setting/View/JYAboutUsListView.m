//
//  JYAboutUsListView.m
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import "JYAboutUsListView.h"
#import "JYAboutUsTableViewCell.h"
#import "JYAboutUsModel.h"
#import "JYPrefixHeader.h"

static NSString *const kJYAboutUsTableViewCell = @"kJYAboutUsTableViewCell";

@interface JYAboutUsListView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray * settings;
@end

@implementation JYAboutUsListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        
        JYAboutUsModel *model0 = [[JYAboutUsModel alloc] init];
        model0.title = @"产品理念";
        model0.content = @"七情记录";
        model0.showBottomLine = YES;
        model0.cellHeight = 60;
        model0.contentColor = [UIColor lightGrayColor];
        
        JYAboutUsModel *model1 = [[JYAboutUsModel alloc] init];
        model1.title = @"出品团队";
        model1.content = @"七情由张吉阳个人制作出品。致力于倾听客户心声、持续创造价值，正在开心的探索无线可能。请期待我更多的作品，感谢支持。";
        model1.showBottomLine = YES;
        model1.cellHeight = 120;
        model1.contentColor = [UIColor grayColor];
        
        JYAboutUsModel *model2 = [[JYAboutUsModel alloc] init];
        model2.title = @"任何有意思的想法，欢迎随时召唤我";
        model2.content = @"xrmode";
        model2.showBottomLine = YES;
        model2.cellHeight = 60;
        model2.contentColor = [UIColor blueColor];
        
        self.settings = @[model0, model1, model2];
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
        [_tableView registerClass:[JYAboutUsTableViewCell class] forCellReuseIdentifier:kJYAboutUsTableViewCell];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settings.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYAboutUsModel *model = self.settings[indexPath.row];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYAboutUsModel *model = self.settings[indexPath.row];
    JYAboutUsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYAboutUsTableViewCell forIndexPath:indexPath];
    [cell updateViewWithModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end