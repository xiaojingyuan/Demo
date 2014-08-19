//
//  AFDownload.m
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import "AFDownload.h"
#import "AppDelegate.h"
#include <sys/xattr.h>
#define AFDownloadPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/AFDownload.plist"]
static AFDownload *_afDownload=nil;
@implementation AFDownload
- (void)addSkipBackupAttributeToFile:(NSURL *)url{
    u_int8_t b = 1;
    setxattr([[url path] fileSystemRepresentation], "com.apple.MobileBackup", &b, 1, 0, 0);
}
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
            [AFTools encodeMp4File:[vedioDict[@"url"] md5String]];
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
        if ([self.delegate respondsToSelector:@selector(downloadDidFinished:)]) {
            [self.delegate downloadDidFinished:vedioDict];
        }
        [self countAlbum:vedioDict];
        //发送通知
        [NNCDC postNotificationName:DOWN_SUCCESS_NOTIFICATION object:nil];
        NSLog(@"Successfully downloaded file to %@", downloadPath);
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
        if ([self.delegate respondsToSelector:@selector(downloadProgressChangedAtRow:)]) {
            [self.delegate downloadProgressChangedAtRow:_downloadingRow];
        }
    }];
    [_operation start];
}
#pragma mark -
-(void)storeThePlistDictionary
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([_allDictionary writeToFile:AFDownloadPath atomically:YES]) {
            NSLog(@"写入成功");
        }
    });
}
//开始下载
- (void)startDownload
{
    if (!_isDownNow) {
        [self chooseOneToDownload];
    }
}
//停止下载
- (void)stopDownload
{
    if (_operation != nil) {
        if (![_operation isPaused]) {
            [_operation pause];
        }
        if (![_operation isCancelled]) {
            [_operation cancel];
        }
    }
    _operation=nil;
    _isDownNow = NO;
    _downloadingRow= -1;
}
//暂停
- (void)pauseDownload
{
    [self stopDownload];
    [self chooseOneToDownload];
}
//
- (void)changeTheStateWithVID:(NSString*)vid isVideo:(NSString*)isVideo
{
    int index = -1;
    for (int i=0; i<_downloadingArray.count; i++) {
        if ([_downloadingArray[i][@"vid"] isEqualToString:vid] && [_downloadingArray[i][@"isVideo"] isEqualToString:isVideo]) {
            index = i;
            break;
        }
    }
    [self changeTheStateWithIndex:index];
}
- (void)changeTheStateWithIndex:(int)index
{
    NSLog(@"_downloadingRow=%d",_downloadingRow);
    if (index == -1) {
        return;
    }
    if (_downloadingRow == index) { //如果等于的话
        NSMutableDictionary* tempDict = _downloadingArray[index];
        [tempDict setValue:@"1" forKey:@"state"];
        [self pauseDownload];
    }
    else{
        BOOL temp = [_downloadingArray[index][@"state"] boolValue];
        temp ^= 1;
        [_downloadingArray[index] setValue:[NSString stringWithFormat:@"%d",temp] forKey:@"state"];
        NSLog(@"_downloadingArray[index]=%@",_downloadingArray[index]);
        if (!_isDownNow) {
            [self chooseOneToDownload];
        }
    }
    [self storeThePlistDictionary];
}
- (BOOL)addDownloadQueue:(NSDictionary*)dictionary
{
    if (_downloadArray.count + _downloadingArray.count + _downloadMusicArray.count < 30) {
        NSArray* tempArray=[dictionary[@"url"] componentsSeparatedByString:@"/"];
        if (tempArray.count < 4 || [[tempArray lastObject] length] < 3) {
            [AFTools alertTKWithMessage:@"这个连接有问题，请及时反馈客服。"];
            return NO;
        }
        switch ([self getDownloadStateWithDictionary:dictionary]) {
            case AFDownloadTypeNone:;
                NSMutableDictionary* tempDict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
                [tempDict setValue:@"0" forKey:@"state"];
                [tempDict setValue:@"1" forKey:@"total"];
                [tempDict setValue:@"0" forKey:@"progress"];
                [_downloadingArray addObject:tempDict];
                if (!_isDownNow) {
                    [self chooseOneToDownload];
                }
                [AFTools alertTKWithMessage:@"成功添加到了下载队列，稍候即可下载完成！"];
                return YES;
            case AFDownloadTypeed:
                [AFTools alertTKWithMessage:@"亲，已经下载啦！"];
                return NO;
            case AFDownloadTypeing:
                [AFTools alertTKWithMessage:@"已添加到下载队列中！"];
                return NO;
            default:
                break;
        }
        [self storeThePlistDictionary];
    }
    else{
        [AFTools alertTKWithMessage:@"主银，下载中心已满，看完删除后再下载吧！"];
        return NO;
    }
}



