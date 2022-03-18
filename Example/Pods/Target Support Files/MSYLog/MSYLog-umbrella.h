#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MSYLogFileFormatter.h"
#import "MSYLogFileManager.h"
#import "MSYLogFormatter.h"
#import "MSYLogManager.h"

FOUNDATION_EXPORT double MSYLogVersionNumber;
FOUNDATION_EXPORT const unsigned char MSYLogVersionString[];

