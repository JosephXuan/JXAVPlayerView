//
//  JXAVPlayerTopInfoView.m
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import "JXAVPlayerTopInfoView.h"
#import "JXAVPlayerView+publicHeader.h"//头文件

@interface JXAVPlayerTopInfoView ()
//预备状态栏（自己创建 获取系统的各种属性来赋值）目前为空
@property (nonatomic, strong)UIView * topStatusView;
//nav存放子布局
@property (nonatomic, strong)UIView * navContentView;
//返回按钮
@property (nonatomic, strong)UIButton * backBtn;
//标题
@property (nonatomic, strong)UILabel * titleLab;
//最右侧的按钮
@property (nonatomic, strong)UIButton * rightBtn;

@end
@implementation JXAVPlayerTopInfoView
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    
    
    //预备状态栏（自己创建 获取系统的各种属性来赋值）目前为空
    [self.topStatusView addSubview:self.topStatusView];
    [self.topStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(0);//STATUS_BAR_HEIGHT
        
    }];
    //nav存放子布局
    [self.topStatusView addSubview:self.navContentView];
    [self.navContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.equalTo(self.topStatusView.mas_bottom).offset(0);
        make.height.offset(42);
    }];
    
    //返回按钮
    [self.navContentView addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(self.navContentView.mas_centerY);
        make.width.offset(40);
        make.height.offset(40);
    }];
    [self.backBtn setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    
    //标题
    [self.navContentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backBtn.mas_right).offset(10);
        make.centerY.equalTo(self.backBtn.mas_centerY);
    }];
    self.titleLab.font = [UIFont systemFontOfSize:11.0f];
    self.titleLab.textColor = [UIColor whiteColor];
    
    //最右侧的按钮
    [self.navContentView addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(self.navContentView.mas_centerY);
    }];
    
}
#pragma mark --
-(void)setAction{
    
    //返回按钮点击
    [self.backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //右侧按钮点击
    [self.rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)backBtnClick:(UIButton *)btn{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(JXAVPlayerTopInfoView:clickedBackButton:)]) {
        [self.delegate JXAVPlayerTopInfoView:self clickedBackButton:btn];
    }
}

-(void)rightBtnClick:(UIButton *)btn{
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(JXAVPlayerTopInfoView:clickedRightButton:)]) {
        
        [self.delegate JXAVPlayerTopInfoView:self clickedRightButton:btn];
        
    }
    
}

//设置返回按钮 图片
-(void)setBackBtnImg:(UIImage *)backBtnImg{
    [self.backBtn setImage:backBtnImg forState:UIControlStateNormal];
}
//设置标题
-(void)setTitleStr:(NSString *)titleStr{
    
    self.titleLab.text = titleStr;
    
}
//设置右按钮 标题
-(void)setRightBtnTitleStr:(NSString *)rightBtnStr{
    [self.rightBtn setTitle:rightBtnStr forState:UIControlStateNormal];
}
//设置右按钮 图片
-(void)setRightBtnTitleImg:(UIImage *)rightBtnImg{
    [self.rightBtn setImage:rightBtnImg forState:UIControlStateNormal];
}

//获取左侧按钮
-(UIButton *)getBackBtn{
    
    return self.backBtn;
    
}

//获取标题
-(UILabel *)getTitleLab{
    
    return self.titleLab;
    
}

//获取右侧按钮
-(UIButton *)getRightBtn{
    
    return self.rightBtn;
    
}

//预备状态栏（自己创建 获取系统的各种属性来赋值）目前为空
-(UIView *)topStatusView{
    if (!_topStatusView) {
        _topStatusView = [[UIView alloc]init];
    }
    return _topStatusView;
}
-(UIView *)navContentView{
    if (!_navContentView) {
        _navContentView = [[UIView alloc]init];
    }
    return _topStatusView;
}
//返回按钮
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _backBtn;
}
//标题
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
    }
    return _titleLab;
}
//最右侧的按钮
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _rightBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
