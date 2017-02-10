//
//  ZGSFViewController.m
//  ZGShakeFeedBackDemo
//
//  Created by zhanggui on 2017/2/10.
//  Copyright © 2017年 zhanggui. All rights reserved.
//

#import "ZGSFViewController.h"
#import "ZGRemindView.h"
#import "ZGAlertView.h"
#import "EditImageViewController.h"
#import "AppDelegate.h"
@interface ZGSFViewController ()<ZGRemindViewDelegate>
@property (nonatomic,strong)ZGAlertView *alertView;
@property (nonatomic,strong)UIImage *screenImage;
@end

@implementation ZGSFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenShot:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    ZGRemindView *remindView = [[ZGRemindView alloc] initWithFrame:CGRectMake(0, 0, 255, 230)];
    remindView.delegate = self;
    _alertView = [[ZGAlertView alloc] initWihtContainerView:remindView];
    _alertView.viewCornerRadius = 10;
    remindView.remindCornerRadius = _alertView.viewCornerRadius;
    [_alertView show];

}
#pragma mark - screenShot action
- (void)screenShot:(NSNotification *)noti {
    if (_alertView) {
        [_alertView hide];
    }
    CGSize imgSize = [UIScreen mainScreen].bounds.size;
    UIGraphicsBeginImageContext(imgSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate; //获取app的appdelegate，便于取到当前的window用来截屏
    [app.window.layer renderInContext:context];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    _screenImage = img;
    UIGraphicsEndImageContext();
    if (img) {
        EditImageViewController *editImageVC = [[EditImageViewController alloc] init];
        editImageVC.sharedImage = _screenImage;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:editImageVC];
        [self presentViewController:nav animated:NO completion:nil];
    }
}

#pragma mark - ZGRemindViewDelegate
- (void)remindButtonClickWithIndex:(NSInteger)index {
    switch (index) {
        case 0: case 1:  //出问题啦  //吐槽
        {
            [_alertView hideWithCompleteWithBlock:^{
                [self screenShot:nil];
            }];  
        }
                       break;
        case 2:    //关闭
#warning unimplement
            break;
            
        case 3:  //走你
            [_alertView hide];
            break;
            
            
        default:
            break;
    }
}
@end
