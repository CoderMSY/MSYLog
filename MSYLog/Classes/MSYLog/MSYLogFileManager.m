//
//  MSYLogFileManager.m
//  MSYLog_Example
//
//  Created by Simon Miao on 2022/3/18.
//  Copyright © 2022 FancyPower.com. All rights reserved.
//

#import "MSYLogFileManager.h"

@interface MSYLogFileManager ()

@property (nonatomic, strong) NSDateFormatter *msyFileDateFormatter;

@end

@implementation MSYLogFileManager

#pragma mark - lifecycle methods

#pragma mark - public methods

///重写log文件名
- (NSString *)newLogFileName {
    NSString *appName = [self msy_applicationName];
    NSString *formattedDateStr = [self.msyFileDateFormatter stringFromDate:[NSDate date]];
    
    return [NSString stringWithFormat:@"%@-%@.log", appName, formattedDateStr];
}

- (BOOL)isLogFile:(NSString *)fileName {
    BOOL hasProperSuffix = [fileName hasSuffix:@".log"];
    
    return hasProperSuffix;
}

#pragma mark - private methods

//重写方法(log文件夹路径)
//- (NSString *)defaultLogsDirectory {
//
//#if TARGET_OS_IPHONE
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *baseDir = paths.firstObject;
//    NSString *logsDirectory = [baseDir stringByAppendingPathComponent:@"MSYLogs"];
//#else
//    NSString *appName = [[NSProcessInfo processInfo] processName];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//    NSString *basePath = ([paths count] > 0) ? paths[0] : NSTemporaryDirectory();
//    NSString *logsDirectory = [[basePath stringByAppendingPathComponent:@"MSYLogs"] stringByAppendingPathComponent:appName];
//#endif
//
//    return logsDirectory;
//}

- (NSString *)msy_applicationName {
    static NSString *_appName;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];

        if (_appName.length == 0) {
            _appName = [[NSProcessInfo processInfo] processName];
        }

        if (_appName.length == 0) {
            _appName = @"";
        }
    });
    
    return _appName;
}

#pragma mark - getter && setter

- (NSDateFormatter *)msyFileDateFormatter {
    if (!_msyFileDateFormatter) {
        _msyFileDateFormatter = [[NSDateFormatter alloc] init];
        [_msyFileDateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    }
    return _msyFileDateFormatter;
}


@end
