//
//  UITableView+HeightCache.m
//  UITableviewHeightCache
//
//  Created by 李林泉 on 2017/2/21.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import "UITableView+HeightCache.h"
#import "UITableViewCell+HeightCacheCell.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation UITableView (HeightCache)

#pragma mark ------ 工具方法
//获取一个用于计算高度的Cell
- (__kindof UITableViewCell *)LLQ_CalculateCellWithIdentifier:(NSString *)identifier{
    
    if (!identifier.length) {
        return nil;
    }
    
    //runtime获取一个存储cell的字典
    NSMutableDictionary <NSString *, UITableViewCell *> *dicForTheUniqueCalCell = objc_getAssociatedObject(self, _cmd);
    //如果取不到，就绑定一个
    if (!dicForTheUniqueCalCell) {
        dicForTheUniqueCalCell = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, _cmd, dicForTheUniqueCalCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    //取出cell，从绑定的字典取用
    UITableViewCell *cell = dicForTheUniqueCalCell[identifier];
    if (!cell) {
        cell = [self dequeueReusableCellWithIdentifier:identifier];
        cell.contentView.translatesAutoresizingMaskIntoConstraints = NO; //设置为NO才能用代码使用AutoLayout
        cell.justForCalculate = YES; //设置只计算
        dicForTheUniqueCalCell[identifier] = cell;
    }
    
    return cell;
    
}

//计算cell高度
- (CGFloat)LLQ_CalculateCellHeightWithCell:(UITableViewCell *)cell{
    
    CGFloat width = self.bounds.size.width;
    
    //根据辅助视图，调整宽度
    if (cell.accessoryView) {
        width -= cell.accessoryView.bounds.size.width + 16;
    }
    else{
        static const CGFloat accessoryWith[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
        };
        width -= accessoryWith[cell.accessoryType];
    }
    
    CGFloat height = 0;
    
    //非自适应模式，添加约束后计算约束后高度
    if (!cell.noAuotSizeing && width>0) {
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
        [cell.contentView addConstraint:widthConstraint];
        //根据约束计算高度
        height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        [cell.contentView removeConstraint:widthConstraint]; //移除约束
    }
    
    //如果约束添加错误，可能导致计算结果为0，则采用自适应模式计算约束
    if (height == 0) {
        height = [cell sizeThatFits:CGSizeMake(width, 0)].height;
    }
    
    //还是为0，默认高度
    if (height == 0) {
        height = 44;
    }
    
    if (self.separatorStyle != UITableViewCellSeparatorStyleNone) {
        height += 1.0/[UIScreen mainScreen].scale;
    }
    
    return height;
}

//取出cell并对cell进行操作，然后计算高度
- (CGFloat)LLQ_CalculateCellWithIdentifier:(NSString *)identifier configuration:(void(^)(id cell))configuration{
    
    if (!identifier.length) {
        return 0;
    }
    UITableViewCell *cell = [self LLQ_CalculateCellWithIdentifier:identifier];
    [cell prepareForReuse]; //放回重用池
    if (configuration) {
        configuration(cell);
    }
    
    return [self LLQ_CalculateCellHeightWithCell:cell];
    
}

//供外部调用的方法
- (CGFloat)LLQ_CalculateCellWithIdentifer:(NSString *)identifier indexPath:(NSIndexPath *)indexPath configuration:(void(^)(id cell))configuration{
    
    if (self.bounds.size.width != 0) {
        if (!identifier.length || !indexPath) {
            return 0;
        }
        NSString *key = [self.heightCache makeKeyWithIdentifier:identifier indexPath:indexPath];
        if ([self.heightCache existInCacheByKey:key]) {  //如果有缓存，就取出缓存
            return [self.heightCache heightFromCacheWithKey:key]; //从字典中取出高度
        }
        //没有缓存，计算缓存
        CGFloat height = [self LLQ_CalculateCellWithIdentifier:identifier configuration:configuration];
        //并进行缓存
        [self.heightCache cacheHieght:height key:key];
        return height;
    }
    
    return 0;
}

#pragma mark ------ 绑定属性

- (HeightCache *)heightCache{
    HeightCache *cache = objc_getAssociatedObject(self, _cmd);
    if (!cache) {
        cache = [[HeightCache alloc] init];
        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cache;
}

- (void)setHeightCache:(HeightCache *)heightCache{
    
    objc_setAssociatedObject(self, @selector(heightCache), heightCache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

@end
