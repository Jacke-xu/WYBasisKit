//
//  Countdown.m
//  WYBasisKit
//
//  Created by jacke-xu on 2017/5/4.
//  Copyright © 2017年 jacke-xu. All rights reserved.
//

#import "Countdown.h"

@interface Countdown ()

@property (nonatomic) dispatch_source_t timer;//倒计时;

@end

@implementation Countdown

- (Countdown *)initCountdown {
    
    return [[Countdown alloc]init];
}

- (void)beginCountdown:(NSInteger)totalTime action:(void (^)(NSInteger))action {
    
    //倒计时时长
    __block NSInteger timeout = totalTime; //倒计时时间
    weakSelf(self)
    self.timer = nil;
    
    if (timeout != 0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        weakself.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(weakself.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        
        dispatch_source_set_event_handler(weakself.timer, ^{
            
            if(timeout <= 0) {
                //倒计时结束，关闭
                dispatch_source_cancel(weakself.timer);
                weakself.timer = nil;
                
            }else {
                
                timeout --;
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if(action) {
                        
                        action(timeout);
                    }
                });
            }
        });
        
        dispatch_resume(weakself.timer);
    }
}

- (void)cancelCountdown {
    
    if(_timer) {
        
        dispatch_cancel(_timer);
        _timer = nil;
        NSLog(@"取消倒计时成功");
    }
}

+ (NSString *)formatTimeStr:(NSInteger)secondNumber {
    
    NSString *hour   = [@(secondNumber/3600) stringValue];
    NSString *minute = [@((secondNumber-([hour integerValue]*3600))/60) stringValue];
    NSString *second = [@(secondNumber-([minute integerValue]*60)-([hour integerValue]*3600)) stringValue];
    if([hour integerValue] < 10) {
        
        hour = [@"0" stringByAppendingString:hour];
    }
    
    if([minute integerValue] < 10) {
        
        minute = [@"0" stringByAppendingString:minute];
    }
    
    if([second integerValue] < 10) {
        
        second = [@"0" stringByAppendingString:second];
    }
    
    return [NSString stringWithFormat:@"%@:%@:%@",hour,minute,second];
}

+ (NSString *)formatFewHours:(NSInteger)secondNumber {
    
    return [@(secondNumber/3600) stringValue];
}

+ (NSString *)formatFewMinute:(NSInteger)secondNumber {
    
    NSString *hour   = [@(secondNumber/3600) stringValue];
    return [@((secondNumber-([hour integerValue]*3600))/60) stringValue];
}


@end
