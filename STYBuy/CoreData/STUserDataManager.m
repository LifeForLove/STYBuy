//
//  STUserDataManager.m
//  STYBuy
//
//  Created by 高欣 on 2018/5/14.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STUserDataManager.h"

static NSString * userIdKey = @"STUserCurrentUser";
@interface STUserDataManager ()

/**
 当前用户userId
 */
@property (nonatomic,copy) NSString *currentUserId;

@property (nonatomic,strong)  NSManagedObjectContext *context;//coredata上下文

@end


@implementation STUserDataManager
@dynamic currentUserId;
+(instancetype)sharedUserManager
{
    static STUserDataManager *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[STUserDataManager alloc]init];
    });
    return obj;
}


- (void)setCurrentUserId:(NSString *)currentUserId
{
    [[NSUserDefaults standardUserDefaults]setObject:currentUserId forKey:userIdKey];
}

- (NSString *)currentUserId
{
    NSString * userId = [[NSUserDefaults standardUserDefaults]objectForKey:userIdKey];
    if (!userId) {
        [[NSUserDefaults standardUserDefaults]setObject:@"000000" forKey:userIdKey];
    }
    return [[NSUserDefaults standardUserDefaults]objectForKey:userIdKey];
}

- (void)insert:( void (^) (STUser *))userBlock
{
    if ([self userSaved]) {
        NSLog(@"数据库已有此用户");
        return;
    }
    
    STUser *users = [NSEntityDescription insertNewObjectForEntityForName:@"STUser" inManagedObjectContext:self.context];
    if (!userBlock) return;
    userBlock(users);

    NSError *error = nil;
    BOOL success = NO;
    if (self.context.hasChanges) {
        success = [self.context save:&error];
    }
    
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
        
    }else
    {
        NSLog(@"插入成功");
    }
    
}

- (void)change:(void (^)(STUser *))userBlock
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"STUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId = %@", self.currentUserId];
    request.predicate = predicate;
    NSError *error = nil;
    NSArray<STUser *> *users = [self.context executeFetchRequest:request error:&error];
    
    if (users.count == 0) {
        [self deleteUser];
        [self initializeSTUser];
    }else
    {
        STUser * user = users.firstObject;
        if (userBlock) {
            userBlock(user);
            self.currentUserId = user.userId;
        }
    }

    if (self.context.hasChanges) {
        [self.context save:nil];
    }
    if (error) {
        NSLog(@"CoreData Update Data Error : %@", error);
    }
}



- (void)deleteUser
{
    //删除之前首先需要用到查询
    NSFetchRequest *request = [[NSFetchRequest alloc] init]; //创建请求
    
    request.entity = [NSEntityDescription entityForName:@"STUser" inManagedObjectContext:self.context];//找到我们的Person
    
    NSError *error = nil;
    NSArray *objs = [self.context executeFetchRequest:request error:&error];//执行我们的请求
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];//抛出异常
    }
    // 遍历数据
    for (STUser *obj in objs) {
        NSLog(@"userState = %@", [obj valueForKey:@"userState"]); //打印符合条件的数据
        NSLog(@"userId = %@", [obj valueForKey:@"userId"]); //打印符合条件的数据
        [self.context deleteObject:obj];
    }

    BOOL success = [self.context save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }else
    {
        NSLog(@"删除成功，sqlite");
    }
}

/**
 初始化当前用户
 */
- (STUser *)initializeSTUser
{
    __block STUser * obj = nil;
    self.currentUserId = @"000000";
    [self insert:^(STUser *user) {
        //初始化
        user.userId = self.currentUserId;
        user.userState = 0;
        obj = user;
    }];
    return obj;
}



- (STUser *)currentUser
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"STUser"];
    NSError *error = nil;
    NSArray<STUser *> *users = [self.context executeFetchRequest:request error:&error];
    if (users.count == 0) {
        return [self initializeSTUser];
    }else
    {
        for (STUser * user in users) {
            if ([user.userId isEqualToString:self.currentUserId]) {
                return user;
            }
        }
    }

    if (error) {
        NSLog(@"CoreData Ergodic Data Error : %@", error);
    }
    //删除用户信息
    [self deleteUser];
    //创建一个新的用户
    return [self initializeSTUser];
}

- (BOOL)userSaved
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"STUser"];
    NSError *error = nil;
    NSArray<STUser *> *users = [self.context executeFetchRequest:request error:&error];
    if (users.count > 0) {
        return YES;
    }
    if (error) {
        NSLog(@"CoreData Ergodic Data Error : %@", error);
    }
    return NO;
}

- (void)loginOut:(void (^)(void))success fail:(void (^)(void))fail
{
    // 请求退出登录接口
    
    
    /*
     退出接口请求成功之后
     1 清除用户信息
     2 发送通知 退到根视图刷新界面
    */
    NSLog(@"退出登录成功");
    [self deleteUser];
    
    [STNotificationCenter postNotificationName:STLoginOutSuccessNotification object:nil];
    
    // 成功执行成功的回调
    if (success) {
        success();
    }
    
    // 失败执行失败的回调
//    if (fail) {
//        fail();
//    }
//
    
}


- (NSManagedObjectContext *)context
{
    if (_context == nil) {
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"STUserModel" withExtension:@"momd"];
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
        
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSError *error = nil;
        dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", @"STUserModel"];
        
        NSPersistentStore *store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL: [NSURL fileURLWithPath:dataPath] options:nil error:&error];
        if (store == nil) { // 直接抛异常
            [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
        }
        _context.persistentStoreCoordinator = coordinator;
        NSLog(@"%@",NSHomeDirectory());//数据库会存在沙盒目录的Documents文件夹下
    }
    return _context;
}


@end
