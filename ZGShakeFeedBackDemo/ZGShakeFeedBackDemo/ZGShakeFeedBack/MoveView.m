//
//  MoveView.m
//  ScreenShot
//
//  Created by zhanggui on 2017/1/20.
//  Copyright © 2017年 shuquwangluo. All rights reserved.
//

#import "MoveView.h"
#import "Masonry.h"
@interface MoveView ()

@property (nonatomic,strong)UITextView *textField;
@property (nonatomic,strong)UIImageView *imgView;
@end

@implementation MoveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1;
        [self initConstarints];
    }
    return self;
}
- (void)initConstarints {
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@40);
        
    }];
}
#pragma mark - method
- (void)setShowContentWithImage:(UIImage *)image {
    self.backgroundColor = [UIColor colorWithPatternImage:image];
}
- (void)resignFirstRD {
    [self.textField resignFirstResponder];
}
#pragma mark - lazy load
- (UITextView *)textField {
    if (!_textField) {
        _textField = [[UITextView alloc] init];
        _textField.backgroundColor = [UIColor clearColor];
        [_textField sizeToFit];
        [self addSubview:_textField];
    }
    return _textField;
}
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.layer.borderWidth = 1;
        _imgView.layer.borderColor = [UIColor blackColor].CGColor;
        _imgView.userInteractionEnabled = YES;
        [self addSubview:_imgView];
    }
    return _imgView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
