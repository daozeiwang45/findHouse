//
//  ShareViewController.m
//  FindHouse
//
//  Created by admin on 16/1/4.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ShareViewController.h"
#import "bxViewAdditions.h"
#import <pop/POP.h>

@interface ShareViewController ()

@property (nonatomic, strong) UIButton *qzoneBtn,*qqBtn,*friendBtn,*wechatBtn;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        
        self.view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:blur];
        view.frame = self.view.bounds;
        [self.view insertSubview:view atIndex:0];
    }else {
         self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.75];
    }
    
    _wechatBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _wechatBtn.tag = 1;
    _wechatBtn.left  = self.view.left+15;
    _wechatBtn.bottom = self.view.bottom - 125;
    [_wechatBtn setBackgroundImage:[UIImage imageNamed:@"shareWechat"] forState:UIControlStateNormal];
    [_wechatBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wechatBtn];

    _friendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _friendBtn.tag = 2;
    _friendBtn.left  = self.view.left+15;
    _friendBtn.bottom = _wechatBtn.top - 10;
    [_friendBtn setBackgroundImage:[UIImage imageNamed:@"shareFriends"] forState:UIControlStateNormal];
    [_friendBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_friendBtn];

    _qqBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _qqBtn.tag = 3;
    _qqBtn.left  = self.view.left+15;
    _qqBtn.bottom = _friendBtn.top - 10;
    [_qqBtn setBackgroundImage:[UIImage imageNamed:@"shareQQ"] forState:UIControlStateNormal];
    [_qqBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_qqBtn];

    _qzoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _qzoneBtn.tag = 4;
    _qzoneBtn.left  = self.view.left+15;
    _qzoneBtn.bottom = _qqBtn.top- 10;
    [_qzoneBtn setBackgroundImage:[UIImage imageNamed:@"shareQzone"] forState:UIControlStateNormal];
    [_qzoneBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_qzoneBtn];

    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tapGR];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    // mask animation
//    CGPathRef fromPath = [UIBezierPath bezierPathWithOvalInRect:_wechatBtn.frame].CGPath;
//    CGFloat toRadius = sqrt(self.view.width*self.view.width + self.view.height*self.view.height);
//    CGRect toRect = CGRectMake(_wechatBtn.centerX-toRadius, _wechatBtn.centerY-toRadius, toRadius*2, toRadius*2);
//    CGPathRef toPath = [UIBezierPath bezierPathWithOvalInRect:toRect].CGPath;
//    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.path = fromPath;
//    self.view.layer.mask = maskLayer;
//    
//    [CATransaction begin];
//    maskLayer.path = toPath;
//    [CATransaction commit];
//    
//    CABasicAnimation *a = [CABasicAnimation animationWithKeyPath:@"path"];
//    a.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    a.fromValue = (__bridge id)fromPath;
//    a.toValue = (__bridge id)toPath;
//    a.duration = .4;
//    a.delegate = self;
//    [maskLayer addAnimation:a forKey:nil];
//    // mask animation
//    
//    double delayInSeconds2 = .1;
//    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds2 * NSEC_PER_SEC);
//    dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
//        [self showMenu:YES];
//    });
}

//MARK: private methods
- (void)shareAction:(UIButton *)btn {
    if (btn.tag == 1) {
        NSLog(@"微信分享");
    }else if (btn.tag == 2){
        NSLog(@"朋友圈分享");
    }else if (btn.tag == 3){
        NSLog(@"QQ分享");
    }else {
        NSLog(@"空间分享");
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.view.layer.mask = nil;
}

- (void)showMenu:(BOOL)show
{
    if (show)
    {

        POPSpringAnimation *a1 = [POPSpringAnimation animation];
        a1.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
        a1.toValue = @(_wechatBtn.centerY);
        a1.springBounciness = 16;
        a1.springSpeed = 10;
        [_wechatBtn.layer pop_addAnimation:a1 forKey:nil];
        
        POPSpringAnimation *a2 = [POPSpringAnimation animation];
        a2.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
        a2.toValue = @(_wechatBtn.centerY-60);
        a2.springBounciness = 16;
        a2.springSpeed = 10;
        [_friendBtn.layer pop_addAnimation:a2 forKey:nil];
        
        POPSpringAnimation *a3 = [POPSpringAnimation animation];
        a3.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
        a3.toValue = @(_wechatBtn.centerY-120);
        a3.springBounciness = 16;
        a3.springSpeed = 10;
        [_qqBtn.layer pop_addAnimation:a3 forKey:nil];
        
        POPSpringAnimation *a4 = [POPSpringAnimation animation];
        a4.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
        a4.toValue = @(_wechatBtn.centerY-180);
        a4.springBounciness = 16;
        a4.springSpeed = 10;
        [_qzoneBtn.layer pop_addAnimation:a4 forKey:nil];
        
    }
    else
    {
        POPBasicAnimation *a1 = [POPBasicAnimation animation];
        a1.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
        a1.toValue = @(_wechatBtn.centerY);
        a1.duration = .3f;
        [_wechatBtn.layer pop_addAnimation:a1 forKey:nil];
        
        POPBasicAnimation *a2 = [POPBasicAnimation animation];
        a2.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
        a2.toValue = @(_wechatBtn.centerY);
        a2.duration = .3f;
        [_friendBtn.layer pop_addAnimation:a2 forKey:nil];
        
        POPBasicAnimation *a3 = [POPBasicAnimation animation];
        a3.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
        a3.toValue = @(_wechatBtn.centerY);
        a3.duration = .3f;
        [_qqBtn.layer pop_addAnimation:a3 forKey:nil];
        
        POPBasicAnimation *a4 = [POPBasicAnimation animation];
        a4.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
        a4.toValue = @(_wechatBtn.centerY);
        a4.duration = .3f;
        [_qzoneBtn.layer pop_addAnimation:a4 forKey:nil];
        
        POPBasicAnimation *a5 = [POPBasicAnimation animation];
        a5.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
        a5.toValue = @(0);
        a5.duration = .3f;
        [a5 setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
            [self dismissViewControllerAnimated:NO completion:^{}];
        }];

        [self.view pop_addAnimation:a5 forKey:nil];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tr
{
    [self showMenu:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
