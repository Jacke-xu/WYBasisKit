//
//  NetWorkingStatus.m
//  WYBasisKit
//
//  Created by Jacke-xu on 16/11/30.
//  Copyright © 2016年 Jacke-xu. All rights reserved.
//

#import "NetWorkingStatus.h"
#import "Reachability.h"

@interface NetWorkingStatus ()

@end

@implementation NetWorkingStatus

+ (networkStatus)internetStatus {
    
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    switch (internetStatus) {
        case ReachableViaWiFi:
            return wifi;
            break;
            
        case ReachableViaWWAN:
            return wwan;
            break;
            
        case NotReachable:
            return noNetwork;
            
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
