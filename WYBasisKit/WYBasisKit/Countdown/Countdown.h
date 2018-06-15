//
//  Countdown.h
//  WYBasisKit
//
//  Created by jacke-xu on 2017/5/4.
//  Copyright © 2017年 jacke-xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Countdown : NSObject

- (Countdown *)initCountdown;

- (void)beginCountdown:(NSInteger)downtimer action:(void(^)(NSInteger downTimer))action;

- (void)cancelCountdown;

//传入一个秒数，返回时分秒格式的字符串
+ (NSString *)formatTimeStr:(NSInteger)secondNumber;

//传入一个秒数，返回有几个小时
+ (NSString *)formatFewHours:(NSInteger)secondNumber;

//传入一个秒数，返回有多少分钟
+ (NSString *)formatFewMinute:(NSInteger)secondNumber;

@end
