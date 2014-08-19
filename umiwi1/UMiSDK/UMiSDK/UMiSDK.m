//
//  UMiSDK.m
//  UMiSDK
//
//  Created by 孙超凡 QQ:729397005 on 13-7-4.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import "UMiSDK.h"

static UMiSDK *_umisdk=nil;
@interface UMiSDK ()

@property (nonatomic, readwrite, assign) UIApplication *application;
@property (nonatomic, readwrite, assign) NSString* appkey;
@property (nonatomic, readwrite, retain) NSMutableData *receiveData;
-(void)upLoadTheData;
@end
@implementation UMiSDK
+ (void)application:(UIApplication *)application startSDKWithAppKey:(NSString *)appKey
{
    [[UMiSDK sharedUMiSDK] setAppkey:appKey];
    [[UMiSDK sharedUMiSDK] setApplication:application];
    [[UMiSDK sharedUMiSDK] upLoadTheData];
}
+ (void)jumpToUMi
{
    NSLog(@"%@",[[UMiSDK sharedUMiSDK] appkey]);
    if ([[[UMiSDK sharedUMiSDK] application] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"com.umiwi.m.ios://%@",[[UMiSDK sharedUMiSDK] appkey]]]]) {
        [[[UMiSDK sharedUMiSDK] application] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"com.umiwi.m.ios://%@",[[UMiSDK sharedUMiSDK] appkey]]]];
    }
    else{
        [[[UMiSDK sharedUMiSDK] application] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/id464253192?mt=8"]];
    }
}
-(void)upLoadTheData
{
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    UIDevice *dev = [UIDevice currentDevice];
    NSString *deviceUuid;
    if ([dev.systemVersion characterAtIndex:0] < '6') {
        deviceUuid=@"";
    }
    else{
        deviceUuid=[[dev identifierForVendor] UUIDString];
    }
    NSString* urlString=[[NSString stringWithFormat:@"http://v.umiwi.com/Applesdklog/index/?appname=%@&appversion=%@&deviceuid=%@&devicename=%@&devicemodel=%@&deviceversion=%@&ref=%@",appName,appVersion,deviceUuid,dev.name,dev.model,dev.systemVersion,self.appkey] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"urlString=%@",urlString);
    NSURLRequest* request=[[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30] autorelease];
    NSURLConnection* connection = [[[NSURLConnection alloc] initWithRequest:request delegate:(id<NSURLConnectionDelegate>)self] autorelease];
    if (connection) {
        self.receiveData = [NSMutableData data];
    }
}
#pragma mark - NSURLConnectionDelegate
//接收到服务器回应的时候调用此方法
#if 0
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"%@",[res allHeaderFields]);
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receiveData appendData:data];
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    NSLog(@"receiveStr = %@",receiveStr);
    [receiveStr release];
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error
{
    NSLog(@"error = %@",[error localizedDescription]);
}
#endif
#pragma mark - common
-(void)dealloc
{
    [super dealloc];
}
- (id)init{
    self=[super init];
    if (self) {
    }
    return self;
}
+ (id)sharedUMiSDK{
    static dispatch_once_t predUMiSDK;
    dispatch_once(&predUMiSDK, ^{
        _umisdk=[[UMiSDK alloc] init];
    });
    return _umisdk;
}
+(id)alloc
{
	NSAssert(_umisdk == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}
@end
