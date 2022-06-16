//
//  JYSettingViewController.m
//  Semo
//
//  Created by jiyang on 2022/4/26.
//

#import "JYSettingViewController.h"
#import <StoreKit/StoreKit.h>
#import <MessageUI/MessageUI.h>
#import "JYSettingListView.h"
#import "JYSettingModel.h"
#import "JYHelpCenterViewController.h"
#import "JYUserFeedBackViewController.h"
#import "JYAboutUsViewController.h"
#import "JYPrefixHeader.h"

@interface JYSettingViewController () <MFMailComposeViewControllerDelegate, JYSettingListViewDelegate>
@property (nonatomic, strong) JYSettingListView *settingListView;
@end

@implementation JYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self initSubviews];
}

- (void)initSubviews {
    [self.view addSubview:self.settingListView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _settingListView.size = CGSizeMake(self.view.width, self.view.height - NavigationBarHeight);
    _settingListView.top = NavigationBarHeight;
}

- (JYSettingListView *)settingListView {
    if (!_settingListView) {
        _settingListView = [[JYSettingListView alloc] initWithFrame:CGRectZero];
        _settingListView.backgroundColor = SMHomeBackgroudColor;
        _settingListView.delegate = self;
    }
    
    return _settingListView;
}

#pragma mark -- JYSettingListViewDelegate

- (void)settingListView:(JYSettingListView *)listView didSelectItem:(JYSettingModel *)item {
    if (item.type == JYSettingItemTypeComment) {
        [self gotoStoreComment];
    } else if (item.type == JYSettingItemTypeHelp) {
        [self gotoHelpCenter];
    } else if (item.type == JYSettingItemTypeFeedback) {
        [self gotoUserFeedBack];
    } else if (item.type == JYSettingItemTypeAbout) {
        [self gotoAboutUs];
    }
}

- (void)gotoStoreComment {
    NSString * nsStringToOpen = [NSString stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review", @"1573880428"];//替换为对应的APPID
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen] options:@{} completionHandler:^(BOOL success) {
        
    }];
}

- (void)gotoHelpCenter {
    JYHelpCenterViewController *vc = [[JYHelpCenterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoUserFeedBack {
    //判断用户是否已设置邮件账户
    if ([MFMailComposeViewController canSendMail]) {
        [self sendEmailAction]; // 调用发送邮件的代码
    } else{
        //给出提示,设备未开启邮件服务
        NSLog(@"");
    }
}

- (void)sendEmailAction {
    // 创建邮件发送界面
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    // 设置收件人
    [mailCompose setToRecipients:@[@"semord@outlook.com"]];
    // 设置抄送人
    // [mailCompose setCcRecipients:@[@"123456@qq.com"]];
    // 设置密送人
    // [mailCompose setBccRecipients:@[@"6789@163.com"]];
    // 设置邮件主题
    [mailCompose setSubject:@"设置邮件主题"];
    //设置邮件的正文内容
    NSString *emailContent = @"我是邮件内容";
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    // 如使用HTML格式，则为以下代码
    // [mailCompose setMessageBody:@"<html><body><p>Hello</p><p>World！</p></body></html>" isHTML:YES];
    //添加附件
    //            UIImage *image = [UIImage imageNamed:@"qq"];
    //            NSData *imageData = UIImagePNGRepresentation(image);
    //            [mailCompose addAttachmentData:imageData mimeType:@"" fileName:@"qq.png"];
    //            NSString *file = [[NSBundle mainBundle] pathForResource:@"EmptyPDF" ofType:@"pdf"];
    //            NSData *pdf = [NSData dataWithContentsOfFile:file];
    //            [mailCompose addAttachmentData:pdf mimeType:@"" fileName:@"EmptyPDF.pdf"];
    // 弹出邮件发送视图
    [self presentViewController:mailCompose animated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate的代理方法：
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled: 用户取消编辑");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: 用户保存邮件");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent: 用户点击发送");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail send errored: %@ : 用户尝试保存或发送邮件失败", [error localizedDescription]);
            break;
    }
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)gotoAboutUs {
    JYAboutUsViewController *vc = [[JYAboutUsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
