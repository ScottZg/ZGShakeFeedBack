//
//  ZGRemindView.m
//  ZGShakeFeedBackDemo
//
//  Created by zhanggui on 2017/2/10.
//  Copyright © 2017年 zhanggui. All rights reserved.
//

#import "ZGRemindView.h"
#import "ZGShakeFeedBackConfig.h"
@interface ZGRemindView ()

/**
 main title
 */
@property (nonatomic,strong)UILabel *firstTitleLabel;

/**
 seconde title
 */
@property (nonatomic,strong)UILabel *secondTitleLabel;


@property (nonatomic,strong)NSArray *feedbackArr;
@end

@implementation ZGRemindView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUIWithFrame:frame];
    }
    return self;
}
#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)btn {
    if (self.delegate) {
        [self.delegate remindButtonClickWithIndex:btn.tag];
    }
}
#pragma mark - private method
- (void)initUIWithFrame:(CGRect)frame {
    self.firstTitleLabel.frame = CGRectMake(0, ZGTitleSpacing,frame.size.width, ZGTitleHeight);
    
    self.secondTitleLabel.frame = CGRectMake(0, ZGTitleSpacing*2+ZGTitleHeight,frame.size.width, ZGTitleHeight);


    for(int i=0;i<self.feedbackArr.count;i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:self.feedbackArr[i] forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(0,ZGTitleSpacing*3+ZGTitleHeight*2+i*44, frame.size.width, 44)];
        [btn setTag:i];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:ZGTitleFontSize]];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self addSubview:btn];
    }
}

#pragma mark - lazy load
- (UILabel *)firstTitleLabel {
    if (!_firstTitleLabel) {
        _firstTitleLabel = [[UILabel alloc] init];
        _firstTitleLabel.text = ZGSFirstTitle;
        _firstTitleLabel.font = [UIFont boldSystemFontOfSize:ZGTitleFontSize];
        _firstTitleLabel.textAlignment = NSTextAlignmentCenter;
        _firstTitleLabel.numberOfLines = 0;
        [self addSubview:_firstTitleLabel];
    }
    return _firstTitleLabel;
}
- (UILabel *)secondTitleLabel {
    if (!_secondTitleLabel) {
         _secondTitleLabel = [[UILabel alloc] init];
        _secondTitleLabel.text = ZGSSecondTitle;
        _secondTitleLabel.font = [UIFont systemFontOfSize:ZGTitleFontSize];
        _secondTitleLabel.textAlignment = NSTextAlignmentCenter;
        _secondTitleLabel.numberOfLines = 0;
        [self addSubview:_secondTitleLabel];
    }
    return _secondTitleLabel;
}
- (NSArray *)feedbackArr {
    if (!_feedbackArr) {
        _feedbackArr = @[@"出问题啦",@"吐槽",@"关闭摇一摇反馈",@"走你"];
    }
    return _feedbackArr;
}
@end
