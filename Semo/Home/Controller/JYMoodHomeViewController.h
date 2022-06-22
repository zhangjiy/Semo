//
//  JYHomeViewController.h
//  Semo
//
//  Created by jiyang on 2022/3/7.
//

#import <UIKit/UIKit.h>
#import "JYHomeViewControllerProtocol.h"
#import "CEReversibleAnimationController.h"

@interface JYMoodHomeViewController : UIViewController <JYHomeViewControllerProtocol>

@property (nonatomic, strong) CEReversibleAnimationController *settingsAnimationController;

@end

