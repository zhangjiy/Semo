//
//  JYWriteFeelingView.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYWriteFeelingView.h"
#import "JYWriteFeelingTableViewCell.h"

static NSString *const kJYWriteFeelingTableViewCell = @"JYWriteFeelingTableViewCell";

@interface JYWriteFeelingView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation JYWriteFeelingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
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
        [_tableView registerClass:[JYWriteFeelingTableViewCell class] forCellReuseIdentifier:kJYWriteFeelingTableViewCell];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 550;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYWriteFeelingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYWriteFeelingTableViewCell forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
