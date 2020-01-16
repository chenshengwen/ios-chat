//
//  AppDelegate+Notification.h
//  JDWin_B
//
//  Created by xinfu on 2018/12/3.
//  Copyright © 2018 Chensw. All rights reserved.
//

#import "AppDelegate.h"
#import <UMPush/UMessage.h>  //友盟推送
#import <UserNotifications/UserNotifications.h>
#import <UMCommon/UMCommon.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Notification)<UNUserNotificationCenterDelegate>

- (void)notificationApplication:(UIApplication *)application
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)notificationApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

- (void)notificationApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)notificationApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
