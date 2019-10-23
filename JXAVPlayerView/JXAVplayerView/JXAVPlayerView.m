//
//  JXAVPlayerView.m
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import "JXAVPlayerView.h"
#import "JXAVPlayerView+publicHeader.h"//头文件
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "JXAVPlayerView+SubUI.h"//分类UI
@interface JXAVPlayerView()

//当前播放的item
@property (nonatomic, strong) AVPlayerItem *currentItem;

//当值传入 播放资源路径URL 通过AVURLAsset 创建 当前播放的item
@property (nonatomic, strong) NSURL *videoURL;
//播放资源
@property (nonatomic, strong) AVURLAsset *urlAsset;

//playerLayer,可以修改frame
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
//播放器player 
@property (nonatomic, strong) AVPlayer *player;

// 是否初始化播放器 yes : 初始化
@property (nonatomic, assign) BOOL isInitPlayer;
//监听播放起状态的监听者
@property (nonatomic,strong) id playbackTimeObserver;

@end

@implementation JXAVPlayerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupVideoPlayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupVideoPlayer];
    }
    return self;
}
#pragma mark --配置播放器
- (void)setupVideoPlayer{
    
    self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.95];
    
    // 布局UI JXAVPlayerView+SubUI
    [self setupSubviews];
    //初始化播放器
    [self creatPlayerAndReadyToPlay];
  
    
}
#pragma mark -- 播放属性配置
-(void)creatPlayerAndReadyToPlay{
    
    self.isInitPlayer = YES;
    /*
     // 进入后台监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    */
    //设置player的参数
    if(self.currentItem){
        self.player = [AVPlayer playerWithPlayerItem:self.currentItem];
    }else{
        self.urlAsset = [AVURLAsset assetWithURL:self.videoURL];
        self.currentItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
        self.player = [AVPlayer playerWithPlayerItem:self.currentItem];
    }
    /*
     //重复播放
    if(self.loopPlay){
        self.player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    }else{
        self.player.actionAtItemEnd = AVPlayerActionAtItemEndPause;
    }
     */
    //ios10新添加的属性，如果播放不了，可以试试打开这个代码
    if ([self.player respondsToSelector:@selector(automaticallyWaitsToMinimizeStalling)]) {
        if (@available(iOS 10.0, *)) {
            self.player.automaticallyWaitsToMinimizeStalling = YES;
        } else {
            // Fallback on earlier versions
        }
    }
    self.player.usesExternalPlaybackWhileExternalScreenIsActive=YES;
    //AVPlayerLayer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    //WMPlayer视频的默认填充模式，AVLayerVideoGravityResizeAspect
    self.playerLayer.frame = self.contentView.layer.bounds;
   
    //等比例  默认
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    //等比例铺满，宽或高有可能出屏幕 AVLayerVideoGravityResizeAspectFill;
    //完全适应宽高 AVLayerVideoGravityResize;
    
    [self.contentView.layer insertSublayer:self.playerLayer atIndex:0];
    
    
    //监听播放状态
    [self initTimer];
    [self.player play];
}
#pragma  mark - 定时器
-(void)initTimer{
    __weak typeof(self) weakSelf = self;
    
    self.playbackTimeObserver =  [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1.0, NSEC_PER_SEC)  queue:dispatch_get_main_queue() /* If you pass NULL, the main queue is used. */
        usingBlock:^(CMTime time){
        
        [weakSelf syncScrubber];
        
    }];
}
- (void)syncScrubber{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
   self.playerLayer.frame = self.contentView.bounds;
    
}





- (void)dealloc {
  
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

