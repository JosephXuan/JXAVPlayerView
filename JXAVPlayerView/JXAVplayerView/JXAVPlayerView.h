//
//  JXAVPlayerView.h
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//
// 感谢 https://github.com/zhengwenming/WMPlayer
/**
 目前市面上的视频播放大概分下边几种形式，慢慢的会在github上更新的
 平时比较忙 会逐渐整理处理 上传的
 https://github.com/JosephXuan
 1.短视频   >列表全屏滑动播放       （类似小视频app）
 2.视频列表 >列表播放           （类似新闻app）
 3.视频列表 >详情播放           （类似视频app）
 4.详情播放 >悬浮窗口           （类似直播app）
 */
/**
 1.视频播放 第一个是使用 AVPlayer （支持格式 .mp4、.mov、.m4v、.3gp、.av）
 2.使用FFmpeg（如果想支持更多 可以 集成 进行视频转码）
 3.此播放view 使用AVPlayer FFmpeg 研究中，计划新建FFmpeg工程 另起项目
 */
//视频播放 view

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXAVPlayerView : UIView



@end

NS_ASSUME_NONNULL_END
