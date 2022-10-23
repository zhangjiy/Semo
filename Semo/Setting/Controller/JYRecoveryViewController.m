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
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
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
    
    _moodsTableView.size = CGSizeMake(self.view.width, self.view.height - 70 - 50 - (SafeAreaHeight + 20));
    _moodsTableView.top = _titleLabel.bottom + 20;
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
        NSString *newTime = @"0";
        NSInteger index = 0;
        for (NSURL *url in files) {
            NSString *file = url.absoluteString;
            NSString *fileName = [file lastPathComponent];
            if ([fileName containsString:@"semo"]) {
                NSArray *arr = [fileName componentsSeparatedByString:@"_"];
                JYICloudFileModel *fileModel = [[JYICloudFileModel alloc] init];
                fileModel.fileName = fileName;
                fileModel.moodCount = [arr.lastObject integerValue];
                fileModel.time = arr.firstObject;
                NSString *time = [fileModel.time stringByReplacingOccurrencesOfString:@"-" withString:@""];
                time = [time stringByReplacingOccurrencesOfString:@":" withString:@""];
                time = [time stringByReplacingOccurrencesOfString:@"+" withString:@""];
                if ([time integerValue] > [newTime integerValue]) {
                    newTime = time;
                    index = [files indexOfObject:url];
                    [mutableArray insertObject:fileModel atIndex:0];
                } else {
                    [mutableArray addObject:fileModel];
                }
            }
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (!self.selectedIndexPath) {
        [hud showAnimated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = NSLocalizedString(@"选择要恢复的数据", nil);;
        [hud hideAnimated:YES afterDelay:2.f];
        return;
    }
    JYICloudFileModel *fileModel = self.moods[self.selectedIndexPath.row];
    __weak typeof(self) weakSelf = self;
    [[iCloud sharedCloud] retrieveCloudDocumentWithName:fileModel.fileName completion:^(UIDocument *cloudDocument, NSData *documentData, NSError *error) {
        [hud showAnimated:YES];
        hud.mode = MBProgressHUDModeText;
        if (error) {
            hud.label.text = NSLocalizedString(@"失败", nil);
        } else {
            __strong typeof(self) strongSelf = weakSelf;
            NSError *arerror = nil;
            JYICloudModel * cloudModel = [NSKeyedUnarchiver unarchivedObjectOfClass:JYICloudModel.class fromData:documentData error:&arerror];
            [strongSelf recoverCloudData:cloudModel];
            hud.label.text = NSLocalizedString(@"成功, 需要重启应用", nil);;
        }
        [hud hideAnimated:YES afterDelay:2.f];
    }];
}

- (void)recoverCloudData:(JYICloudModel *)cloud {
    NSData *jsonData = [cloud.jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dict in array) {
        NSString *name = [dict valueForKey:@"BG_name"];
        NSArray *arr = [name componentsSeparatedByString:@"_"];
        if (arr.firstObject) {
            NSString *tableName = [NSString stringWithFormat:@"%@_%@", @"TableName", arr.firstObject];
            JYMonthMood *monthMood =  [BGTool objectFromJsonStringWithTableName:tableName class:[JYMonthMood class] valueDict:dict];
            [monthMood bg_saveOrUpdate];
        }
    }
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
    JYICloudFileModel *fileModel = self.moods[indexPath.row];
    if (self.selectedIndexPath && indexPath.row == self.selectedIndexPath.row) {
        fileModel.selected = YES;
    } else {
        fileModel.selected = NO;
    }
    fileModel.index = (indexPath.row + 1);
    cell.fileModel = fileModel;
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark = JYRecoverTableViewCellDelegate

- (void)recoverTableViewCell:(JYRecoverTableViewCell *)cell didSelectAction:(UIButton *)sender {
    NSIndexPath *indexPath = [self.moodsTableView indexPathForCell:cell];
    self.selectedIndexPath = indexPath;
    [self.moodsTableView reloadData];
}

@end

