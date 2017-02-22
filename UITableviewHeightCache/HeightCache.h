//
//  HeightCache.h
//  UITableviewHeightCache
//
//  Created by 李林泉 on 2017/2/21.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HeightCache : NSObject

@property (strong, nonatomic)NSMutableDictionary *heightCacheDicV; //竖直行高缓存字典
@property (strong, nonatomic)NSMutableDictionary *heightCacheDicH; //水平行高缓存字典
@property (strong, nonatomic)NSMutableDictionary *heightCacheDicCurrent; //当前行高缓存字典

//制作key
- (NSString *)makeKeyWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;

//判断高度是否存在
- (BOOL)existInCacheByKey:(NSString *)key;

//查找高度缓存
- (CGFloat)heightFromCacheWithKey:(NSString *)key;

//缓存
- (void)cacheHieght:(CGFloat)hieght key:(NSString *)key;

@end
