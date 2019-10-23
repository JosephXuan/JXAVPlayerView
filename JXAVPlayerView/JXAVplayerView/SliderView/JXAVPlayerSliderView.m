//
//  JXAVPlayerSliderView.m
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import "JXAVPlayerSliderView.h"
#import <MediaPlayer/MediaPlayer.h>//音量
#import "JXAVPlayerView+publicHeader.h"//头文件
typedef NS_ENUM(NSInteger, JXSliderType) {
    JXSliderTypeUnknown,
    JXSliderTypeSlide,
    JXSliderTypeVolume,
    JXSliderTypeLight
};

@interface JXAVPlayerSliderView ()
//进度展示view
@property (strong, nonatomic) JXAVPlayerSliderSeekView *seekView;
//亮度展示view
@property (strong, nonatomic) JXAVPlayerSliderLightView *lightView;
//音量展示view
@property (strong, nonatomic) MPVolumeView *volumeView;
//当前的播放时间（开始拖动时的时间）
@property (assign, nonatomic) CGFloat beginValue;
//视频总的播放时间
@property (assign, nonatomic) CGFloat durationValue;
//当前视频音量的值
@property (assign, nonatomic) CGFloat originVolume;
//当前屏幕亮度的值
@property (assign, nonatomic) CGFloat originBrightness;
//当前触摸屏幕的位置
@property (assign, nonatomic) CGPoint touchBeganPoint;

//操作的状态
@property (assign, nonatomic) JXSliderType touchMoveType;

@end

@implementation JXAVPlayerSliderView
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //清空颜色
        self.backgroundColor = [UIColor clearColor];
        //进度 view
        [self addSubview:self.seekView];
        [self.seekView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(150, 80));
        }];
        
        self.slideEnabled = YES;
    }
    return self;
}

#pragma mark - touch event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.slideEnabled) {
        return;
    }
    if (touches.count == 1) {
        UITouch *touch = [touches anyObject];
        self.touchBeganPoint = [touch locationInView:self];
        self.touchMoveType = JXSliderTypeUnknown;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.slideEnabled) {
        return;
    }
    if (touches.count == 1) { //单指滑动
        CGPoint movePoint = [[touches anyObject] locationInView:self];
        [self updateTouchMoveTypeByPoint:movePoint];
        
        CGFloat diffX = movePoint.x - self.touchBeganPoint.x;
        CGFloat diffY = movePoint.y - self.touchBeganPoint.y;
        if (self.touchMoveType == JXSliderTypeSlide) {
            //滑动 进度
            [self.seekView resetRelTime:_beginValue duration:_durationValue difference:diffX/10];
            self.seekView.hidden = NO;
            
        }else if (self.touchMoveType == JXSliderTypeLight) {
            //滑动亮度
            CGFloat brightness = self.originBrightness-diffY/100;
            if (brightness >= 1.0) {
                brightness = 1.0;
            }
            else if (brightness <= 0.0) {
                brightness = 0;
            }
            [[UIScreen mainScreen] setBrightness:brightness];
        }else if (self.touchMoveType == JXSliderTypeVolume) {
            //滑动音量
            CGFloat value = self.originBrightness-diffY/100;
            if (value >= 1.0) {
                value = 1.0;
            }
            else if (value <= 0.0) {
                value = 0;
            }
            [self volumeSlider].value = value;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.slideEnabled) {
        return;
    }
    if (touches.count == 1) { //单指滑动
        UITouch *touch = [touches anyObject];
        CGPoint movePoint = [touch locationInView:self];
        CGFloat diff = movePoint.x - self.touchBeganPoint.x;
        if (fabs(diff/10) > 5 && self.touchMoveType == JXSliderTypeSlide) { //大于5秒
            CGFloat curr = [self modifyValue:self.beginValue + diff/10 minValue:0 maxValue:self.durationValue];
            [self.delegate touchSlideView:self finishHorizonalSlide:curr];
        }
    }
    self.seekView.hidden = YES;
    [UIView animateWithDuration:3 animations:^{
        self.lightView.alpha = 0.0f;
    }];
    /*
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD keyWindow];
     */
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.slideEnabled) {
        return;
    }
    self.seekView.hidden = YES;
    [UIView animateWithDuration:3 animations:^{
        self.lightView.alpha = 0.0f;
    }];
    /*
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideHUDForView:keyWindow animated:YES];
     */
}

