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
        
//        JYSettingModel *model0 = [[JYSettingModel alloc] initWithType:JYSettingItemTypeSwitch];
//        model0.title = @"密码";
//        model0.icon = @"ico_setting_arrow.png";
//
//        JYSettingModel *modelLine0 = [[JYSettingModel alloc] initWithType:JYSettingItemTypeLine];
//        modelLine0.backgoundColor = [UIColor lightGrayColor];
        
//        JYSettingModel *model1 = [[JYSettingModel alloc] initWithType:JYSettingItemTypeArrow];
//        model1.title = @"导出日记";
//        model1.icon = @"ico_setting_arrow.png";
//
//        JYSettingModel *modelLine1 = [[JYSettingModel alloc] initWithType:JYSettingItemTypeLine];
//        modelLine1.backgoundColor = [UIColor lightGrayColor];
//
//        JYSettingModel *model2 = [[JYSettingModel alloc] initWithType:JYSettingItemTypeArrow];
//        model2.title = @"数据备份与恢复";
//        model2.icon = @"ico_setting_arrow.png";
        
        
//        JYSettingModel *modelSelction0 = [[JYSettingModel alloc] initWithType:JYSettingItemTypeSection];
//        modelSelction0.backgoundColor = [UIColor grayColor];
        
        
        JYSettingModel *model3 = [[JYSettingModel alloc] initWithType:JYSettingItemTypeComment];
        model3.title = @"好评鼓励";
        model3.icon = @"ico_setting_arrow.png";
        model3.showBottomLine = YES;
        model3.rightViewType = JYSettingRightViewTypeArrow;
        
        JYSettingModel *model4 = [[JYSettingModel alloc] initWithType:JYSettingItemTypeHelp];
        model4.title = @"帮助中心";
        model4.icon = @"ico_setting_arrow.png";
        model4.showBottomLine = YES;
        model4.rightViewType = JYSettingRightViewTypeArrow;
        
        JYSettingModel *model5 = [[JYSettingModel alloc] initWithType:JYSettingItemTypeFeedback];
        model5.title = @"意见反馈";
        model5.icon = @"ico_setting_arrow.png";
        model5.showBottomLine = YES;
        model5.rightViewType = JYSettingRightViewTypeArrow;
        
        JYSettingModel *model6 = [[JYSettingModel alloc] initWithType:JYSettingItemTypeAbout];
        model6.title = @"关于我们";
        model6.icon = @"ico_setting_arrow.png";
        model6.rightViewType = JYSettingRightViewTypeArrow;
        
        self.settings = @[model3, model4, model5, model6];
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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYSettingModel *model = self.settings[indexPath.row];
    JYSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYSettingTableViewCell forIndexPath:indexPath];
    [cell updateViewWithModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JYSettingModel *model = self.settings[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(settingListView:didSelectItem:)]) {
        [self.delegate settingListView:self didSelectItem:model];
    }
}

@end
