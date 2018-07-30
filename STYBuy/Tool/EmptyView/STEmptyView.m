//
//  STEmptyView.m
//  STYBuy
//
//  Created by 高欣 on 2018/6/28.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STEmptyView.h"

@interface STEmptyView()

/**
 文字描述label
 */
@property (nonatomic,strong) UILabel *desLabel;

@property (nonatomic,strong) UIImageView *emptyImg;


@end


@implementation STEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.emptyImg];
        [self addSubview:self.desLabel];
        [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(40);
        }];
        
        [self.emptyImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.desLabel.mas_top).offset(-30);
            make.size.mas_equalTo(70);
            make.centerX.equalTo(self);
        }];

        self.emptyType = STEmptyType_NoData;
    }
    return self;
}

- (void)setEmptyType:(STEmptyType)emptyType
{
    //NSLog(@"emptyType ============ %ld %@",emptyType,self);
    switch (emptyType) {
        case STEmptyType_NoData:
            self.desLabel.text = @"暂无内容";
            self.emptyImg.image = [UIImage imageNamed:@"empty_nodata"];
            break;
            
        case STEmptyType_NoNetWork:
            self.desLabel.text = @"网络连接失败";
            self.emptyImg.image = [UIImage imageNamed:@"empty_nonet"];
            break;
            
        case STEmptyType_TimedOut:
            self.desLabel.text = @"请求超时";
            self.emptyImg.image = [UIImage imageNamed:@"empty_timeout"];
            break;
        
        case STEmptyType_ErrorDefault:
            self.desLabel.text = @"请求失败";
            self.emptyImg.image = [UIImage imageNamed:@"empty_error"];
            break;
        default:
            break;
    }
}


- (UILabel *)desLabel
{
    if (_desLabel == nil) {
        _desLabel = [UILabel labelWithColor:Text_Gary_Color font:TextTitleFont alignment:NSTextAlignmentCenter title:@""];
    }
    return _desLabel;
}

- (UIImageView *)emptyImg
{
    if (_emptyImg == nil) {
        _emptyImg = [[UIImageView alloc]init];
    }
    return _emptyImg;
}



@end
