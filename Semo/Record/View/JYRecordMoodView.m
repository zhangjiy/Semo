//
//  JYRecordMoodView.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYRecordMoodView.h"
#import "JYPrefixHeader.h"

@interface JYRecordMoodView ()

@end

@implementation JYRecordMoodView

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
//        [_tableView registerClass:[JYRecordMoodTableViewCell class] forCellReuseIdentifier:kJYRecordMoodTableViewCell];
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
//    JYRecordMoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYRecordMoodTableViewCell forIndexPath:indexPath];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//}

@end
