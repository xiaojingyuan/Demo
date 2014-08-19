//
//  AFDownload.h
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#define AFDOWNLOAD [AFDownload sharedDownload]
#define AFDownloadVideoPath(filename) [APP_CACHES_PATH stringByAppendingFormat:@"/video/%@.mp4",[filename md5String]]
#define AFDownloadMusicPath(filename) [APP_CACHES_PATH stringByAppendingFormat:@"/video/%@.mp3",[filename md5String]]
typedef enum {
    AFDownloadTypeNone,   //没有在列表中
    AFDownloadTypeed,     //已经下载
    AFDownloadTypeing,    //正在下载
}AFDownloadType;

@class AFDownload;
@protocol AFDownloadDelegate;

@interface AFDownload : NSObject
{
    //下载的数组
    NSMutableArray                *_downloadArray;
    NSMutableArray                *_downloadMusicArray;
    NSMutableArray                *_downloadingArray;
    NSMutableArray                *_albumArray;
    //代理
    id<AFDownloadDelegate>         _delegate;
    
    //私有数据
    int                            _downloadingRow;
    
    //存放全部的数据项
    NSMutableDictionary           *_allDictionary;
    
    //管理下载的
    AFDownloadRequestOperation    *_operation;
    BOOL                           _isDownNow;
}
@property (nonatomic, readwrite, retain) NSMutableArray *downloadArray;
@property (nonatomic, readwrite, retain) NSMutableArray *downloadMusicArray;
@property (nonatomic, readonly, retain) NSMutableArray *downloadingArray;
@property (nonatomic, readwrite, assign) id<AFDownloadDelegate> delegate;

@property (nonatomic, readwrite, retain) NSMutableArray *albumArray;

+ (id)sharedDownload;
- (void)addSkipBackupAttributeToFile:(NSURL *)url;
//存储缓存
-(void)storeThePlistDictionary;
//开始下载
- (void)startDownload;
//停止下载
- (void)stopDownload;
//暂停
- (void)pauseDownload;

//改变状态
- (void)changeTheStateWithVID:(NSString*)vid isVideo:(NSString*)isVideo;
- (void)changeTheStateWithIndex:(int)index;
/**
 添加视频
 @param 一个字典， 添加到队列中
 @提示语  1.@"您当前未使用WiFi,视频仅加入下载队列!"
                 2.@"已添加到下载队列中！"
                 3.@"亲，已经下载啦！"
                 4.@"成功添加到了下载队列！"
 @return  成功返回  YES
 */
- (BOOL)addDownloadQueue:(NSDictionary*)dictionary;



//删除
- (void)deleteAllTheDownloadArray;
- (void)deleteAllTheDownloadMusicArray;
- (void)deleteAllTheDownloadingArray;
- (void)deleteAlbumArray;

- (void)deleteItemFromDownloadArrayWithArray:(NSArray*)array;
- (void)deleteItemFromDownloadMusicArrayWithArray:(NSArray*)array;
- (void)deleteItemFromDownloadingArrayWithArray:(NSArray*)array;
- (void)deleteItemByAlbumWithArray:(NSArray*)array;

-(NSArray*)getDownloadedListWithDict:(NSString*)albumID;
//内部私有的
//判断下载状态
- (AFDownloadType)getDownloadStateWithDictionary:(NSDictionary*)dictionary;
-(void)chooseOneToDownload;
@end
@protocol AFDownloadDelegate <NSObject>
//数组中的第几个更新
- (void)downloadProgressChangedAtRow:(int)downloadingRow;

//已经下载完成
- (void)downloadDidFinished:(NSDictionary*)dictionary;

//当目前木有可以下载的
- (void)thereIsNoneToDownload;
@end
/*
 image
 title
 url
 
 total
 progress
 state    0 可以下载   1 用户暂停 2 下载完成
 */








