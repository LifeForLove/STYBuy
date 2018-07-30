//
//  STMainTab.m
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STMainTab.h"
#import "STHomeNav.h"
#import "STMineNav.h"
#import "STShopNav.h"

@interface STMainTab ()

@property (nonatomic,strong) STHomeNav *homeNav;

@property (nonatomic,strong) STMineNav *mineNav;

@property (nonatomic,strong) STShopNav *shopNav;
@end

@implementation STMainTab

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayMainViewControllers];
}

- (void)displayMainViewControllers
{
    //tabbar 去掉顶部的线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    [[UITabBar appearance] setBackgroundColor:White_Color];
    
    //设置导航条样式
    //nav 文字颜色
    [[UINavigationBar appearance] setTintColor:White_Color];
    
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = TextNavTitleFont;
    att[NSForegroundColorAttributeName] = White_Color;
    //设置标题样式
    [[UINavigationBar appearance] setTitleTextAttributes:att];

    //去掉顶部黑线
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage createImageWithColor:Main_Color] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTranslucent:YES];
    
    self.homeNav = [[STHomeNav alloc] init];
    self.homeNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[[UIImage imageNamed:@"tabbar_home_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_home_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.homeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Main_Color ,NSFontAttributeName:TabbarTextFont} forState:UIControlStateSelected];
    [self.homeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Text_Gary_Color,NSFontAttributeName:TabbarTextFont} forState:UIControlStateNormal];
    
    self.shopNav = [[STShopNav alloc]init];
    self.shopNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"商城" image:[[UIImage imageNamed:@"tabbar_home_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_home_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.shopNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Main_Color ,NSFontAttributeName:TabbarTextFont} forState:UIControlStateSelected];
    [self.shopNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Text_Gary_Color,NSFontAttributeName:TabbarTextFont} forState:UIControlStateNormal];
    

    self.mineNav = [[STMineNav alloc]init];
    self.mineNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[[UIImage imageNamed:@"tabbar_mine_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_mine_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.mineNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Text_Gary_Color,NSFontAttributeName:TabbarTextFont} forState:UIControlStateNormal];
    [self.mineNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Main_Color,NSFontAttributeName:TabbarTextFont} forState:UIControlStateSelected];
    self.viewControllers = @[self.homeNav,self.shopNav,self.mineNav];
    
}

@end
