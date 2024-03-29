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
        
        JYAboutUsModel *model0 = [[JYAboutUsModel alloc] initWithType:JYAboutUsItemTypeNone];
        model0.title = NSLocalizedString(@"产品理念", nil);
        model0.content = NSLocalizedString(@"简单有趣的记录你的心情", nil);
        model0.showBottomLine = YES;
        model0.contentColor = [UIColor blackColor];
        
        JYAboutUsModel *model1 = [[JYAboutUsModel alloc] initWithType:JYAboutUsItemTypeNone];
        model1.title = NSLocalizedString(@"出品团队", nil);
        model1.content = NSLocalizedString(@"七情由张吉阳个人制作出品。致力于倾听客户心声、持续创造价值，正在开心的探索无线可能。请期待我更多的作品，感谢支持。", nil);
        model1.showBottomLine = YES;
        model1.contentColor = [UIColor blackColor];
        
        JYAboutUsModel *model2 = [[JYAboutUsModel alloc] initWithType:JYAboutUsItemTypeContact];
        model2.title = NSLocalizedString(@"任何有意思的想法，欢迎随时召唤我", nil);
        model2.content = @"semord@outlook.com";
        model2.showBottomLine = YES;
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
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 100;
        _tableView.backgroundColor = [UIColor clearColor];
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
    CGFloat titileHeight = [model.title wbt_sizeWithFont:[UIFont systemFontOfSize:16] forWidth:(self.width - 15 * 2)].height;
    
    CGFloat contentHeight = [model.content wbt_sizeWithFont:[UIFont systemFontOfSize:14] forWidth:(self.width - 15 * 2)].height;
    return 10 + titileHeight + 5 + contentHeight + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYAboutUsModel *model = self.settings[indexPath.row];
    JYAboutUsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYAboutUsTableViewCell forIndexPath:indexPath];
    cell.aboutUsModel = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JYAboutUsModel *model = self.settings[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(aboutUsListView:didSelectItem:)]) {
        [self.delegate aboutUsListView:self didSelectItem:model];
    }
}

@end
