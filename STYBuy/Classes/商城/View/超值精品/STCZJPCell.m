//
//  STCZJPCell.m
//  STYBuy
//
//  Created by 高欣 on 2018/7/8.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STCZJPCell.h"
#import "STShopAdlistModel.h"
@interface STCZJPCell()

@property (nonatomic,strong) UIImageView *img1;
@property (nonatomic,strong) UIImageView *img2;
@property (nonatomic,strong) UIImageView *img3;
@property (nonatomic,strong) UIImageView *img4;

@end


@implementation STCZJPCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.contentView addSubview:self.img1];
    [self.contentView addSubview:self.img2];
    [self.contentView addSubview:self.img3];
    [self.contentView addSubview:self.img4];
    
    
    [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView.mas_centerX).offset(-1);
        make.height.mas_equalTo(104);
    }];
    
    
    [self.img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.contentView.mas_centerX).offset(1);
        make.height.mas_equalTo(104);
    }];
    
    [self.img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(104);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView.mas_centerX).offset(-1);
        make.top.equalTo(self.img1.mas_bottom);
    }];
    
    [self.img4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img1.mas_bottom);
        make.height.mas_equalTo(104);
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.contentView.mas_centerX).offset(1);
    }];
    
    
}

- (void)setInfoArr:(NSArray<STShopAdlistModel *> *)infoArr
{
    _infoArr = infoArr;
    if (infoArr.count < 4) return;
    [self.img1 sd_setImageWithURL:[NSURL URLWithString:infoArr[0].imgUrl]];
    [self.img2 sd_setImageWithURL:[NSURL URLWithString:infoArr[1].imgUrl]];
    [self.img3 sd_setImageWithURL:[NSURL URLWithString:infoArr[2].imgUrl]];
    [self.img4 sd_setImageWithURL:[NSURL URLWithString:infoArr[3].imgUrl]];
    
}



- (UIImageView *)img1
{
    if (_img1 == nil) {
        _img1 = [[UIImageView alloc]init];
    }
    return _img1;
}

- (UIImageView *)img2
{
    if (_img2 == nil) {
        _img2 = [[UIImageView alloc]init];
    }
    return _img2;
}

- (UIImageView *)img3
{
    if (_img3 == nil) {
        _img3 = [[UIImageView alloc]init];
    }
    return _img3;
}

- (UIImageView *)img4
{
    if (_img4 == nil) {
        _img4 = [[UIImageView alloc]init];
    }
    return _img4;
}




@end
