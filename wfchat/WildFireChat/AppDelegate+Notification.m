//
//  AppDelegate+Notification.m
//  JDWin_B
//
//  Created by xinfu on 2018/12/3.
//  Copyright © 2018 Chensw. All rights reserved.
//

#import "AppDelegate+Notification.h"
#import "WFCBaseTabBarController.h"
#import "MyLoginViewController.h"

static NSString *kSocial_UMeng_Key = @"5e22750e570df346d100008a";
//static NSString *kSocial_UMeng_Key = @"5e1d9176570df389d8000011";//自有

@implementation AppDelegate (Notification)


- (void)notificationApplication:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self pushSetup:launchOptions];
 
}

- (void)notificationApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    [self receiveCommon:userInfo];
}

- (void)notificationApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    if (![deviceToken isKindOfClass:[NSData class]]){
        NSLog(@"deviceToken 类型错误");
        return;
    }
    const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
    NSString *token = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    NSLog(@"deviceToken:%@",token);

}
- (void)notificationApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FailToRegisterForRemoteNotifications" message:error.userInfo.description delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = notification.request.content.userInfo;
    [self receiveCommon:userInfo];/** 前台接收到通知刷新公告栏数量 */
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    }
}
//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        [self receiveCommon:userInfo];
    }else{
        //应用处于后台时的本地推送接受
    }
}


#pragma mark PushSDKDelegate

-(void)receiveCommon:(NSDictionary *)extra{
    if(extra == nil){
        return;
    }
    
   
}

// 设置友盟推送
- (void)pushSetup:(NSDictionary *)dic{
    [UMConfigure setLogEnabled:YES];
    [UMConfigure initWithAppkey:kSocial_UMeng_Key channel:@"liao8"];
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge | UMessageAuthorizationOptionAlert | UMessageAuthorizationOptionSound;
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    } else {
        // Fallback on earlier versions
    }
    

    [UMessage registerForRemoteNotificationsWithLaunchOptions:dic Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 用户选择了接收push消息
            NSLog(@"用户选择了接收push消息");
        }else{
            // 用户拒绝接收Push消息
            NSLog(@"用户拒绝接收Push消息");
        }
    }];
}

@end
