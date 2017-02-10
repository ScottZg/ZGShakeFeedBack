//
//  ZGAlertView.m
//  ZGAlertViewDemo
//
//  Created by zhanggui on 2017/2/8.
//  Copyright © 2017年 zhanggui. All rights reserved.
//

#import "ZGAlertView.h"

@interface ZGAlertView ()

/**
 back view
 */
@property (nonatomic,strong)UIView *backView;
//@property (nonatomic,strong)UIButton *closeButton;




/**
 motion manager
 */
@property (nonatomic,strong)UIDynamicAnimator *animator;
@end



@implementation ZGAlertView


- (instancetype)initWihtContainerView:(UIView *)containerView {
    self = [super init];
    if (self) {
        self.containerView = containerView;
    }
    return self;
}
- (void)show {
    self.backView = nil;
    if (_containerView) {
        CGRect rect = _containerView.frame;
        self.frame = CGRectMake(kZGScreenWidth/2-rect.size.width/2,-rect.size.height ,rect.size.width,rect.size.height);
        
        [self addSubview:_containerView];
    }else {
        self.frame = CGRectMake(kZGScreenWidth/2-kZGDefaultViewWidth/2,0,kZGDefaultViewWidth,kZGDefaultViewHeight);
    }
    self.layer.cornerRadius  = _viewCornerRadius == 0 ? kZGDefaultViewCornerRadius : _viewCornerRadius;
    self.backgroundColor = _alertBackViewColor == nil ? kZGDefaultViewBackgroundColor : _alertBackViewColor;
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    
    [self.superview insertSubview:self.backView belowSubview:self];
    //method 1
    CGRect oldFrame = self.frame;
    CGPoint p = [self.superview center];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(oldFrame.origin.x, p.y-oldFrame.size.height/2+10, oldFrame.size.width, oldFrame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect oldFrame = self.frame;
            self.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y-10, oldFrame.size.width, oldFrame.size.height);
        } completion:nil];
    }];
    
    
    
//    //method 2
//    CGPoint p = [self.superview center];
//     _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
//    
//    //dynmic
//    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self snapToPoint:p];
//    snap.damping = 0.5;
//    //restinct
//    UIDynamicItemBehavior *behavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self]];
//    behavior.allowsRotation = NO;
//
//    //add
//    [_animator addBehavior:behavior];
//    [_animator addBehavior:snap];
}
- (void)hideWithCompleteWithBlock:(dispatch_block_t)block {
    //    //method 1
    [UIView animateWithDuration:0.2 animations:^{
        CGRect oldFrame = self.frame;
        self.frame = CGRectMake(oldFrame.origin.x, kZGScreenHeight, oldFrame.size.width, oldFrame.size.height);
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        [self removeFromSuperview];
        if (block) {
            block();
        }
    }];
    //    //method 2
    //   _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    //    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    //    [_animator addBehavior:gravity];
    //    CGVector gravityDirection = {0,1};
    //    [gravity setGravityDirection:gravityDirection];
    //    [gravity addItem:self];
    //    [gravity setMagnitude:10.0f];
    //    [UIView animateWithDuration:0.5 animations:^{
    //        self.backView.alpha = 0.0;
    //    } completion:^(BOOL finished) {
    //        [self.backView removeFromSuperview];
    //        [self removeFromSuperview];
//            if (block) {
//                block();
//            }

    //    }];

}
- (void)hide {
//    //method 1
    [UIView animateWithDuration:0.2 animations:^{
        CGRect oldFrame = self.frame;
        self.frame = CGRectMake(oldFrame.origin.x, kZGScreenHeight, oldFrame.size.width, oldFrame.size.height);
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        [self removeFromSuperview];
    }];
//    //method 2
//   _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
//    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
//    [_animator addBehavior:gravity];
//    CGVector gravityDirection = {0,1};
//    [gravity setGravityDirection:gravityDirection];
//    [gravity addItem:self];
//    [gravity setMagnitude:10.0f];
//    [UIView animateWithDuration:0.5 animations:^{
//        self.backView.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        [self.backView removeFromSuperview];
//        [self removeFromSuperview];
//    }];
}
#pragma mark - lazy load
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.superview.bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_backView addGestureRecognizer:tap];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.5;
    }
    return _backView;
}
@end
