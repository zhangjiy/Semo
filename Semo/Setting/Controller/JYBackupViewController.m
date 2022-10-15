//
//  JYBackupViewController.m
//  Semo
//
//  Created by jiyang on 2022/10/11.
//

#import "JYBackupViewController.h"
#import "JYRecoveryViewController.h"
#import "JYPrefixHeader.h"

@interface JYBackupViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backupButton;
@property (nonatomic, strong) UIButton *recoverButton;
@property (nonatomic, strong) UILabel *backupTimeLabel;
@property (nonatomic, strong) UIButton *closeButton;
@end

@implementation JYBackupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SMHomeBackgroudColor;
    [self initSubViews];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [_titleLabel sizeToFit];
    _titleLabel.centerX = self.view.width / 2.f;
    _titleLabel.top = 20.f;
    
    _backupButton.size = CGSizeMake(300, 50);
    _backupButton.centerX = self.view.width / 2.f;
    _backupButton.top = 200;
    
    _recoverButton.size = CGSizeMake(300, 50);
    _recoverButton.centerX = self.view.width / 2.f;
    _recoverButton.top = _backupButton.bottom + 20.f;
    
    [_backupTimeLabel sizeToFit];
    _backupTimeLabel.centerX = self.view.width / 2.f;
    _backupTimeLabel.top = _recoverButton.bottom + 20.f;
    
    _closeButton.size = CGSizeMake(50, 50);
    _closeButton.centerX = self.view.width / 2.f;
    _closeButton.bottom = self.view.height - (SafeAreaHeight + 20);
}

- (void)initSubViews {
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.backupButton];
    [self.view addSubview:self.recoverButton];
    [self.view addSubview:self.backupTimeLabel];
    [self.view addSubview:self.closeButton];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = NSLocalizedString(@"备份与恢复", nil);
    }
    
    return _titleLabel;
}

- (UIButton *)backupButton {
    if (!_backupButton) {
        _backupButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _backupButton.backgroundColor = [UIColor colorWithRed:218/255.f green:88/255.f blue:78/255.f alpha:1.f];
        [_backupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _backupButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_backupButton setTitle:NSLocalizedString(@"将本机数据备份到iCloud", nil) forState:UIControlStateNormal];
        _backupButton.layer.masksToBounds = YES;
        _backupButton.layer.cornerRadius = 5.f;
        [_backupButton addTarget:self action:@selector(backupButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backupButton;
}

- (UIButton *)recoverButton {
    if (!_recoverButton) {
        _recoverButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _recoverButton.backgroundColor = [UIColor colorWithRed:218/255.f green:88/255.f blue:78/255.f alpha:1.f];
        [_recoverButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_recoverButton setTitle:NSLocalizedString(@"从iCloud恢复数据到本机", nil) forState:UIControlStateNormal];
        _recoverButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _recoverButton.layer.masksToBounds = YES;
        _recoverButton.layer.cornerRadius = 5.f;
        [_recoverButton addTarget:self action:@selector(recoverButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _recoverButton;
}

- (UILabel *)backupTimeLabel {
    if (!_backupTimeLabel) {
        _backupTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    
    return _backupTimeLabel;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

- (void)backupButtonAction:(UIButton *)sender {
    
}

- (void)recoverButtonAction:(UIButton *)sender {
    JYRecoveryViewController *vc = [[JYRecoveryViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)closeButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
 
@end
