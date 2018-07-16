//
//  NSArray+Extension.m
//  WYBasisKit
//
//  Created by jacke－xu on 16/9/4.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

+ (NSArray *)sortFromArray:(NSArray *)array {
    
    NSArray *ary = [array sortedArrayUsingComparator:^(NSString * obj1, NSString * obj2){
        
        return (NSComparisonResult)[obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    return ary;
}

+ (NSArray *)sortAscendingNumFromArray:(NSArray *)array {
    
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        
        if ([obj1 intValue] > [obj2 intValue]) {
            return NSOrderedDescending;//下行
        } else {
            return NSOrderedAscending;//上行
        }
    }];
    
    return sortedArray;
}

+ (NSArray *)sortDescendingNumFromArray:(NSArray *)array {
    
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        
        if ([obj1 intValue] < [obj2 intValue]) {
            return NSOrderedDescending;//下行
        } else {
            return NSOrderedAscending;//上行
        }
    }];
    
    return sortedArray;
}

@end
