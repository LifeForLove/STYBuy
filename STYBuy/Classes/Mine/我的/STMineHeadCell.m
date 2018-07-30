//
//  STMineHeadCell.m
//  STYBuy
//
//  Created by 高欣 on 2018/7/6.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STMineHeadCell.h"
#import "STMIneModel.h"
@interface STMineHeadCell()
@property (nonatomic,strong) UIImageView *iconImg;
@end


@implementation STMineHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.contentView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.size.mas_equalTo(60);
    }];
    
    //添加手势
    self.iconTap = [[UITapGestureRecognizer alloc] init];
    [self.iconImg addGestureRecognizer:self.iconTap];
}

- (void)setModel:(STMIneModel *)model
{
    _model = model;
    [self.iconImg iconImg_setImageWithString:model.headpic];
}


- (UIImageView *)iconImg
{
    if (_iconImg == nil) {
        _iconImg = [[UIImageView alloc]init];
        _iconImg.layer.cornerRadius = 5;
        _iconImg.layer.masksToBounds = YES;
        _iconImg.clipsToBounds = YES;
        _iconImg.userInteractionEnabled = YES;
        
    }
    return _iconImg;
}

@end
