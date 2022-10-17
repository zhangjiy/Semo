//
//  JYRecoveryViewController.m
//  Semo
//
//  Created by jiyang on 2022/10/11.
//

#import "JYRecoveryViewController.h"
#import "JYRecoverTableViewCell.h"
#import "iCloud.h"
#import "JYICloudModel.h"
#import "JYMonthMood.h"
#import "JYICloudFileModel.h"
#import "MBProgressHUD.h"
#import "JYPrefixHeader.h"

static NSString *const kJYRecoveryTableViewCell = @"kJYRecoveryTableViewCell";

@interface JYRecoveryViewController () <UITableViewDelegate, UITableViewDataSource, JYRecoverTableViewCellDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *recoverButton;
@property (nonatomic, strong) UITableView *moodsTableView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) NSArray *moods;
@end

@implementation JYRecoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SMHomeBackgroudColor;
    [self initSubViews];
    [self fetchData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [_titleLabel sizeToFit];
    _titleLabel.centerX = self.view.width / 2.f;
    _titleLabel.top = 20.f;
    
    _recoverButton.size = CGSizeMake(50, 50);
    _recoverButton.centerX = _titleLabel.centerY;
    _recoverButton.right = self.view.width - 20;
    
    _closeButton.size = CGSizeMake(50, 50);
    _closeButton.centerX = self.view.width / 2.f;
    _closeButton.bottom = self.view.height - (SafeAreaHeight + 20);
    
    _moodsTableView.size = CGSizeMake(self.view.width, self.view.height - 70 - 20 - _closeButton.top);
    _moodsTableView.centerX = self.view.width / 2.f;
}

- (void)initSubViews {
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.recoverButton];
    [self.view addSubview:self.moodsTableView];
    [self.view addSubview:self.closeButton];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = NSLocalizedString(@"备份与恢复", nil);
    }
    
    return _titleLabel;
}

- (void)fetchData {
    if ([[iCloud sharedCloud] checkCloudAvailability]) {
        NSArray *files = [[iCloud sharedCloud] listCloudFiles];
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSString *file in files) {
            NSString *dot = [file stringByDeletingLastPathComponent];
            if ([dot containsString:@"semo"]) {
                NSString *tildeInPath = [file stringByAbbreviatingWithTildeInPath];
                NSArray *arr = [tildeInPath componentsSeparatedByString:@","];
                JYICloudFileModel *fileModel = [[JYICloudFileModel alloc] init];
                fileModel.name = arr.firstObject;
                fileModel.moodCount = [[arr objectAtIndex:1] integerValue];
                [mutableArray addObject:fileModel];
            }
//            [[iCloud sharedCloud] retrieveCloudDocumentWithName:@"Name10.ext" completion:^(UIDocument *cloudDocument, NSData *documentData, NSError *error) {
//                NSError *arerror = nil;
//                JYICloudModel *cloudModel = [NSKeyedUnarchiver unarchivedObjectOfClass:JYICloudModel.class fromData:documentData error:&arerror];
//                [hud hideAnimated:YES];
//            }];
        }
        self.moods = [mutableArray copy];
        [self.moodsTableView reloadData];
    } else {
        MBProgressHUD *hud = [[MBProgressHUD alloc] init];
        [hud showAnimated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = NSLocalizedString(@"iCloud 不可用", nil);
        [hud hideAnimated:YES afterDelay:2.f];
    }
}

- (UIButton *)recoverButton {
    if (!_recoverButton) {
        _recoverButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_recoverButton setTitleColor:[UIColor colorWithRed:218/255.f green:88/255.f blue:78/255.f alpha:1.f] forState:UIControlStateNormal];
        _recoverButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_recoverButton setTitle:NSLocalizedString(@"恢复", nil) forState:UIControlStateNormal];
        [_recoverButton addTarget:self action:@selector(recoverButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _recoverButton;
}

- (UITableView *)moodsTableView {
    if (!_moodsTableView) {
        _moodsTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _moodsTableView.dataSource = self;
        _moodsTableView.delegate = self;
        _moodsTableView.showsVerticalScrollIndicator = NO;
        _moodsTableView.backgroundColor = [UIColor clearColor];
        [_moodsTableView registerClass:[JYRecoverTableViewCell class] forCellReuseIdentifier:kJYRecoveryTableViewCell];
    }
    return _moodsTableView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

- (void)recoverButtonAction:(UIButton *)sender {
    
}

- (void)closeButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.moods.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYRecoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYRecoveryTableViewCell forIndexPath:indexPath];
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark = JYRecoverTableViewCellDelegate

- (void)recoverTableViewCell:(JYRecoverTableViewCell *)cell didSelectAction:(UIButton *)sender {
    
}

@end
