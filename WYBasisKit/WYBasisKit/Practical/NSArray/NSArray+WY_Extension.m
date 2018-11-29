//
//  NSArray+WY_Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/28.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import "NSArray+WY_Extension.h"

@implementation NSArray (WY_Extension)

+ (NSArray *)wy_sortFromArray:(NSArray *)array {
    
    NSArray *ary = [array sortedArrayUsingComparator:^(NSString * obj1, NSString * obj2){
        
        return (NSComparisonResult)[obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    return ary;
}

+ (NSArray *)wy_sortAscendingNumFromArray:(NSArray *)array {
    
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        
        if ([obj1 intValue] > [obj2 intValue]) {
            return NSOrderedDescending;//下行
        } else {
            return NSOrderedAscending;//上行
        }
    }];
    
    return sortedArray;
}

+ (NSArray *)wy_sortDescendingNumFromArray:(NSArray *)array {
    
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