//删除
- (void)deleteAllTheDownloadArray
{
    //先把文件给删除了
    for (NSDictionary* dict in _downloadArray) {
        [FM removeItemAtPath:AFDownloadVideoPath(dict[@"url"]) error:nil];
    }
    [_downloadArray removeAllObjects];
    [self storeThePlistDictionary];
}
- (void)deleteAllTheDownloadMusicArray
{
    for (NSDictionary* dict in _downloadMusicArray) {
        [FM removeItemAtPath:AFDownloadMusicPath(dict[@"url"]) error:nil];
    }
    [_downloadMusicArray removeAllObjects];
    [self storeThePlistDictionary];
}
- (void)deleteAllTheDownloadingArray
{
    [_downloadingArray removeAllObjects];
    [self storeThePlistDictionary];
    [self stopDownload];
}
- (void)deleteAlbumArray
{
    [_albumArray removeAllObjects];
}
- (void)deleteItemFromDownloadArrayWithArray:(NSArray*)array
{
    NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
    NSMutableArray* tempArray = [[NSMutableArray alloc] init];
    for (NSNumber* num in array) {
        NSMutableDictionary* dict = _downloadArray[[num intValue]];
        [FM removeItemAtPath:AFDownloadVideoPath(dict[@"url"]) error:nil];
        [tempArray addObject:dict];
    }
    [_downloadArray removeObjectsInArray:tempArray];
    [tempArray release];
    [self storeThePlistDictionary];
    [pool release];
}
- (void)deleteItemFromDownloadMusicArrayWithArray:(NSArray*)array
{
    NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
    NSMutableArray* tempArray = [[NSMutableArray alloc] init];
    for (NSNumber* num in array) {
        NSMutableDictionary* dict = _downloadMusicArray[[num intValue]];
        [FM removeItemAtPath:AFDownloadMusicPath(dict[@"url"]) error:nil];
        [tempArray addObject:dict];
    }
    [_downloadMusicArray removeObjectsInArray:tempArray];
    [tempArray release];
    [self storeThePlistDictionary];
    [pool release];
}
- (void)deleteItemFromDownloadingArrayWithArray:(NSArray*)array
{
    NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
    NSMutableArray* tempArray = [[NSMutableArray alloc] init];
    for (NSNumber* num in array) {
        int index = [num intValue];
        NSMutableDictionary* dict = _downloadingArray[index];
        if (_downloadingRow == index) {
            [self stopDownload];
        }
        [tempArray addObject:dict];
    }
    [_downloadingArray removeObjectsInArray:tempArray];
    [tempArray release];
    [self storeThePlistDictionary];
    [pool release];
}
-(BOOL)isID:(NSString*)str InArray:(NSArray*)array
{
    for (NSString* albumIDStr in array) {
        if ([albumIDStr isEqualToString:str]) {
            return YES;
        }
    }
    return NO;
}
- (void)deleteItemByAlbumWithArray:(NSArray*)array
{
    NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
    //先把array换算一下
    NSMutableIndexSet* indexSet = [[NSMutableIndexSet alloc] init];
    NSMutableArray* albumIDArray = [[NSMutableArray alloc] init];
    for (NSNumber* num in array) {
        int index = [num intValue];
        [indexSet addIndex:index];
        [albumIDArray addObject:_albumArray[index][@"albumID"]];
    }
    
    //按照aid来删除已经下载好的
    NSMutableArray* tempArray = [[NSMutableArray alloc] init];
    for (NSMutableDictionary* dict in _downloadArray) {
        if ([self isID:dict[@"albumID"] InArray:albumIDArray]) {
            [FM removeItemAtPath:AFDownloadVideoPath(dict[@"url"]) error:nil];
            [tempArray addObject:dict];
        }
    }
    [_downloadArray removeObjectsInArray:tempArray];
    
    [tempArray removeAllObjects];
    for (NSMutableDictionary* dict in _downloadMusicArray) {
        if ([self isID:dict[@"albumID"] InArray:albumIDArray]) {
            [FM removeItemAtPath:AFDownloadMusicPath(dict[@"url"]) error:nil];
            [tempArray addObject:dict];
        }
    }
    [_downloadMusicArray removeObjectsInArray:tempArray];
    
    [tempArray release];
    [self storeThePlistDictionary];
    
    [_albumArray removeObjectsAtIndexes:indexSet];
    [indexSet release];
    [albumIDArray release];
    [pool release];
}
- (AFDownloadType)getDownloadStateWithDictionary:(NSDictionary*)dictionary
{
    for (NSDictionary* dict in _downloadingArray) {
        if ([dict[@"url"] isEqualToString:dictionary[@"url"]]) {
            return AFDownloadTypeing;
        }
    }
    for (NSDictionary* dict in _downloadArray) {
        if ([dict[@"url"] isEqualToString:dictionary[@"url"]]) {
            return AFDownloadTypeed;
        }
    }
    for (NSDictionary* dict in _downloadMusicArray) {
        if ([dict[@"url"] isEqualToString:dictionary[@"url"]]) {
            return AFDownloadTypeed;
        }
    }
    return AFDownloadTypeNone;
}
-(NSArray*)getDownloadedListWithDict:(NSString*)albumID
{
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    for (NSMutableDictionary* dict in _downloadArray) {
        if ([dict[@"albumID"] isEqual:albumID]) {
            [resultArray addObject:[[dict mutableCopy] autorelease]];
        }
    }
    for (NSMutableDictionary* dict in _downloadMusicArray) {
        if ([dict[@"albumID"] isEqual:albumID]) {
            BOOL isNew = YES;
            for (NSMutableDictionary* resultdict in resultArray) {
                if ([resultdict[@"albumID"] isEqualToString:dict[@"albumID"]]) {
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
-(void)chooseOneToDownload
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if ([AFTools isEnableWIFI] || [AFGLOBALDATA enableDownAt3G])
        {
            [self storeThePlistDictionary];
            _isDownNow = YES;
            BOOL flag = NO;
            for (int i=0; i<_downloadingArray.count; i++) {
                NSDictionary* dict = _downloadingArray[i];
                if ([dict[@"state"] isEqualToString:@"0"]) {
                    _downloadingRow = i;
                    flag = YES;
                    break;
                }
            }
            NSLog(@"_downloadingRow = %d，flag = %d",_downloadingRow,flag);
            if(flag){
                [self downloadTheVedio];
                [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
                NSLog(@"down");
            }
            else{
                NSLog(@"down no");
                _isDownNow = NO;
                _downloadingRow = -1;
                if ([self.delegate respondsToSelector:@selector(thereIsNoneToDownload)]) {
                    [self.delegate thereIsNoneToDownload];
                    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
                }
            }
        }
        else{
            [AFTools alertTKWithMessage:@"您当前未使用WiFi且不允许在3G下面下载,视频暂不下载队列!"];
        }
    });
}

-(void)recountAlbum
{
    [_albumArray removeAllObjects];
    for (NSMutableDictionary* dict in _downloadArray) {
        [self countAlbum:dict];
    }
    for (NSMutableDictionary* dict in _downloadMusicArray) {
        [self countAlbum:dict];
    }
}
-(void)countAlbum:(NSDictionary*)dict
{
    BOOL isNew = YES;
    for (NSMutableDictionary* albumDict in _albumArray) {
        if ([dict[@"albumID"] isEqualToString:albumDict[@"albumID"]]) {
            NSString* num = albumDict[@"num"];
            [albumDict setValue:[NSString stringWithFormat:@"%d",[num intValue]+1] forKey:@"num"];
            if ([dict[@"isVideo"] isEqualToString:@"0"]) {
                [albumDict setValue:@"1" forKey:@"isMusic"];
            }
            isNew = NO;
            break;
        }
    }
    if (isNew) {
        NSMutableDictionary* tempDict = [[NSMutableDictionary alloc] init];
        [tempDict setValue:@"1" forKey:@"num"];
        [tempDict setValue:dict[@"albumID"] forKey:@"albumID"];
        [tempDict setValue:dict[@"image"] forKey:@"image"];
        [tempDict setValue:dict[@"albumName"] forKey:@"albumName"];
        if ([dict[@"isVideo"] isEqualToString:@"0"]) {
            [tempDict setValue:@"1" forKey:@"isMusic"];
        }
        [_albumArray addObject:tempDict];
        [tempDict release];
    }
}
#pragma mark - common
- (id)init{
    self=[super init];
    if (self) {
        //NSLog(@"AFDownloadPath=%@",AFDownloadPath);
        //创建video文件夹
        NSString* dir=[APP_CACHES_PATH stringByAppendingFormat:@"/video"];
        BOOL isDir = NO;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL existed = [fileManager fileExistsAtPath:dir isDirectory:&isDir];
        if ( !(isDir == YES && existed == YES) )
        {
            [fileManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:AFDownloadPath]) {
            _allDictionary=[[NSMutableDictionary alloc] initWithContentsOfFile:AFDownloadPath];
            _downloadArray=[_allDictionary objectForKey:@"downloadArray"];
            _downloadingArray=[_allDictionary objectForKey:@"downloadingArray"];
            _downloadMusicArray=_allDictionary[@"downloadMusicArray"];
        }
        else{//第一次安装，新建
            _allDictionary=[[NSMutableDictionary alloc] init];
            _downloadArray=[[NSMutableArray alloc] init];
            _downloadingArray=[[NSMutableArray alloc] init];
            _downloadMusicArray=[[NSMutableArray alloc] init];
            
            [_allDictionary setValue:_downloadArray forKey:@"downloadArray"];
            [_allDictionary setValue:_downloadingArray forKey:@"downloadingArray"];
            [_allDictionary setValue:_downloadMusicArray forKey:@"downloadMusicArray"];
            
            [self storeThePlistDictionary];
        }
        
        //最后统计一下 专辑
        _albumArray = [[NSMutableArray alloc] init];
        [self recountAlbum];
    }
    return self;
    
}
+ (id)sharedDownload{
    static dispatch_once_t predDownload;
    dispatch_once(&predDownload, ^{
        _afDownload=[[AFDownload alloc] init];
    });
    return _afDownload;
}

+(id)alloc
{
	NSAssert(_afDownload == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}
-(void)dealloc
{
    [super dealloc];
}
@end
