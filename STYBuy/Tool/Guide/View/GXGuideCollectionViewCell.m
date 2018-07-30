//
//  GXGuideCollectionViewCell.m
//  JiaFan
//
//  Created by apple on 2017/3/22.
//  Copyright © 2017年 杜顺. All rights reserved.
//

#import "GXGuideCollectionViewCell.h"
@interface GXGuideCollectionViewCell ()

@end

@implementation GXGuideCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self subviewsInit];
    }
    return self;
}

- (void)subviewsInit
{
    self.bgImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.contentView);
        make.center.equalTo(self.contentView);
    }];
    
    self.beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.beginBtn setTitleColor:White_Color forState:UIControlStateNormal];
    [self.beginBtn setTitle:@"点击进入" forState:UIControlStateNormal];
    self.beginBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.beginBtn setBackgroundImage:[UIImage createImageWithColor:Main_Color] forState:UIControlStateNormal];
    self.beginBtn.layer.cornerRadius = 22;
    self.beginBtn.layer.masksToBounds = YES;
    self.beginBtn.layer.borderColor = White_Color.CGColor;
    self.beginBtn.layer.borderWidth = 1;
    [self.beginBtn addTarget:self action:@selector(beginAction:) forControlEvents:UIControlEventTouchUpInside];
    self.beginBtn.hidden = YES;
    [self.contentView addSubview:self.beginBtn];
    [self.beginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(- 100);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(150);
        make.centerX.equalTo(self.contentView);
    }];
    
    
}

- (void)beginAction:(UIButton *)sender
{
    [self.delegate beginAction:sender];
}

@end