#pragma mark touch private

- (void)updateTouchMoveTypeByPoint:(CGPoint)movePoint {
    //判断横线滑动 竖向滑动
    CGFloat diffX = movePoint.x - self.touchBeganPoint.x;
    CGFloat diffY = movePoint.y - self.touchBeganPoint.y;
    if ((fabs(diffX) > 20 || fabs(diffY) > 20) && self.touchMoveType == JXSliderTypeUnknown) {
        
        if (fabs(diffX/diffY) > 1.7) {
            
            self.touchMoveType = JXSliderTypeSlide;
            self.beginValue = [self.delegate originValueForTouchSlideView:self];
            self.durationValue = [self.delegate durationValueForTouchSlideView:self];
            
        }else if (fabs(diffX/diffY) < 0.6) {
            if (self.touchBeganPoint.x < (self.bounds.size.width / 2)) { //调亮度
                //屏幕左侧
                self.touchMoveType = JXSliderTypeLight;
                self.originBrightness = [UIScreen mainScreen].brightness;
                UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
                self.lightView.alpha = 1.0f;
                [keyWindow insertSubview:self.lightView aboveSubview:self];
                [self.lightView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.height.width.equalTo(@155);
                    make.centerY.centerX.equalTo(keyWindow);
                }];
                
            }else {
                //屏幕右侧 //音量
                self.touchMoveType = JXSliderTypeVolume;
                self.originVolume = [self volumeSlider].value;
            }
        }
    }
}

- (CGFloat)modifyValue:(double)value minValue:(double)min maxValue:(double)max {
    value = value < min ? min : value;
    value = value > max ? max : value;
    
    return value;
}

#pragma mark - set get

- (JXAVPlayerSliderSeekView *)seekView {
    if (!_seekView) {
        _seekView = [[JXAVPlayerSliderSeekView alloc] init];
        _seekView.layer.cornerRadius = 10.f;
        _seekView.hidden = YES;
    }
    return _seekView;
}

- (JXAVPlayerSliderLightView *)lightView {
    if (!_lightView) {
        _lightView = [[JXAVPlayerSliderLightView alloc] init];
    }
    return _lightView;
}

- (MPVolumeView *)volumeView {
    if (!_volumeView) {
        _volumeView = [[MPVolumeView alloc] init];
    }
    return _volumeView;
}

- (UISlider *)volumeSlider {
    for (UIView *newView in self.volumeView.subviews) {
        if ([newView isKindOfClass:[UISlider class]]) {
            UISlider *slider = (UISlider *)newView;
            slider.hidden = YES;
            slider.autoresizesSubviews = NO;
            slider.autoresizingMask = UIViewAutoresizingNone;
            return (UISlider *)slider;
        }
    }
    return nil;
}


@end
//
//  JXAVPlayerSliderLightView
//  Pods
//
//  Created by DLM on 2017/4/26.
//
//亮度
@interface JXAVPlayerSliderLightView ()

//亮度文字
@property (strong, nonatomic) UILabel *titleLabel;
//亮度-sun imgView
@property (strong, nonatomic) UIImageView *lightView;
//进度条 -imgView
@property (strong, nonatomic) UIImageView *progressView;
//遮盖view 为了遮盖高度
@property (strong, nonatomic) UIView *coverView;

@end


@implementation JXAVPlayerSliderLightView
- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, 155, 155)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius  = 10;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor grayColor];
        [self setupSubviews];
        
        [self addObservers];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return self.bounds.size;
}

