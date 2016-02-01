//
//  AppDelegate.h
//  Note_Notification
//
//  Created by THN-Huangfei on 16/1/29.
//  Copyright © 2016年 Huangfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NotificationDelege <NSObject>

@optional
- (void)resetNotificationState;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, weak) id<NotificationDelege> notiDelegate;


@end

