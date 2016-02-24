//
//  AppDelegate.m
//  Note_Notification
//
//  Created by THN-Huangfei on 16/1/29.
//  Copyright © 2016年 Huangfei. All rights reserved.
//

#import "AppDelegate.h"

#import "JPUSHService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    UIUserNotificationSettings * notificationSetting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSetting];
    
    //JPush极光推送
    //可以添加自定义categories
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:nil];
    
    [JPUSHService setupWithOption:launchOptions appKey:@"xxxxxxxxxxxxx" channel:@"iOS" apsForProduction:false];
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
    
    //这个判断是在程序没有运行的情况下收到通知，获取通知信息
    NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    return YES;
}

#pragma mark - JPush相关方法
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);

    [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoMessageView" object:userInfo];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark - Life cycle
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //回到前台时刷新通知状态
    if (_notiDelegate && [_notiDelegate respondsToSelector:@selector(resetNotificationState)]) {
        [_notiDelegate resetNotificationState];
    }
}


#pragma mark - Handling Local and Remote Notifications
/*
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
}

// This callback will be made upon calling -[UIApplication registerUserNotificationSettings:]. The settings the user has granted to the application will be passed in as the second argument.
//用户在选择是否允许通知后调用，之后每次启动都会以已选择的通知状态调用
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification NS_AVAILABLE_IOS(4_0) __TVOS_PROHIBITED
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
}

// Called when your app has been activated by the user selecting an action from a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
}

// Called when your app has been activated by the user selecting an action from a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
}
*/

@end
