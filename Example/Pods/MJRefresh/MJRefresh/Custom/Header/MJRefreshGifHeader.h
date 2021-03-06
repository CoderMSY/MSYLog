//
//  MJRefreshGifHeader.h
//  MJRefresh
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#if __has_include(<MJRefresh/MJRefreshStateHeader.h>)
#import <MJRefresh/MJRefreshStateHeader.h>
#else
#import "MJRefreshStateHeader.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshGifHeader : MJRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *gifView;

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (instancetype)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state;
- (instancetype)setImages:(NSArray *)images forState:(MJRefreshState)state;
@end

NS_ASSUME_NONNULL_END
