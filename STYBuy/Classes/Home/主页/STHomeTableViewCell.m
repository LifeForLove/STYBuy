//
//  STHomeTableViewCell.m
//  STYBuy
//
//  Created by 高欣 on 2018/6/27.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STHomeTableViewCell.h"
#import "STHomeListModel.h"

@interface STHomeTableViewCell()

/**
 用户头像
 */
@property (nonatomic,strong) UIImageView * logoImgView;

/**
 用户名称
 */
@property (nonatomic,strong) UILabel * nameLb;

/**
 评价内容
 */
@property (nonatomic,strong) UILabel * evaluateLb;

@end

@implementation STHomeTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.contentView addSubview:self.logoImgView];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.evaluateLb];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.size.mas_equalTo(45);
    }];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImgView);
        make.left.equalTo(self.logoImgView.mas_right).offset(10);
    }];
    
    [self.evaluateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLb.mas_bottom).offset(10);
        make.left.equalTo(self.nameLb);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = Text_DHS_Color;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)setModel:(STHomeListModel *)model
{
    _model = model;
    [self.logoImgView iconImg_setImageWithString:[NSString stringWithFormat:@"http://img.gafaer.com/%@",model.headpic]];
    self.nameLb.text = model.name;
    self.evaluateLb.text = model.cotext;
}

- (UIImageView *)logoImgView {
    if (_logoImgView == nil) {
        _logoImgView = [[UIImageView alloc]init];
        _logoImgView.layer.cornerRadius = 45/2.0;
        _logoImgView.clipsToBounds=YES;
    }
    return _logoImgView;
}


- (UILabel *)nameLb {
    if (_nameLb == nil) {
        _nameLb = [UILabel labelWithColor:Text_Black_Color font:TextTitleFont alignment:NSTextAlignmentLeft title:@""];
    }
    return _nameLb;
}

- (UILabel *)evaluateLb {
    if (_evaluateLb == nil) {
        _evaluateLb = [UILabel labelWithColor:Text_Gary_Color font:TextSubTitleFont alignment:NSTextAlignmentLeft title:@""];
        _evaluateLb.numberOfLines = 0;
    }
    return _evaluateLb;
}




@end
