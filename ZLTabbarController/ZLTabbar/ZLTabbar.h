//
//  ZLTabbar.h
//  ZLTabbarController
//
//  Created by YYKit on 2017/8/7.
//  Copyright © 2017年 kzkj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IrrBtnSelectedBlock)();
@interface ZLTabbar : UITabBar

//用于监听自定义tabbarButton的点击事件
@property (nonatomic,copy) IrrBtnSelectedBlock selectedIrrBtn;
- (void)didselectedIrrBtnWithBlock:(IrrBtnSelectedBlock)selectedIrrBtn;

@end
