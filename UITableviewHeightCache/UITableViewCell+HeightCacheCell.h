//
//  UITableViewCell+HeightCacheCell.h
//  UITableviewHeightCache
//
//  Created by 李林泉 on 2017/2/21.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (HeightCacheCell)

@property (assign, nonatomic)BOOL justForCalculate; //只用来计算的标志

@property (assign, nonatomic)BOOL noAuotSizeing; //不依靠约束计算，只进行自适应

@end
