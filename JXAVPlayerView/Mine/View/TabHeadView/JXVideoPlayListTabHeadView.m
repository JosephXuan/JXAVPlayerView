//
//  JXVideoPlayListTabHeadView.m
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import "JXVideoPlayListTabHeadView.h"

#import "JXAVPlayerView+publicHeader.h"//头文件
@interface JXVideoPlayListTabHeadView ()

@property(nonatomic,strong)UIImageView * imgView;

@property(nonatomic,strong)UIButton * playBtn;
@end

@implementation JXVideoPlayListTabHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupConfigureView];
        
    }
    return self;
}
-(void)setupConfigureView{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.imgView.backgroundColor = [UIColor grayColor];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1643446119,663503564&fm=26&gp=0.jpg"] placeholderImage:nil];
    
    
    [self addSubview:self.playBtn];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgView.mas_centerY);
        make.centerX.equalTo(self.imgView.mas_centerX);
        make.width.offset(40);
        make.height.offset(40);
    }];
    [self.playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBtn setImage:[UIImage imageNamed:@"course_play"] forState:UIControlStateNormal];
}
-(void)playBtnClick:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoPlayListTabHeadView:didClickPlayBtn:)]) {
        
        [self.delegate videoPlayListTabHeadView:self didClickPlayBtn:btn];
        
    }
}

-(void)setPlayBtnUIStatus:(NSInteger)status{
    // 1:展示 2:隐藏 默认展示
    if (1 == status) {
        //展示
        self.playBtn.hidden = NO;
    }else if (2 == status){
        //隐藏
        self.playBtn.hidden = YES;
        
    }
}
-(UIImageView * )imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}
-(UIButton * )playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _playBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
