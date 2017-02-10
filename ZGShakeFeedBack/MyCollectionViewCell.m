//
//  MyCollectionViewCell.m
//  ScreenShot
//
//  Created by zhanggui on 2017/1/20.
//  Copyright © 2017年 shuquwangluo. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "Masonry.h"
@interface MyCollectionViewCell ()


@end

@implementation MyCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        [self addSubview:_imageView];
    }
    return self;
}

#pragma mark - initWithContent
- (void)initWithContent  {
    self.imageView.frame = self.contentView.frame;
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top).offset(5);
//        make.left.equalTo(self.contentView.mas_left).offset(5);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
//        make.right.equalTo(self.contentView.mas_right).offset(-5);
//    }];
}
#pragma mark -
- (void)setContentWithImage:(UIImage *)image {
    _imageView.image = image;
}
#pragma mark - Lazy load
//- (UIImageView *)imageView {
//    if (!_imageView) {
//        _imageView = [[UIImageView alloc] init];
//        _imageView.backgroundColor = [UIColor yellowColor];
//        [self.contentView addSubview:_imageView];
//    }
//    return _imageView;
//}
@end
