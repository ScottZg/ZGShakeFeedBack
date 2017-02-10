//
//  ZGAlertView.h
//  ZGAlertViewDemo
//
//  Created by zhanggui on 2017/2/8.
//  Copyright © 2017年 zhanggui. All rights reserved.
//iOS 7 and later

#import <UIKit/UIKit.h>

#define kZGScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kZGScreenHeight               [UIScreen mainScreen].bounds.size.height
#define kZGDefaultViewBackgroundColor [UIColor whiteColor]
const static CGFloat kZGDefaultViewHeight  = 80;  //default view height
const static CGFloat kZGDefaultViewWidth    = 200;   //default view width

const static CGFloat kZGDefaultCloseButtonWidth  = 47;  //default close button width
const static CGFloat kZGDefaultCloseButtonHeight  = 22;  //default close button height

const static CGFloat kZGDefaultViewCornerRadius  = 4;  //default cornerRadius value
@interface ZGAlertView : UIView


/**
 init alert view

 @param containerView container view
 @return alert view
 */
- (instancetype)initWihtContainerView:(UIView *)containerView;
/**
 show alert view
 */
- (void)show;

/**
 hide alert view
 */
- (void)hide;

/**
 hide aler view

 @param block hide finish block
 */
- (void)hideWithCompleteWithBlock:(dispatch_block_t)block;
/**
 user custom view
 the containerView's origin.x and origin.y should set as 0
 */
@property (nonatomic,strong)UIView *containerView;


/**
 corner radius value
 */
@property (nonatomic,assign)CGFloat viewCornerRadius;


/**
 alert view background color
 */
@property (nonatomic,strong)UIColor *alertBackViewColor;



@end
