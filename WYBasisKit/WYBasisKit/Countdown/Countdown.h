//
//  Countdown.h
//  WYBasisKit
//
//  Created by jacke-xu on 2017/5/4.
//  Copyright © 2017年 jacke-xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Countdown : NSObject

/** 创建实例对象 */
- (Countdown *)initCountdown;

/**
 开始倒计时

 @param totalTime 需要倒计时的时长，单位秒
 @param action 倒计时block，里面返回的是剩余时长，单位秒
 */
- (void)beginCountdown:(NSInteger)totalTime action:(void(^)(NSInteger endDuration))action;

/** 取消倒计时 */
- (void)cancelCountdown;

///传入一个秒数，返回时分秒格式的字符串
+ (NSString *)formatTimeStr:(NSInteger)secondNumber;

///传入一个秒数，返回有几个小时
+ (NSString *)formatFewHours:(NSInteger)secondNumber;

///传入一个秒数，返回有多少分钟
+ (NSString *)formatFewMinute:(NSInteger)secondNumber;

@end