- (void)setupSubviews {
    
    //背景view
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
    toolbar.backgroundColor = [UIColor darkGrayColor];
    toolbar.alpha = 0.97;
    [self addSubview:toolbar];
    
    
    //亮度 -文字
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.mas_equalTo(@5);
        make.height.mas_equalTo(@30);
        make.width.equalTo(self);
    }];
    //亮度 imgView
    [self addSubview:self.lightView];
    [self.lightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.width.equalTo(@70);
    }];
   
    //进度条
    [self addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.offset(-15.f);
        make.left.offset(13.f);
        make.right.offset(-13.f);
        make.height.equalTo(@7);
    }];
    //添加遮罩 - 根据亮度 遮盖progressView 部分
    [self.progressView addSubview:self.coverView];
}

#pragma mark - kvo

- (void)addObservers {
    //添加监听
    /*
    UIScreen *screen = [UIScreen mainScreen];
    bjl_weakify(self);
    [self bjl_kvo:BJLMakeProperty(screen, brightness) observer:^BOOL(id  _Nullable now, id  _Nullable old, BJLPropertyChange * _Nullable change) {
        bjl_strongify(self);
        CGFloat brightness = MAX(0.0, MIN(1.0, screen.brightness));
        [self.coverView bjl_remakeConstraints:^(BJLConstraintMaker *make) {
            make.top.bottom.right.equal.to(@0);
            make.width.equalTo(self.progressView.bjl_width).multipliedBy(1.0 - brightness);
        }];
        return YES;
    }];
     */
}

#pragma mark - set get

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
        _titleLabel.textColor = [UIColor colorWithRed:0.25f green:0.22f blue:0.21f alpha:1.00f];
        _titleLabel.text = @"亮度";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)lightView {
    if (!_lightView) {
        _lightView = [UIImageView new];
        _lightView.image = [UIImage  imageNamed:@"ic_sun"];
    }
    return _lightView;
}

- (UIImageView *)progressView {
    if (!_progressView) {
        _progressView = [UIImageView new];
        _progressView.image = [UIImage imageNamed:@"ic_light"];
    }
    return _progressView;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [UIView new];
        _coverView.backgroundColor = [UIColor colorWithHexString:@"333333"];
    }
    return _coverView;
}

@end

//
//  JXAVPlayerSliderSeekView
//  Pods
//
//  Created by DLM on 2017/4/26.
//
//

@interface JXAVPlayerSliderSeekView ()
//标识 前进 或 后退 imgView
@property (strong, nonatomic) UIImageView *directImageView;
//展示拖动的时间
@property (strong, nonatomic) UILabel *timeLabel;

@end

@implementation JXAVPlayerSliderSeekView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.6];
        
        //标识图片
        [self addSubview:self.directImageView];
        [self.directImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(-10);
        }];
       
        
        //拖动时间展示
        [self addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.directImageView.mas_bottom).offset(5.f);
        }];
        
    }
    return self;
}

#pragma mark - public

- (void)resetRelTime:(long)relTime duration:(long)duration difference:(long)difference {
    if (difference > 0) {
        [self.directImageView setImage:[UIImage imageNamed:@"ic_forward"]];
    }
    else {
        [self.directImageView setImage:[UIImage imageNamed:@"ic_backward"]];
    }
    
    long seekTime = relTime + difference;
    seekTime = seekTime > 0 ? seekTime : 0;
    seekTime = seekTime < duration ? seekTime : duration;
    
    long seekHours = seekTime / 3600;
    int seekMinums = ((long long)seekTime % 3600) / 60;
    int seekSeconds = (long long)seekTime % 60;
    
    long totalHours = duration / 3600;
    int totalMinums = ((long long)duration % 3600) / 60;
    int totalSeconds = (long long)duration % 60;
    if (totalHours > 0) {
        self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02d:%02d / %02ld:%02d:%02d",
                               seekHours, seekMinums, seekSeconds, totalHours, totalMinums, totalSeconds];
    }
    else {
        self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d / %02d:%02d",
                               seekMinums, seekSeconds, totalMinums, totalSeconds];
    }
}

#pragma mark - set get

- (UIImageView *)directImageView {
    if (!_directImageView) {
        _directImageView = [[UIImageView alloc] init];
    }
    return _directImageView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14.f];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _timeLabel;
}

@end
