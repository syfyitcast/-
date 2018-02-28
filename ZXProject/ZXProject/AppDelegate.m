//
//  AppDelegate.m
//  ZXProject
//
//  Created by Me on 2018/2/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.              
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "LoginViewController.h"
#import "UserLocationManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    self.window.backgroundColor = [UIColor whiteColor];
    MainNavigationController *navc = [[MainNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    self.window.rootViewController = [[MainTabBarController alloc] init];//navc;
    [self.window makeKeyAndVisible];
    [[UserLocationManager sharedUserLocationManager] getUserLocation];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  
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