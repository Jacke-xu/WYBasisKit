//
//  WY_Countdown.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/27.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WY_Countdown : NSObject

/** 创建实例对象 */
- (WY_Countdown *)wy_initCountdown;

/**
 开始倒计时
 
 @param totalTime 需要倒计时的时长，单位秒
 @param action 倒计时block，里面返回的是剩余时长，单位秒
 */
- (void)wy_beginCountdown:(NSInteger)totalTime action:(void(^)(NSInteger endDuration))action;

/** 取消倒计时 */
- (void)wy_cancelCountdown;

///传入一个秒数，返回时分秒格式的字符串
+ (NSString *)wy_formatTimeStr:(NSInteger)secondNumber;

///传入一个秒数，返回有几个小时
+ (NSString *)wy_formatFewHours:(NSInteger)secondNumber;

///传入一个秒数，返回有多少分钟
+ (NSString *)wy_formatFewMinute:(NSInteger)secondNumber;

@end

NS_ASSUME_NONNULL_END
