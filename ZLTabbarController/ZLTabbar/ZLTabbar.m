//
//  ZLTabbar.m
//  ZLTabbarController
//
//  Created by YYKit on 2017/8/7.
//  Copyright © 2017年 kzkj. All rights reserved.
//

#import "ZLTabbar.h"
#import "UIView+Extension.h"

@interface ZLTabbar ()

@property (nonatomic,strong) UIButton *irregularItem;//不规则的按钮，可以放在在中间或者其它任意一个地方

@end

@implementation ZLTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //TODO:加载子视图
        [self createChildrenViews];
    }
    return self;
}

#pragma mark 创建子视图
- (void)createChildrenViews
{
    self.backgroundColor = [UIColor whiteColor];

    //TODO:去掉tabbar的分割线
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:[UIImage new]];

    self.irregularItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.irregularItem setBackgroundImage:[UIImage imageNamed:@"midBtn"] forState:UIControlStateNormal];
    [self.irregularItem setBackgroundImage:[UIImage imageNamed:@"midBtn"] forState:UIControlStateHighlighted];
    self.irregularItem.size = self.irregularItem.currentBackgroundImage.size;
    self.irregularItem.layer.masksToBounds = YES;
    self.irregularItem.layer.cornerRadius = self.irregularItem.width/2;
    [self.irregularItem addTarget:self action:@selector(irregularItemSelcted) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.irregularItem];
}

#pragma mark 执行不规则按钮的点击事件
- (void)irregularItemSelcted
{
    if (self.selectedIrrBtn)
    {
        self.selectedIrrBtn();
    }
}

- (void)didselectedIrrBtnWithBlock:(IrrBtnSelectedBlock)selectedIrrBtn
{
    self.selectedIrrBtn = selectedIrrBtn;
}


#pragma mark layoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];

    //TODO:重新排布系统按钮的位置，空出需要自定义按钮的位置，系统按钮的类型是UITabBarButton
    Class class = NSClassFromString(@"UITabBarButton");

    //TODO:这里设置自定义tabbarItem的位置
    self.irregularItem.centerX = (self.width * 0.75 + self.irregularItem.width * 0.75);
    self.irregularItem.centerY = self.height - self.irregularItem.height/2;

    NSInteger btnIndex = 0;
    for (UIView *btn in self.subviews)
    {
        if ([btn isKindOfClass:class])
        {
            //TODO:如果是系统的UITabBarButton，调整子控件位置，空出自定义UITabBarButton的位置
            //TODO:按钮宽度为Tabbar宽度平分4块
            btn.width = self.width/4;
            if (btnIndex < 3)
            {
                //TODO: -3- 在这里为irregularItem的索引值
                btn.x = btn.width * btnIndex;
            }
            else
            {
                btn.x = btn.width * btnIndex + self.irregularItem.width;
            }
            btnIndex ++;

            if (btnIndex == 0)
            {
                btnIndex ++;
            }
        }
    }
    [self bringSubviewToFront:self.irregularItem];
}

#pragma mark 重写hitTest方法，去监听irregularItem的点击，目的是为了让突出在外面的部分 在点击时也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    /**判断当前手指是否点击到了irregularItem。如果是，则相应按钮点击；如果是其它，则由系统处理**/
    //当前view是否被隐藏？如果隐藏，就不做其他处理了。
    if (self.isHidden == NO)
    {
        //TODO:将当前tabbar的触摸点转换成坐标系，转换到irregularItem的身上，生成一个新的点
        CGPoint new_point = [self convertPoint:point toView:self.irregularItem];

        //TODO:如果这个新的点是在irregularItem上，那么处理点点击事件最合适的view就是irregularItem
        if ([self.irregularItem pointInside:new_point withEvent:event])
        {
            return self.irregularItem;
        }
    }
    return [super hitTest:point withEvent:event];
}



@end
