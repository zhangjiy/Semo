//
//  JYWriteFeelingView.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYWriteFeelingView.h"
#import "JYPrefixHeader.h"

@interface JYWriteFeelingView ()

@end

@implementation JYWriteFeelingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    
    return self;
}

//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.tableFooterView = [[UIView alloc] init];
//        [_tableView registerClass:[JYWriteFeelingTableViewCell class] forCellReuseIdentifier:kJYWriteFeelingTableViewCell];
//    }
//    return _tableView;
//}

//#pragma mark - UITableViewDataSource & UITableViewDelegate
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 550;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    JYWriteFeelingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYWriteFeelingTableViewCell forIndexPath:indexPath];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//}

@end
