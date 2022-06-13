//
//  JYHelpCenterListView.m
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import "JYHelpCenterListView.h"
#import "JYHelpCenterTableViewCell.h"
#import "JYHelpCenterModel.h"
#import "JYPrefixHeader.h"

static NSString *const kJYHelpCenterTableViewCell = @"kJYHelpCenterTableViewCell";

@interface JYHelpCenterListView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray * settings;
@end

@implementation JYHelpCenterListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        
        JYHelpCenterModel *model0 = [[JYHelpCenterModel alloc] init];
        model0.title = @"你能看到我的心情吗？";
        model0.icon = @"ico_setting_arrow.png";
        model0.showBottomLine = YES;
        
        JYHelpCenterModel *model1 = [[JYHelpCenterModel alloc] init];
        model1.title = @"更换手机或者卸载APP后我的数据还在吗？";
        model1.icon = @"ico_setting_arrow.png";
        model1.showBottomLine = YES;
        
        JYHelpCenterModel *model2 = [[JYHelpCenterModel alloc] init];
        model2.title = @"我可以一天记录多个心情吗？";
        model2.icon = @"ico_setting_arrow.png";
        model2.showBottomLine = YES;
        
        JYHelpCenterModel *model3 = [[JYHelpCenterModel alloc] init];
        model3.title = @"我可以自己创作心情吗？";
        model3.icon = @"ico_setting_arrow.png";
        model3.showBottomLine = YES;
        
        self.settings = @[model0, model1, model2, model3];
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
        [_tableView registerClass:[JYHelpCenterTableViewCell class] forCellReuseIdentifier:kJYHelpCenterTableViewCell];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settings.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYHelpCenterModel *model = self.settings[indexPath.row];
    model.lineMark = [NSString stringWithFormat:@"%ld%@", indexPath.row, @"."];
    JYHelpCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYHelpCenterTableViewCell forIndexPath:indexPath];
    [cell updateViewWithModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JYHelpCenterModel *model = self.settings[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(helpCenterListView:didSelectItem:)]) {
        [self.delegate helpCenterListView:self didSelectItem:model];
    }
}

@end

