//
//  STRecomCell.m
//  STYBuy
//
//  Created by 高欣 on 2018/7/8.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STRecomCell.h"
#import "STShopRecomListModel.h"
@interface STRecomCell ()

@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation STRecomCell

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
        make.left.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(100);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(10);
        make.top.equalTo(self.imgView);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    
}

- (void)setModel:(STShopRecomListModel *)model
{
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    self.titleLabel.text = model.title;
}


- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel labelWithColor:Text_Black_Color font:TextTitleFont alignment:NSTextAlignmentCenter title:@""];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}


- (UIImageView *)imgView
{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}

@end
