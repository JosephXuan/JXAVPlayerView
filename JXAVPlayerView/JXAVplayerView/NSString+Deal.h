//
//  NSString+Deal.h
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/23.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Deal)
/**
  
 */
+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval;
/**
 展示
*/
+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval totalTimeInterval:(NSTimeInterval)total;

@end

NS_ASSUME_NONNULL_END

