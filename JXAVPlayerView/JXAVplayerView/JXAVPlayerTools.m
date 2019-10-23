//
//  JXAVPlayerTools.m
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/22.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import "JXAVPlayerTools.h"

@implementation JXAVPlayerTools

static NSInteger isIPad = -1;
+ (BOOL)isIPad {
    if (isIPad < 0) {
        // [[[UIDevice currentDevice] model] isEqualToString:@"iPad"] 无法判断模拟器 iPad，所以改为以下方式
        if(@available(iOS 13.0,*)){
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                //iphone 设备
                isIPad = 0;
            }else{
                //ipad 设备
                isIPad = 1;
            }
        
        }
        isIPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 1 : 0;
    }
    return isIPad > 0;
}

static NSInteger isNotchedScreen = -1;
//ipad 全面屏
+ (BOOL)isNotchedScreen {
    
    if (isNotchedScreen < 0) {
        
        if (@available(iOS 11.0, *)) {
            CGFloat safeAreaBottom = [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom;
            if (safeAreaBottom > 0) {
               //need to fit
                isNotchedScreen = 1;
            }else{
                isNotchedScreen = 0;
            }
        }
        
       // isNotchedScreen = ([[UIApplication sharedApplication] statusBarFrame].size.height > 20) ?  1 : 0;
    }
    
    return isNotchedScreen > 0;
}
@end
