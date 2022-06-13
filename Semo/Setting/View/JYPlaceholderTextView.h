//
//  JYPlaceholderTextView.h
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYPlaceholderTextView : UITextView

@property (nonatomic, strong, nonnull) UILabel * placeHolderLabel;

@property (nonatomic, copy) NSString * placeholder;

@property (nonatomic, strong) UIColor * placeholderColor;

- (void)textChanged:(NSNotification * )notification;

@end

NS_ASSUME_NONNULL_END
