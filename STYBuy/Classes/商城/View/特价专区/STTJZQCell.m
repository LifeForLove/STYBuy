//
//  STTJZQCell.m
//  STYBuy
//
//  Created by 高欣 on 2018/7/8.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STTJZQCell.h"
#import "STShopTJZQModel.h"
@interface STTJZQCell()

@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) UIImageView *img1;

@property (nonatomic,strong) UIImageView *img2;

@property (nonatomic,strong) UIImageView *img3;

@property (nonatomic,strong) UILabel *label1;

@property (nonatomic,strong) UILabel *label2;

@property (nonatomic,strong) UILabel *label3;



@end


@implementation STTJZQCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(8);
        make.height.mas_equalTo(140);
    }];
    
    [self.contentView addSubview:self.img1];
    [self.contentView addSubview:self.img2];
    [self.contentView addSubview:self.img3];
    [self.contentView addSubview:self.label1];
    [self.contentView addSubview:self.label2];
    [self.contentView addSubview:self.label3];
    
    [self.img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.imgView.mas_bottom).offset(15);
        make.size.mas_equalTo(100);
    }];
    
    [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.img2.mas_left).offset(-15);
        make.centerY.equalTo(self.img2);
        make.size.equalTo(self.img2);
    }];
    
    [self.img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.img2);
        make.size.equalTo(self.img2);
        make.left.equalTo(self.img2.mas_right).offset(15);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img1.mas_bottom).offset(10);
        make.left.right.equalTo(self.img1);
        make.height.mas_equalTo(50);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img2.mas_bottom).offset(10);
        make.left.right.equalTo(self.img2);
        make.height.mas_equalTo(50);
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img3.mas_bottom).offset(10);
        make.left.right.equalTo(self.img3);
        make.height.mas_equalTo(50);
    }];
    
    
}

- (void)setModel:(STShopTJZQModel *)model
{
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];

    if (model.productList.count < 3 ) return;
    [self.img1 sd_setImageWithURL:[NSURL URLWithString:model.productList[0].imgUrl]];
    [self.img2 sd_setImageWithURL:[NSURL URLWithString:model.productList[1].imgUrl]];
    [self.img3 sd_setImageWithURL:[NSURL URLWithString:model.productList[2].imgUrl]];
    
    self.label1.text = model.productList[0].title;
    self.label2.text = model.productList[1].title;
    self.label3.text = model.productList[2].title;
    
}



- (UIImageView *)imgView
{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
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

- (UILabel *)label1
{
    if (_label1 == nil) {
        _label1 = [UILabel labelWithColor:Text_Black_Color font:TextTitleFont alignment:NSTextAlignmentLeft title:@""];
        _label1.numberOfLines = 2;
    }
    return _label1;
}

- (UILabel *)label2
{
    if (_label2 == nil) {
        _label2 = [UILabel labelWithColor:Text_Black_Color font:TextTitleFont alignment:NSTextAlignmentLeft title:@""];
        _label2.numberOfLines = 2;
    }
    return _label2;
}

- (UILabel *)label3
{
    if (_label3 == nil) {
        _label3 = [UILabel labelWithColor:Text_Black_Color font:TextTitleFont alignment:NSTextAlignmentLeft title:@""];
        _label3.numberOfLines = 2;
    }
    return _label3;
}




@end
