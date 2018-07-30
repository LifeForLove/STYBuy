//
//  AppDelegate.m
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "AppDelegate.h"
#import "STMainTab.h"
#import "GXGuideCollectionViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //初始化配置
    [self initializeConfig];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = Background_Color;
    //选择进入的根视图
    [self chooseViewController];
    [self.window makeKeyAndVisible];
    //在初始化UI之后配置
    [self configureApplication:application initialParamsAfterInitUI:launchOptions];
    return YES;
}


- (void)netWorkState
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    @weakify(self);
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        @strongify(self);
        self.networkStatus = status;
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


//初始化用户信息
- (void)initializeSTUser
{
    NSLog(@"STCurrentUser userId %@",STCurrentUser.userId);
}


#pragma mark - 在初始化UI之后配置
- (void)configureApplication:(UIApplication *)application initialParamsAfterInitUI:(NSDictionary *)launchOptions
{
    // 监听切换根视图的通知
    @weakify(self);
    [[STNotificationCenter rac_addObserverForName:STSwitchRootViewControllerNotification object:nil]subscribeNext:^(NSNotification * note) {
        @strongify(self);
        STSwitchRootViewControllerFromType rootType = [note.userInfo[STSwitchRootViewControllerUserInfoKey] integerValue];
        [self switchRootViewControllerWithType:rootType];
    }];
    
    //FPS 检测
#ifdef DEBUG
    [[JPFPSStatus sharedInstance] open];
#else
    //do sth.
#endif
}

/**
 设置根视图

 @param rootType 根视图的类型
 */
- (void)switchRootViewControllerWithType:(STSwitchRootViewControllerFromType)rootType
{
    switch (rootType) {
        //进入tabbar控制器
        case STSwitchRootViewControllerFromType_MainTab:
        {
            STMainTab *mainvc = [[STMainTab alloc] init];
            self.window.rootViewController = mainvc;
        }
            break;
        case STSwitchRootViewControllerFromType_Guide:
        {
            GXGuideCollectionViewController *guide = [[GXGuideCollectionViewController alloc] init];
            self.window.rootViewController = guide;
        }
            break;
        default:
            break;
    }
}


- (void)chooseViewController
{    
    // 1.读取系统的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleVersionKey];
    // 2.读取偏好设置中的版本号
    NSString *lastVersion = [STUserDefaults objectForKey:STUserDefaultVersionKey];
    // 3.对比两个版本号
    //#warning 加!是为了调试 真实情况应该去掉
    if ([currentVersion isEqualToString:lastVersion]) {
        // 相同 显示首页
        [self switchRootViewControllerWithType:STSwitchRootViewControllerFromType_MainTab];
    }else{
        // 显示引导页
        [self switchRootViewControllerWithType:STSwitchRootViewControllerFromType_Guide];
    }
    // 4.将系统的版本号存储到偏好设置
    [STUserDefaults setObject:currentVersion forKey:STUserDefaultVersionKey];
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
