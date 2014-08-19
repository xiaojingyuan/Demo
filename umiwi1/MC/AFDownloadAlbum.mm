//
//  AFDownload.m
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import "AFDownloadAlbum.h"
#import "AppDelegate.h"
#include "CountDownInfo.h"
#include <sys/xattr.h>
static AFDownloadAlbum *_afDownloadAlbum=nil;
@interface AFDownloadAlbum()
{
    CountDownInfo        *_countDownInfo;
}
@end
@implementation AFDownloadAlbum
-(void)downloadTheVedio
{
    NSMutableDictionary* vedioDict=_downloadingArray[_downloadingRow];
    NSString* downloadPath;
    if ([vedioDict[@"isVideo"] boolValue]) {
        downloadPath = AFDownloadVideoPath(vedioDict[@"url"]);
    }
    else{
        downloadPath = AFDownloadMusicPath(vedioDict[@"url"]);
    }
    NSLog(@"vedioDict=%@",vedioDict);
    NSLog(@"vedioPath=%@",downloadPath);
    NSURL* url = [NSURL URLWithString:vedioDict[@"url"]];
    [self addSkipBackupAttributeToFile:url];
    [vedioDict setValue:@"3" forKey:@"state"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:300];
    _operation = [[[AFDownloadRequestOperation alloc] initWithRequest:request targetPath:downloadPath shouldResume:YES] autorelease];
    [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //移动队列 && 标记下载完成
        [vedioDict setValue:@"2" forKey:@"state"];
        
        if ([vedioDict[@"isVideo"] boolValue]) {
            [AFTools encodeMp4File:downloadPath];
            [_downloadArray addObject:vedioDict];
        }
        else{
            [_downloadMusicArray addObject:vedioDict];
        }
        [_downloadingArray removeObject:vedioDict];
        //递归下载
        [self chooseOneToDownload];
        //响应代理
        [AFTools alertTKWithMessage:[NSString stringWithFormat:@"%@ 下载完成",vedioDict[@"title"]]];
        if ([self.albumdelegate respondsToSelector:@selector(downloadDidFinished:)]) {
            [self.albumdelegate downloadDidFinished:vedioDict];
        }
        NSLog(@"Successfully downloaded file to %@", downloadPath);
        //发送通知
        [self refreshDownloadInfo];
        [NNCDC postNotificationName:DOWN_SUCCESS_NOTIFICATION object:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [AFTools alertTKWithMessage:@"下载链接有问题，自动下载下一个。"];
        [_downloadingArray removeObject:vedioDict];
        NSLog(@"Error: %@", error);
    }];
    [_operation setProgressiveDownloadProgressBlock:^(NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
        if ([vedioDict[@"progress"] isEqualToString:@"0"]) {
            [vedioDict setValue:[NSString stringWithFormat:@"%lld",totalBytesExpectedToReadForFile] forKey:@"total"];
        }
        [vedioDict setValue:[NSString stringWithFormat:@"%lld",totalBytesReadForFile] forKey:@"progress"];
        if ([self.albumdelegate respondsToSelector:@selector(downloadProgressChangedAtRow:)]) {
            [self.albumdelegate downloadProgressChangedAtRow:_downloadingRow];
        }
    }];
    [_operation start];
}
- (BOOL)addDownloadQueue:(NSDictionary*)dictionary andAlbumDict:(NSDictionary*)albumDict isVideo:(BOOL)isVideo
{
    BOOL flag = [super addDownloadQueue:dictionary];
    BOOL isNew = YES;
    if (flag) {
        for (NSMutableDictionary* dict in _albumArray) {
            if ([dict[@"id"] isEqual:albumDict[@"id"]]) {
                if (!isVideo) {
                    [dict setValue:@"1" forKey:@"isMusic"];
                }
                isNew = NO;
                break;
            }
        }
        if (isNew) {
            NSMutableDictionary* tempDict = [[NSMutableDictionary alloc] initWithDictionary:albumDict];
            if (isVideo) {
                [tempDict setValue:@"0" forKey:@"isMusic"];
            }
            else{
                [tempDict setValue:@"1" forKey:@"isMusic"];
            }
            [_albumArray addObject:tempDict];
            [tempDict release];
        }
    }
    [self refreshDownloadInfo];
    return flag;
}
-(void)refreshDownloadInfo
{
    NSArray* a=[_downloadArray arrayByAddingObjectsFromArray:[_downloadingArray arrayByAddingObjectsFromArray:_downloadMusicArray]];
    _countDownInfo->countStateAndNum(&_albumState, &_albumNum, _albumArray,a, _downloadingRow);
}
-(void)deleteItemWithAlbumDict:(NSDictionary*)albumDict
{
    NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
    NSMutableArray* tempArray = [[NSMutableArray alloc] init];
    
    //删除视频的
    for (NSMutableDictionary* dict in _downloadArray) {
        if ([dict[@"countid"] isEqualToString:albumDict[@"id"]]) {
            [FM removeItemAtPath:AFDownloadVideoPath(dict[@"url"]) error:nil];
            [tempArray addObject:dict];
        }
    }
    [_downloadArray removeObjectsInArray:tempArray];
    [tempArray removeAllObjects];
    
    //删除音频的
    for (NSMutableDictionary* dict in _downloadMusicArray) {
        if ([dict[@"countid"] isEqualToString:albumDict[@"id"]]) {
            [FM removeItemAtPath:AFDownloadMusicPath(dict[@"url"]) error:nil];
            [tempArray addObject:dict];
        }
    }
    [_downloadMusicArray removeObjectsInArray:tempArray];
    [tempArray removeAllObjects];
    
    //删除正在下载的
    for (NSMutableDictionary* dict in _downloadingArray) {
        if ([dict[@"countid"] isEqualToString:albumDict[@"id"]]) {
            [tempArray addObject:dict];
        }
    }
    [_downloadingArray removeObjectsInArray:tempArray];
    [tempArray removeAllObjects];
    
    //删除大数组里面的
    for (NSMutableDictionary* dict in _albumArray) {
        if ([dict[@"id"] isEqualToString:albumDict[@"id"]]) {
            [_albumArray removeObject:dict];
            break;
        }
    }
    
    [tempArray release];
    [self storeThePlistDictionary];
    [pool release];
}
-(void)deleteItemWithVideoDict:(NSDictionary*)videoDict isInDownloadIngTable:(BOOL)isInDownloadIngTable;
{
    if (isInDownloadIngTable) {
        if (videoDict[@"url"] != nil) {
            for (NSMutableDictionary* dict in _downloadingArray) {
                if ([dict[@"countid"] isEqualToString:videoDict[@"id"]]) {
                    [_downloadArray removeObject:dict];
                    break;
                }
            }
        }
    }
    else{
        if (videoDict[@"url"] != nil) {
            for (NSMutableDictionary* dict in _downloadArray) {
                if ([dict[@"countid"] isEqualToString:videoDict[@"countid"]]) {
                    [FM removeItemAtPath:AFDownloadVideoPath(videoDict[@"url"]) error:nil];
                    [_downloadArray removeObject:dict];
                    break;
                }
            }
        }
        if (videoDict[@"audio"] != nil) {
            for (NSMutableDictionary* dict in _downloadMusicArray) {
                if ([dict[@"countid"] isEqualToString:videoDict[@"countid"]]) {
                    [FM removeItemAtPath:AFDownloadMusicPath(videoDict[@"url"]) error:nil];
                    [_downloadMusicArray removeObject:dict];
                    break;
                }
            }
        }
    }
    [self storeThePlistDictionary];
}
-(NSArray*)getDownloadedListWithDict:(NSDictionary*)albumDict
{
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    for (NSMutableDictionary* dict in _downloadArray) {
        if ([dict[@"countid"] isEqual:albumDict[@"id"]]) {
            [resultArray addObject:[[dict mutableCopy] autorelease]];
        }
    }
    for (NSMutableDictionary* dict in _downloadMusicArray) {
        if ([dict[@"countid"] isEqual:albumDict[@"id"]]) {
            BOOL isNew = YES;
            for (NSMutableDictionary* resultdict in resultArray) {
                if ([resultdict[@"countid"] isEqualToString:dict[@"countid"]]) {
                    [resultdict setValue:dict[@"url"] forKey:@"audio"];
                    isNew = NO;
                    break;
                }
            }
            if (isNew) {
                NSMutableDictionary* tempDict = [dict mutableCopy];
                [tempDict setValue:tempDict[@"url"] forKey:@"audio"];
                [tempDict setValue:nil forKey:@"url"];
                [resultArray addObject:tempDict];
                [tempDict release];
            }
        }
    }
    return [resultArray autorelease];
}
-(NSArray*)getDownloadingListWithDict:(NSDictionary*)albumDict
{
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    
    for (int i=0;i<_downloadingArray.count;i++) {
        NSMutableDictionary* dict = _downloadingArray[i];
        if ([dict[@"countid"] isEqual:albumDict[@"id"]]) {
            if (i == _downloadingRow) {
                _albumDownloadingNow = resultArray.count;
            }
            [resultArray addObject:dict];
        }
    }
    
    return [resultArray autorelease];
}
#pragma mark - common
- (id)init{
    self=[super init];
    if (self) {
        _countDownInfo = new CountDownInfo;
        if (_allDictionary[@"albumArray"] == nil) {
            _albumArray = [[NSMutableArray alloc] init];
            [_allDictionary setValue:_albumArray forKey:@"albumArray"];
        }
        else{
            _albumArray = _allDictionary[@"albumArray"];
        }
        [self refreshDownloadInfo];
        [self storeThePlistDictionary];
    }
    return self;
    
}
+ (id)sharedDownloadAlbum{
    static dispatch_once_t predDownloadAlbum;
    dispatch_once(&predDownloadAlbum, ^{
        _afDownloadAlbum=[[AFDownloadAlbum alloc] init];
    });
    return _afDownloadAlbum;
}

+(id)alloc
{
	NSAssert(_afDownloadAlbum == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}
-(void)dealloc
{
    if (_albumNum != NULL) {
        free(_albumNum);
        _albumNum = NULL;
    }
    if (_albumState != NULL) {
        free(_albumState);
        _albumState = NULL;
    }
    delete _countDownInfo;
    [super dealloc];
}
@end
