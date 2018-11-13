//
//  AppDelegate.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/7.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "AppDelegate.h"
#import "MaintabbarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
//    if ([Manager redingwenjianming:@"username"]!=nil) {
//        MaintabbarViewController *mainVC = [[MaintabbarViewController alloc]init];
//        self.window.rootViewController = mainVC;
//        mainVC.selectedIndex = 2;
//        [self.window makeKeyWindow];
//    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickHiddenlogin:) name:@"hidden_login" object:nil];
    
    return YES;
}
- (void)clickHiddenlogin:(NSNotification *)text {
    MaintabbarViewController *mainVC = [[MaintabbarViewController alloc]init];
    self.window.rootViewController = mainVC;
    mainVC.selectedIndex = 2;
    [self.window makeKeyWindow];
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game. 322-484-5374
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
