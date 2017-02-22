//
//  UITableViewCell+HeightCacheCell.m
//  UITableviewHeightCache
//
//  Created by 李林泉 on 2017/2/21.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import "UITableViewCell+HeightCacheCell.h"
#import <objc/runtime.h>

@implementation UITableViewCell (HeightCacheCell)


#pragma mark ------ 绑定属性

//justForCall
- (void)setJustForCalculate:(BOOL)justForCalculate{
    objc_setAssociatedObject(self, @selector(justForCalculate), @(justForCalculate), OBJC_ASSOCIATION_RETAIN); //使用get方法名作为key
}

- (BOOL)justForCalculate{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

//noAuotSizeing
- (void)setNoAuotSizeing:(BOOL)noAuotSizeing{
    objc_setAssociatedObject(self, @selector(noAuotSizeing), @(noAuotSizeing), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)noAuotSizeing{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
