//
//  UITableView+HeightCache.h
//  UITableviewHeightCache
//
//  Created by 李林泉 on 2017/2/21.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeightCache.h"

@interface UITableView (HeightCache)

@property (strong, nonatomic) HeightCache *heightCache;

//供外部调用
- (CGFloat)LLQ_CalculateCellWithIdentifer:(NSString *)identifier indexPath:(NSIndexPath *)indexPath configuration:(void(^)(id cell))configuration;

@end
