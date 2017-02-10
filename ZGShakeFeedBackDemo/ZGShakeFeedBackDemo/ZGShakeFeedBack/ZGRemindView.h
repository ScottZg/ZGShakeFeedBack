//
//  ZGRemindView.h
//  ZGShakeFeedBackDemo
//
//  Created by zhanggui on 2017/2/10.
//  Copyright © 2017年 zhanggui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZGRemindViewDelegate <NSObject>

/**
 click action

 @param index tag
 */
- (void)remindButtonClickWithIndex:(NSInteger)index;

@end

@interface ZGRemindView : UIView

@property (nonatomic,weak)id<ZGRemindViewDelegate> delegate;
/**
 cornerRadius
 */
@property (nonatomic,assign)CGFloat remindCornerRadius;
@end
