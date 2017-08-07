//
//  RootViewController.m
//  ZLTabbarController
//
//  Created by YYKit on 2017/8/7.
//  Copyright © 2017年 kzkj. All rights reserved.
//

#import "ZLTabbarController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MidViewController.h"
#import "ResourceViewController.h"
#import "ZLTabbar.h"
@interface ZLTabbarController ()

@end

@implementation ZLTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabbar];
}

#pragma mark 设置tabbar
- (void)setupTabbar
{
    LeftViewController *left = [[LeftViewController alloc]init];
    [self createChildrenVC:left
           childrenVCTitle:@"首页"
                     image:[UIImage imageNamed:@"首页"]
             selectedImage:[UIImage imageNamed:@"首页_S"]];
    ResourceViewController *resource = [[ResourceViewController alloc]init];
    [self createChildrenVC:resource
           childrenVCTitle:@"资源"
                     image:[UIImage imageNamed:@"资源"]
             selectedImage:[UIImage imageNamed:@"资源_S"]];

    RightViewController *right = [[RightViewController alloc]init];
    [self createChildrenVC:right
           childrenVCTitle:@"个人中心"
                     image:[UIImage imageNamed:@"个人中心"]
             selectedImage:[UIImage imageNamed:@"个人中心_S"]];

    ZLTabbar *tabbar = [[ZLTabbar alloc]init];
    tabbar.selectedItem = left.tabBarItem;
    MidViewController *mid = [[MidViewController alloc]init];
    [tabbar didselectedIrrBtnWithBlock:^{
        [self presentViewController:mid animated:YES completion:nil];
    }];
    [self setValue:tabbar forKey:@"tabBar"];
}


#pragma mark 添加子控制器
- (void)createChildrenVC:(UIViewController *)childViewController
         childrenVCTitle:(NSString *)title
                   image:(UIImage *)image
           selectedImage:(UIImage *)selectedImg
{
    //设置选中时item的字体颜色
    UIColor *selectedTinColor = [UIColor colorWithRed:60.0/255
                                                green:160.0/255
                                                 blue:220.0/255
                                                alpha:1.0f];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:NSForegroundColorAttributeName
                                                                                  forKey:selectedTinColor]
                                             forState:UIControlStateSelected];

    //设置未选中的image
    UIImage *deselectedImage = image;
    deselectedImage = [deselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childViewController.tabBarItem.image = deselectedImage;

    //设置选中的image
    UIImage *selectedImage = selectedImg;
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childViewController.tabBarItem.selectedImage = selectedImage;

    //设置tabbarItem文字和图标 之间的距离
    childViewController.tabBarItem.title = title;
//    childViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);

    //添加控制器对象
    UINavigationController *childNavigationContorller  = [[UINavigationController alloc]initWithRootViewController:childViewController];
    [self addChildViewController:childNavigationContorller];
}


@end
