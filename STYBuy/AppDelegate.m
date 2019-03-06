//
//  AppDelegate.m
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "AppDelegate.h"
#import <STRootNavController.h>
#import <STSections.h>


@interface AppDelegate ()
@property (nonatomic,weak) STRootNavController *rootNavController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //初始化配置
    [self initializeConfig];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.rootNavController = [[STAppManager manager] constructUI];
    self.window.rootViewController = self.rootNavController;
    [UIManager registerNavigationController:self.rootNavController];
    
    //在初始化UI之后配置
    [self configureApplication:application initialParamsAfterInitUI:launchOptions];
    
    return YES;
}

/**
 初始化配置
 */
- (void)initializeConfig
{
    //bug管理
    [Bugly startWithAppId:BuglyAppID];
    //初始化用户信息
    [self initializeSTUser];
    //监测网络状态
    [self netWorkState];
}

- (void)netWorkState
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变时调用
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
        }
    }];
    //开始监控
    [manager startMonitoring];
}


/**
 初始化用户信息
 */
- (void)initializeSTUser
{
    STUserDataManager * manager = [STUserDataManager sharedUserManager];
    NSLog(@"%@",manager.userData.mj_keyValues);
}


/**
 在初始化UI之后配置
 */
- (void)configureApplication:(UIApplication *)application initialParamsAfterInitUI:(NSDictionary *)launchOptions
{
    //配置启动图
    [LaunchIntroductionView sharedWithImages:@[@"guide0",@"guide1",@"guide2"] buttonImage:nil buttonFrame:CGRectMake(kScreen_width/2 - 200/2, kScreen_height*0.9, 200, 35)];
    
    //配置app 主题
    [[STThemeManager sharedInstance]configTheme];
    
#ifdef DEBUG
    //FPS 检测
    [[JPFPSStatus sharedInstance] open];
    
    //切换服务器
    
#else
    //do sth.
#endif
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
