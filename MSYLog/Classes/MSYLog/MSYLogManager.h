//
//  MSYLogManager.h
//  MSYLog_Example
//
//  Created by Simon Miao on 2022/3/18.
//  Copyright © 2022 FancyPower.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

extern DDLogLevel ddLogLevel;

// 默认的宏，方便使用
#define MSYLog(frmt, ...)            MSYLogInfo(frmt, ##__VA_ARGS__)

// 提供不同的宏，对应到特定参数的对外接口 （日志等级）
#define MSYLogError(frmt, ...)       DDLogError(frmt, ##__VA_ARGS__)    //错误
#define MSYLogWarn(frmt, ...)        DDLogWarn(frmt, ##__VA_ARGS__)     //警告
#define MSYLogInfo(frmt, ...)        DDLogInfo(frmt, ##__VA_ARGS__)     //信息
#define MSYLogDebug(frmt, ...)       DDLogDebug(frmt, ##__VA_ARGS__)    //调试
#define MSYLogVerbose(frmt, ...)     DDLogVerbose(frmt, ##__VA_ARGS__)  //详细

NS_ASSUME_NONNULL_BEGIN

@interface MSYLogManager : NSObject

+ (instancetype)sharedInstance;
- (instancetype)init NS_UNAVAILABLE;

///添加控制台logger
- (void)addOSLogger;
///添加文件写入Logger
- (void)addFileLogger;
///移除控制台logger
- (void)removeOSLogger;
///移除文件写入Logger
- (void)removeFileLogger;

/// 切换日志等级（XXX以上等级才输出）
/// @param logLevel XXX日志等级
- (void)switchLogLevel:(DDLogLevel)logLevel;

- (void)createAndRollToNewFile;
///所有log文件路径
- (NSArray *)filePaths;
///当前活跃的log文件路径
- (NSString *)currentFilePath;

@end

NS_ASSUME_NONNULL_END
