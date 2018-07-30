//
//  STShopHeadCell.m
//  STYBuy
//
//  Created by 高欣 on 2018/7/8.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STShopHeadCell.h"
#import "STShopHeadModel.h"
@interface STShopHeadCell()

@property (nonatomic,strong) UIImageView *headImg;

@end


@implementation STShopHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    [self.contentView addSubview:self.headImg];
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.size.equalTo(self.contentView);
    }];
}

- (void)setInfoArr:(NSArray *)infoArr
{
    _infoArr = infoArr;
    STShopHeadModel * model = infoArr.firstObject;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
}


- (UIImageView *)headImg
{
    if (_headImg == nil) {
        _headImg = [[UIImageView alloc]init];
        _headImg.contentMode = UIViewContentModeScaleAspectFill;
        _headImg.clipsToBounds = YES;
    }
    return _headImg;
}

@end
