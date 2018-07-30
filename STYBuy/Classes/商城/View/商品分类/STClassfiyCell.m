//
//  STClassfiyCell.m
//  STYBuy
//
//  Created by 高欣 on 2018/7/8.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STClassfiyCell.h"
#import "STShopClassifyModel.h"
//头部collectionviewCell
@interface GXMyOrderHeadCollectionCell :UICollectionViewCell

/**
 图标
 */
@property (nonatomic, strong) UIImageView *iconImg;

/**
 名字
 */
@property (nonatomic, strong) UILabel *nameLabel;


@end

@implementation GXMyOrderHeadCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.nameLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.centerX.equalTo(self.contentView);
        make.size.equalTo(@40);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.iconImg.mas_bottom).offset(5);
    }];
}


- (UIImageView *)iconImg
{
    if (_iconImg == nil) {
        _iconImg = [[UIImageView alloc]init];
    }
    return _iconImg;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel labelWithColor:Text_Gary_Color font:TextLittleTitleFont alignment:NSTextAlignmentCenter title:@""];
    }
    return _nameLabel;
}



@end




@interface STClassfiyCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end


@implementation STClassfiyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.layout = [[UICollectionViewFlowLayout alloc]init];
    self.layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = self.backgroundColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[GXMyOrderHeadCollectionCell class] forCellWithReuseIdentifier:@"collcell"];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}

- (void)setInfoArr:(NSArray *)infoArr
{
    _infoArr = infoArr;
    [self.collectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.infoArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXMyOrderHeadCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collcell" forIndexPath:indexPath];
    STShopClassifyModel * model = self.infoArr[indexPath.item];
    [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    cell.nameLabel.text = model.title;
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth / (self.infoArr.count / 2), self.bounds.size.height/2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}



@end
