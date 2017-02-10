//
//  MyCollectionViewCell.h
//  ScreenShot
//
//  Created by zhanggui on 2017/1/20.
//  Copyright © 2017年 shuquwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 选择图片的collection cell
 */
@interface MyCollectionViewCell : UICollectionViewCell


/**
 cell中的图片
 */
@property (nonatomic,strong)UIImageView *imageView;

/**
 设置显示内容的图片

 @param image 用到的图片
 */
- (void)setContentWithImage:(UIImage *)image;
@end
