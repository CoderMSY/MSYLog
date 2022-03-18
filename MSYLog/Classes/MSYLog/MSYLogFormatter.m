//
//  MSYLogFormatter.m
//  MSYLog_Example
//
//  Created by Simon Miao on 2022/3/18.
//  Copyright © 2022 FancyPower.com. All rights reserved.
//

#import "MSYLogFormatter.h"

@implementation MSYLogFormatter

#pragma mark - DDLogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *loglevel = nil;
    switch (logMessage->_flag) {
        case DDLogFlagError:
        {
            loglevel = @"❌ [ERROR]";
        }
            break;
        case DDLogFlagWarning:
        {
            loglevel = @"⚠️ [WARN] ";
        }
            break;
        case DDLogFlagInfo:
        {
            loglevel = @"✅ [INFO] ";
        }
            break;
        case DDLogFlagDebug:
        {
            loglevel = @"👨‍💻 [DEBUG]";
        }
            break;
        case DDLogFlagVerbose:
        {
            loglevel = @"🌀 [VERBOSE]";
        }
            break;
            
        default:
            loglevel = @"🌀 [VERBOSE]";
            break;
    }
    
    NSString *formatStr = [NSString stringWithFormat:@"%@ %@ line:%ld message:%@", loglevel, logMessage->_function, logMessage->_line, logMessage->_message];
    
    return formatStr;
}

@end
