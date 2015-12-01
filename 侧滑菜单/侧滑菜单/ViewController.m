//
//  ViewController.m
//  侧滑菜单
//
//  Created by qingyun on 15/11/30.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import "CenterViewController.h"
#import "UIView+MJ.h"

#define MenuWidth 150

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化自控制器
    //1.1左侧菜单
    MenuViewController *menuVC = [[MenuViewController alloc] init];
    menuVC.view.width = MenuWidth;
    [self.view addSubview:menuVC.view];
    [self addChildViewController:menuVC];
    
    //1.2中间内容
    CenterViewController *centerVC = [[CenterViewController alloc] init];
    centerVC.view.frame = self.view.bounds;
    [self.view addSubview:centerVC.view];
    [self addChildViewController:centerVC];
    
    //2.监听手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragCenterView:)];
    [centerVC.view addGestureRecognizer:pan];
}

//用x判断
- (void)dragCenterView:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    //结束拖拽
    if (pan.state == UIGestureRecognizerStateCancelled ||
        pan.state == UIGestureRecognizerStateEnded) {
        if (pan.view.x >= MenuWidth * 0.5) {//往右至少150
            [UIView animateWithDuration:0.5 animations:^{
                pan.view.transform = CGAffineTransformMakeTranslation(MenuWidth, 0);
            }];
        } else { //走动的距离没有达到一般
            [UIView animateWithDuration:0.5 animations:^{
                pan.view.transform = CGAffineTransformIdentity;
            }];
        }
    }else {//正在拖拽中
        
        pan.view.transform = CGAffineTransformTranslate(pan.view.transform, point.x, 0);
        [pan setTranslation:CGPointZero inView:pan.view];
        if (pan.view.x >= MenuWidth) {
            pan.view.transform = CGAffineTransformMakeTranslation(MenuWidth, 0);
        }else if(pan.view.x <= 0) {
            pan.view.transform = CGAffineTransformIdentity;
        }
    }
}


@end
