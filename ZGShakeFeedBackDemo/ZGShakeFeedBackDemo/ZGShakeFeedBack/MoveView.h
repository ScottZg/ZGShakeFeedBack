//
//  MoveView.h
//  ScreenShot
//
//  Created by zhanggui on 2017/1/20.
//  Copyright © 2017年 shuquwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 拖动的view类
 */
@interface MoveView : UIView


/**
 设置要显示的内容

 @param image 用到的图片
 */
- (void)setShowContentWithImage:(UIImage *)image;

/**
 让键盘消失
 */
- (void)resignFirstRD;
@end
