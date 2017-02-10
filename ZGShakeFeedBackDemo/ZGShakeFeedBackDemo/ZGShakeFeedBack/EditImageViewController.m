//
//  EditImageViewController.m
//  ScreenShot
//
//  Created by zhanggui on 2017/1/19.
//  Copyright © 2017年 shuquwangluo. All rights reserved.
//

#import "EditImageViewController.h"
#import "Masonry.h"
#import "MyCollectionViewCell.h"
#import "MoveView.h"
@interface EditImageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)MoveView *moveView;
@end

@implementation EditImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"截图分享";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(closeVC)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(sharedAction)];
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self initConstarints];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)initConstarints {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@([UIScreen mainScreen].bounds.size.height-64*2));
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.imageView.mas_bottom).offset(5);
    }];
    [self.moveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@100);
        make.center.equalTo(self.imageView);
    }];
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.height.equalTo(@50);
//    }];
    
}
#pragma mark - 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell setContentWithImage:[UIImage imageNamed:@"reset"]];
    }else if(indexPath.row == 1){
        [cell setContentWithImage:[UIImage imageNamed:@"cloud"]];
    }else if (indexPath.row == 2) {
         [cell setContentWithImage:[UIImage imageNamed:@"cloud1"]];
    }else {
         [cell setContentWithImage:[UIImage imageNamed:@"you"]];
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击");

    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"board"]];
    if (indexPath.row == 0) {
        [self.moveView setHidden:YES];
        return;
    }
    
    [self.moveView setHidden:NO];
    [self.moveView setShowContentWithImage:cell.imageView.image];
}
#pragma mark - <#name#>
- (void)moveAction:(UIPanGestureRecognizer *)recognizer {
    NSLog(@"拖拽");
    [self.moveView resignFirstRD];
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint newCenter = CGPointMake(recognizer.view.center.x+ translation.x,
                                    recognizer.view.center.y + translation.y);//    限制屏幕范围：
    newCenter.y = MAX(recognizer.view.frame.size.height/2, newCenter.y);
    newCenter.y = MIN(self.imageView.frame.size.height - recognizer.view.frame.size.height/2,  newCenter.y);
    newCenter.x = MAX(recognizer.view.frame.size.width/2, newCenter.x);
    newCenter.x = MIN(self.imageView.frame.size.width - recognizer.view.frame.size.width/2,newCenter.x);
    recognizer.view.center = newCenter;
    [recognizer setTranslation:CGPointZero inView:self.imageView];
}
#pragma mark -
- (void)sharedAction {
    NSLog(@"shared");
    CGSize size = self.imageView.frame.size;
    UIGraphicsBeginImageContext(size);
    [self.imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
}
- (void)closeVC {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - lazy load
- (UIImageView *)imageView {
    if (!_imageView ) {
        _imageView = [[UIImageView alloc] initWithImage:_sharedImage];
        _imageView.userInteractionEnabled = YES;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.itemSize = CGSizeMake(50, 50);
        layout.minimumLineSpacing  = 10;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 2,2, 2);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
- (MoveView *)moveView {
    if (!_moveView) {
        _moveView = [[MoveView alloc] initWithFrame:CGRectZero];
        _moveView.userInteractionEnabled = YES;
        UIPanGestureRecognizer *get = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveAction:)];
        [_moveView addGestureRecognizer:get];
        [self.imageView addSubview:_moveView];
    }
    return _moveView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
