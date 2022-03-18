//
//  MSYLogManager.m
//  MSYLog_Example
//
//  Created by Simon Miao on 2022/3/18.
//  Copyright © 2022 FancyPower.com. All rights reserved.
//

#import "MSYLogManager.h"
#import "MSYLogFormatter.h"
#import "MSYLogFileFormatter.h"
#import "MSYLogFileManager.h"

//设置默认的log等级
#ifdef DEBUG
DDLogLevel ddLogLevel = DDLogLevelDebug;
#else
DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

@interface MSYLogManager ()

@property (nonatomic, strong) DDFileLogger *fileLogger;//控制台logger
@property (nonatomic, strong) DDOSLogger *osLogger;//文件写入Logger

@end

@implementation MSYLogManager

#pragma mark - lifecycle methods

+ (instancetype)sharedInstance {
    static MSYLogManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark - public methods

//添加控制台logger
- (void)addOSLogger {
    [DDLog addLogger:self.osLogger];
}
//添加文件写入Logger
- (void)addFileLogger {
    [DDLog addLogger:self.fileLogger];
}
//移除控制台logger
- (void)removeOSLogger {
    [DDLog removeLogger:_osLogger];
}
//移除文件写入Logger
- (void)removeFileLogger {
    [DDLog removeLogger:_fileLogger];
}

- (void)switchLogLevel:(DDLogLevel)logLevel {
    ddLogLevel = logLevel;
}

#pragma mark - 文件夹操作

- (void)createAndRollToNewFile {
    [_fileLogger rollLogFileWithCompletionBlock:^{
        NSLog(@"rollLogFileWithCompletionBlock");
    }];
}

- (NSArray *)filePaths {
    return _fileLogger.logFileManager.sortedLogFilePaths;
}

- (NSString *)currentFilePath {
    return _fileLogger.currentLogFileInfo.filePath;
}

#pragma mark - private methods

- (NSString *)getCustomLogsDirectory {
#if TARGET_OS_IPHONE
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *baseDir = paths.firstObject;
    NSString *logsDirectory = [baseDir stringByAppendingPathComponent:@"MSYLogs"];
#else
    NSString *appName = [[NSProcessInfo processInfo] processName];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? paths[0] : NSTemporaryDirectory();
    NSString *logsDirectory = [[basePath stringByAppendingPathComponent:@"MSYLogs"] stringByAppendingPathComponent:appName];
#endif
    
    return logsDirectory;
}

#pragma mark - getter && setter

- (DDOSLogger *)osLogger {
    if (!_osLogger) {
        _osLogger = [DDOSLogger sharedInstance];
        _osLogger.logFormatter = [[MSYLogFormatter alloc] init];
    }
    return _osLogger;
}

- (DDFileLogger *)fileLogger {
    if (!_fileLogger) {
        
        //使用自定义的logFileManager
        MSYLogFileManager *fileManager = [[MSYLogFileManager alloc] initWithLogsDirectory:[self getCustomLogsDirectory]];
        _fileLogger = [[DDFileLogger alloc] initWithLogFileManager:fileManager];
        //使用自定义的Logformatter
        _fileLogger.logFormatter = [[MSYLogFileFormatter alloc] init];
        
        //重用log文件，不要每次启动都创建新的log文件(默认值是NO)
        _fileLogger.doNotReuseLogFiles = NO;
        //log文件在24小时内有效，超过时间创建新log文件(默认值是24小时)
        _fileLogger.rollingFrequency = 60*60*24;
        //log文件的最大3M(默认值1M)
        _fileLogger.maximumFileSize = 1024*1024*3;
        //最多保存7个log文件(默认值是5)
        _fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        //log文件夹最多保存10M(默认值是20M)
        _fileLogger.logFileManager.logFilesDiskQuota = 1014*1024*10;
    }
    return _fileLogger;
}

@end
