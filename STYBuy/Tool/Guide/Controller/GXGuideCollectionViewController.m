//
//  GXGuideCollectionViewController.m
//  JiaFan
//
//  Created by apple on 2017/3/22.
//  Copyright © 2017年 杜顺. All rights reserved.
//

#import "GXGuideCollectionViewController.h"
#import "GXGuideCollectionViewCell.h"

@interface GXGuideCollectionViewController ()<GXGuideCollectionViewCellDelegate>

@end

@implementation GXGuideCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    // 创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // cell的大小
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    // 设置cell的行间距为0
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    // 设置水平滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[GXGuideCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 取消弹簧效果
    self.collectionView.bounces = NO;
    
    // 隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置允许分页
    self.collectionView.pagingEnabled = YES;
    
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 从缓存池取cell
    GXGuideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // 拼接图片名称
    NSString *imageName = [NSString stringWithFormat:@"guide%ld",indexPath.row + 1];
    cell.bgImageView.image = [UIImage imageNamed:imageName];
    cell.beginBtn.hidden = YES;
    //如果要在最后一页加一个开启的按钮 打开下面这句代码就ok
    cell.beginBtn.hidden = indexPath.row == 2 ? NO : YES;
    cell.delegate = self;
    return cell;
}


#pragma mark - 开启
- (void)beginAction:(UIButton *)sender
{
    //发送该通知切换根视图
    [STNotificationCenter postNotificationName:STSwitchRootViewControllerNotification object:nil userInfo:@{STSwitchRootViewControllerUserInfoKey:@(STSwitchRootViewControllerFromType_MainTab)}];
}

@end
