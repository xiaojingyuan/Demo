//
//  UMiSDK.h
//  UMiSDK
//
//  Created by 孙超凡 QQ:729397005 on 13-7-4.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMiSDK : NSObject
/**
 *	@brief	注册应用,此方法在应用启动时调用一次并且只能在主线程中调用。
 *          在 application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 中调用该函数。
 *
 *	@param 	 application     应用的application
 *           appKey 	     应用Key,在官网中注册的应用Key
 */
+ (void)application:(UIApplication *)application startSDKWithAppKey:(NSString *)appKey;
/**
 *	@brief	在触发的事件中调用。
 *
 */
+ (void)jumpToUMi;

@end
