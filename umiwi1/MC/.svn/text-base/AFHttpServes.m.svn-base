//
//  AFHttpServes.m
//  MC
//
//  Created by 孙超凡 QQ:729397005 on 13-3-27.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import "AFHttpServes.h"
#import "MCDefineHeader.h"

#define AFHttpServesPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/AFHttpServes.bin"]
static AFHttpServes *_afHttpServes=nil;
@implementation AFHttpServes
#pragma mark - private
-(void)addToTheArray:(NSURLRequest *)request
{
    dispatch_async(_queue, ^{
        [_dataArray addObject:request];
        //NSLog(@"_dataArray=%@",_dataArray);
        [self storeThePlistDictionary];
    });
}
-(void)doHttpWithURLRequest:(NSURLRequest*)request withSuccessBlock:(getBackBlock)anyBlock andFailBlock:(getFailBlock)failBlock
{
    AFHTTPRequestOperation *operation = [[[AFHTTPRequestOperation alloc] initWithRequest:request] autorelease];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self startCheckAndUpload];
        if (anyBlock) {
            anyBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self addToTheArray:request];
        if (failBlock) {
            failBlock();
        }
    }];
    [operation start];
}
-(void)doHttpWithUrlString:(NSString*)urlString withSuccessBlock:(getBackBlock)anyBlock andFailBlock:(getFailBlock)failBlock
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    if ([AFTools isEnableNet]) {
        [self doHttpWithURLRequest:request withSuccessBlock:(getBackBlock)anyBlock andFailBlock:(getFailBlock)failBlock];
    }
    else{
        [self addToTheArray:request];
    }
}
#pragma mark - custom
-(void)storeThePlistDictionary
{
    dispatch_async(_queue, ^{
        NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
        [[NSKeyedArchiver archivedDataWithRootObject:_dataArray] writeToFile:AFHttpServesPath atomically:YES];
        [pool release];
    });
}

-(void)startCheckAndUpload
{
    if ([AFTools isEnableNet]) {
        if (_dataArray.count != 0) {
            dispatch_async(_queue, ^{
                NSURLRequest *request=[_dataArray[0] retain];
                [_dataArray removeObjectAtIndex:0];
                [self doHttpWithURLRequest:[request autorelease] withSuccessBlock:nil andFailBlock:nil];
            });
        }
        else{
            [self storeThePlistDictionary];
        }
    }
}
-(void)commitNotificationMessage:(NSString*)urlString
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",URL_APNS_STRING,urlString];
    [self doHttpWithUrlString:urlStr withSuccessBlock:nil andFailBlock:nil];
}
- (void)commitVideoPlayInfo:(NSDictionary*)infoDict withSuccessBlock:(getBackBlock)idBlock andFailBlock:(getFailBlock)failBlock
{
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://v.umiwi.com/watchlog/"]];
    NSMutableURLRequest* request=[client requestWithMethod:@"POST" path:@"add/" parameters:infoDict];
    [client release];
    if ([AFTools isEnableNet]) {
        [self doHttpWithURLRequest:request withSuccessBlock:idBlock andFailBlock:failBlock];
    }
    else{
        [self addToTheArray:request];
    }
}
- (void)commitFeedbackInfo:(NSDictionary*)infoDict withSuccessBlock:(getBackBlock)idBlock andFailBlock:(getFailBlock)failBlock
{
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:URL_FEEDBACK_BASE]];
    NSMutableURLRequest* request=[client requestWithMethod:@"POST" path:@"add" parameters:infoDict];
    [client release];
    if ([AFTools isEnableNet]) {
        [self doHttpWithURLRequest:request withSuccessBlock:idBlock andFailBlock:failBlock];
    }
    else{
        [self addToTheArray:request];
    }
}
-(void)commitRunningLog:(NSString*)urlString
{
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://v.umiwi.com/api/"]];
    NSMutableDictionary* infoDict = [NSMutableDictionary dictionary];
    [infoDict setValue:((isPad)?(@"iPad"):(@"iPhone")) forKey:@"appname"];
    [infoDict setValue:APP_CURRENT_VERSION forKey:@"version"];
    [infoDict setValue:[[UIDevice currentDevice] name] forKey:@"devicename"];
    [infoDict setValue:[AFTools getSecondTimeStamp] forKey:@"dumptime"];
    [infoDict setValue:urlString forKey:@"runninglog"];
    NSMutableURLRequest* request=[client requestWithMethod:@"POST" path:@"runningLog/" parameters:infoDict];
    [client release];
    if ([AFTools isEnableNet]) {
        [self doHttpWithURLRequest:request withSuccessBlock:nil andFailBlock:nil];
    }
    else{
        [self addToTheArray:request];
    }
}
#pragma mark - common
- (id)init{
    self=[super init];
    if (self) {
        _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        NSLog(@"AFHttpServesPath=%@",AFHttpServesPath);
        if ([[NSFileManager defaultManager] fileExistsAtPath:AFHttpServesPath]) {
            //_dataArray=[[NSMutableArray alloc] initWithContentsOfFile:AFHttpServesPath];
            _dataArray=[[NSKeyedUnarchiver unarchiveObjectWithFile:AFHttpServesPath] retain];
            //NSLog(@"_dataArray=%@",_dataArray);
        }
        else{//第一次安装，新建
            _dataArray=[[NSMutableArray alloc] init];
            [self storeThePlistDictionary];
        }

    }
    return self;
    
}
+ (id)sharedHttpServes{
    static dispatch_once_t predHttp;
    dispatch_once(&predHttp, ^{
        _afHttpServes=[[AFHttpServes alloc] init];
    });
    return _afHttpServes;
}

+(id)alloc
{
	NSAssert(_afHttpServes == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}
-(void)dealloc
{
    [super dealloc];
}
@end
