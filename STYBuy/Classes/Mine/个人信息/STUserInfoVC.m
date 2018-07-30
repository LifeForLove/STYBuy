//
//  STUserInfoVC.m
//  STYBuy
//
//  Created by 高欣 on 2018/7/6.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STUserInfoVC.h"

@interface STUserInfoVC ()

@end

@implementation STUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * logoutBtn = [UIButton buttonWithTextColor:White_Color font:TextTitleFont backgroundNormalColor:Main_Color backgroundHighlightedColor:Text_DHS_Color];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.view addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 45));
    }];
    
    [[logoutBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [STUserManager loginOut:^{
            [FBIWarningView showMessage:@"退出成功"];
        } fail:^{
            [FBIWarningView showMessage:@"退出失败"];
        }];
    }];
    
}


@end
