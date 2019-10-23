//
//  NSString+Deal.m
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/23.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import "NSString+Deal.h"

@implementation NSString (Deal)

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    int hours = interval / 3600;
    int minums = ((long long)interval % 3600) / 60;
    int seconds = (long long)interval % 60;
    if (hours > 0) {
        //如果超过一个小时 展示小时
        return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minums, seconds];
    }
    else {
        //如果不超过 不展示
        return [NSString stringWithFormat:@"%02d:%02d", minums, seconds];
    }
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval totalTimeInterval:(NSTimeInterval)total {
    int hours = interval / 3600;
    int minums = ((long long)interval % 3600) / 60;
    int seconds = (long long)interval % 60;
    int totalHours = total / 3600;
    
    if (totalHours > 0) {
        //如果超过一个小时 展示小时
        return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minums, seconds];
    }
    else {
        //如果不超过 不展示
        return [NSString stringWithFormat:@"%02d:%02d", minums, seconds];
    }
}

@end
