//
//  ViewController.m
//  Note_Notification
//
//  Created by THN-Huangfei on 16/1/29.
//  Copyright © 2016年 Huangfei. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"

@interface ViewController ()<NotificationDelege>

@property (weak, nonatomic) IBOutlet UILabel *notiStateLbl;

- (IBAction)notificationBtnAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.notiDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)notificationBtnAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

#pragma mark - NotificationDelege
- (void)resetNotificationState
{
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (setting.types == UIUserNotificationTypeNone) {
        self.notiStateLbl.text = @"已关闭";
    } else {
        self.notiStateLbl.text = @"已开启";
    }
}

@end
