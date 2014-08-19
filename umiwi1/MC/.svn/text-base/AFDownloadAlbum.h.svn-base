//
//  AFDownload.h
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//
#import "AFDownload.h"
#define AFDOWNLOADALBUM [AFDownloadAlbum sharedDownloadAlbum]

@class AFDownload;
@protocol AFDownloadDelegate,AFDownloadAlbumDelegate;

@interface AFDownloadAlbum : AFDownload
{
    //代理
    id<AFDownloadAlbumDelegate>    _albumdelegate;
    
    int                            _albumDownloadingNow;
}
@property (nonatomic, readonly) int *albumNum;
@property (nonatomic, readonly) int *albumState;
//state 0=完成 1=用户暂停 2=等待 3=下载 
//@property (nonatomic, readwrite, retain) NSMutableArray *albumArray;
@property (nonatomic, readwrite, assign) id<AFDownloadAlbumDelegate> albumdelegate;

+ (id)sharedDownloadAlbum;

/**
 添加视频
 @param 一个字典， 添加到队列中
 @param 还有专辑的字典
 @提示语  1.@"您当前未使用WiFi,视频仅加入下载队列!"
 2.@"已添加到下载队列中！"
 3.@"亲，已经下载啦！"
 4.@"成功添加到了下载队列！"
 @return  成功返回  YES
 */
- (BOOL)addDownloadQueue:(NSDictionary*)dictionary andAlbumDict:(NSDictionary*)albumDict isVideo:(BOOL)isVideo;
//刷新统计信息
-(void)refreshDownloadInfo;

-(void)deleteItemWithAlbumDict:(NSDictionary*)albumDict;
-(void)deleteItemWithVideoDict:(NSDictionary*)videoDict isInDownloadIngTable:(BOOL)isInDownloadIngTable;

-(NSArray*)getDownloadedListWithDict:(NSDictionary*)albumDict;
-(NSArray*)getDownloadingListWithDict:(NSDictionary*)albumDict;

#pragma mark - 私有

@end
@protocol AFDownloadAlbumDelegate <AFDownloadDelegate>
@end
//albumArray 里面的字典组成
/*
     isHaveMusic   0  木有  1 有
 */

/*
 image
 title
 url
 
 total
 progress
 state    0 可以下载   1 用户暂停
 */








