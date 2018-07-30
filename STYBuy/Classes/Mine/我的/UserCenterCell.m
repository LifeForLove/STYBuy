//
//  UserCenterCell.m
//  TianYiBuy
//
//  Created by 廖师傅 on 2017/11/14.
//  Copyright © 2017年 kajibu. All rights reserved.
//

#import "UserCenterCell.h"

@interface UserCenterCell ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *accView;

@end

@implementation UserCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView
{

    [self.contentView addSubview:self.leftImage];
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(10);
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.leftImage.mas_right).offset(7);
    }];
    
    [self.contentView addSubview:self.accView];
    [self.accView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(13/2, 23/2));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.nameLabel.mas_right).offset(15);
    }];
    
}


- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel labelWithColor:Text_Gary_Color font:TextSubTitleFont alignment:NSTextAlignmentLeft title:@""];
    }
    return _contentLabel;
}


- (UIImageView *)accView
{
    if (_accView == nil) {
        _accView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    return _accView;
}


- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = Text_DHS_Color;
    }
    return _lineView;
}

#pragma mark - 懒加载
-(UIImageView *)leftImage
{
    if (!_leftImage) {
        _leftImage = [UIImageView new];
    }
    return _leftImage;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithColor:Text_Black_Color font:TextTitleFont alignment:NSTextAlignmentLeft title:@""];
    }
    return _nameLabel;
}

@end
