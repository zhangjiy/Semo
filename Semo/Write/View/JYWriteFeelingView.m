//
//  JYWriteFeelingView.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYWriteFeelingView.h"
#import "JYWriteFeelingBottomView.h"
#import "JYSealFeelingPassView.h"
#import "JYPrefixHeader.h"

@interface JYWriteFeelingView () <JYWriteFeelingBottomViewDelegate>
@property (nonatomic, strong) UIView *canvasView;
@property (nonatomic, strong) JYWriteFeelingBottomView * bottomView;
@property (nonatomic, strong) JYSealFeelingPassView * sealFeelingPassView;
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
    [self addSubview:self.canvasView];
    [self.canvasView addSubview:self.sealFeelingPassView];
    [self addSubview:self.bottomView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _canvasView.size = CGSizeMake(330, 165);
    _canvasView.top = 100;
    _canvasView.centerX = self.width / 2.f;
    
    _sealFeelingPassView.size = CGSizeMake(120, 120);
    _sealFeelingPassView.centerY = _canvasView.height / 2.f;
    _sealFeelingPassView.centerX = _canvasView.width / 2.f;
    
    _bottomView.size = CGSizeMake(self.width, JYWriteBottomHeight);
    _bottomView.bottom = self.height;
}

- (UIView *)canvasView {
    if (!_canvasView) {
        _canvasView = [[UIView alloc] initWithFrame:CGRectZero];
        _canvasView.backgroundColor = SMHomeBackgroudColor;
        _canvasView.layer.cornerRadius = 5.f;
    }
    return _canvasView;
}

- (JYWriteFeelingBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[JYWriteFeelingBottomView alloc] initWithFrame:CGRectZero];
        _bottomView.backgroundColor = [UIColor colorWithRed:223/225.f green:225/225.f blue:215/225.f alpha:1.f];
        _bottomView.delegate = self;
    }
    
    return _bottomView;
}

- (JYSealFeelingPassView *)sealFeelingPassView {
    if (!_sealFeelingPassView) {
        _sealFeelingPassView = [[JYSealFeelingPassView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        _sealFeelingPassView.hidden = YES;
    }
    
    return _sealFeelingPassView;
}

#pragma -- mark -- JYWriteFeelingBottomViewDelegate

- (void)writeFeelingBottomView:(JYWriteFeelingBottomView *)bottomView didSelectItem:(NSString *)item {
    self.sealFeelingPassView.hidden = NO;
    self.sealFeelingPassView.text = item;
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
