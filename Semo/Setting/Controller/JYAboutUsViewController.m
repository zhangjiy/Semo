//
//  JYAboutUsViewController.m
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import "JYAboutUsViewController.h"
#import <MessageUI/MessageUI.h>
#import "JYAboutUsListView.h"
#import "JYAboutUsModel.h"
#import "JYPrefixHeader.h"

@interface JYAboutUsViewController () <MFMailComposeViewControllerDelegate, JYAboutUsListViewDelegate>
@property (nonatomic, strong) JYAboutUsListView *aboutUsListView;
@end

@implementation JYAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self initSubviews];
}

- (void)initSubviews {
    [self.view addSubview:self.aboutUsListView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _aboutUsListView.size = CGSizeMake(self.view.width, self.view.height - NavigationBarHeight);
    _aboutUsListView.top = NavigationBarHeight;
}

- (JYAboutUsListView *)aboutUsListView {
    if (!_aboutUsListView) {
        _aboutUsListView = [[JYAboutUsListView alloc] initWithFrame:CGRectZero];
        _aboutUsListView.backgroundColor = SMHomeBackgroudColor;
        _aboutUsListView.delegate = self;
    }
    
    return _aboutUsListView;
}

#pragma mark -- JYAboutUsListViewDelegate

- (void)aboutUsListView:(JYAboutUsListView *)listView didSelectItem:(JYAboutUsModel *)item {
    if (item.type == JYAboutUsItemTypeContact) {
        [self gotoEmailAction];
    }
}

- (void)gotoEmailAction {
    if ([MFMailComposeViewController canSendMail]) {
        [self sendEmailAction]; // 调用发送邮件的代码
    } else{
    }
}

- (void)sendEmailAction {
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    [mailCompose setMailComposeDelegate:self];
    [mailCompose setToRecipients:@[@"semord@outlook.com"]];
    [mailCompose setSubject:@"设置邮件主题"];
    NSString *emailContent = @"我是邮件内容";
    [mailCompose setMessageBody:emailContent isHTML:NO];
    [self presentViewController:mailCompose animated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate的代理方法：
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            break;
    }
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
