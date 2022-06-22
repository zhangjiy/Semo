//
//  AppDelegate.h
//  Semo
//
//  Created by jiyang on 2022/3/7.
//

#import <UIKit/UIKit.h>

#define AppDelegateAccessor ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@class CEReversibleAnimationController, CEBaseInteractionController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CEReversibleAnimationController *settingsAnimationController;
@property (strong, nonatomic) CEReversibleAnimationController *navigationControllerAnimationController;
@property (strong, nonatomic) CEBaseInteractionController *navigationControllerInteractionController;
@property (strong, nonatomic) CEBaseInteractionController *settingsInteractionController;

@end

