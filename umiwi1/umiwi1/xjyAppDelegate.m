//
//  xjyAppDelegate.m
//  umiwi1
//
//  Created by mac8 on 14-2-11.
//  Copyright (c) 2014年 mac8. All rights reserved.
//

#import "xjyAppDelegate.h"

@implementation xjyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    NSArray *array = [NSArray arrayWithObjects:@"11",@"22",@"33",@"44", nil];
    NSDictionary *dic=[NSDictionary dictionaryWithObject:@"0000" forKey:@"00"];
    NSLog(@"0==%@",dic[@"00"]);
    NSLog(@"==%@",array[1]);
    NSLog(@"%f==h-w==%f",[UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width);
    
//    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"警告" message:@"这是必须的！" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//    alter.transform=CGAffineTransformTranslate(alter.transform, 1, 90);
    
    for ( int i=0; i<10; i++) {
        switch (i) {
            case 0:
                
                case 1:
                NSLog(@"1==%d",i);
                break;
            case 2:
                NSLog(@"2==%d",i);
                break;
            case 3:
                NSLog(@"3==%d",i);
                break;
            case 4:
                NSLog(@"4==%d",i);
                break;
            case 5:
                
            case 6:
                
            case 7:
            case 8:
                NSLog(@"8==%d",i);
                break;
            default:
                NSLog(@"d==%d",i);
                break;
        }
    }
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
