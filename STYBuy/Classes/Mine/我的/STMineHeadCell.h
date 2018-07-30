//
//  STMineHeadCell.h
//  STYBuy
//
//  Created by 高欣 on 2018/7/6.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STMIneModel;
@interface STMineHeadCell : UITableViewCell

@property (nonatomic,strong) UITapGestureRecognizer *iconTap;

@property (nonatomic,strong) STMIneModel *model;

@end
