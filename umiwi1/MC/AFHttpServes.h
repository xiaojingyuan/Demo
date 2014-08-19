//
//  AFHttpServes.h
//  MC
//
//  Created by 孙超凡 QQ:729397005 on 13-3-27.
//  Copyright (c) 2013年 优米网. All rights reserved.
//
//备忘录模式
//离线或失败后缓存 准备在下一次程序启动重新提交
#import "AFWebServesDefineHeader.h"
#define AFHTTPSERVES [AFHttpServes sharedHttpServes]

@interface AFHttpServes : NSObject
{
    NSMutableArray          *_dataArray;
    dispatch_queue_t         _queue;
}
+ (id)sharedHttpServes;
//保存数据
-(void)storeThePlistDictionary;
//开始的时候，开数组里面空不？不空了执行一下。
-(void)startCheckAndUpload;

//提交通知的数据
-(void)commitNotificationMessage:(NSString*)urlString;

//提交视频播放信息
- (void)commitVideoPlayInfo:(NSDictionary*)infoDict withSuccessBlock:(getBackBlock)idBlock andFailBlock:(getFailBlock)failBlock;

//提交反馈信息
- (void)commitFeedbackInfo:(NSDictionary*)infoDict withSuccessBlock:(getBackBlock)idBlock andFailBlock:(getFailBlock)failBlock;

//提交客户端运行日志
-(void)commitRunningLog:(NSString*)urlString;
@end
