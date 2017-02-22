//
//  HeightCache.m
//  UITableviewHeightCache
//
//  Created by 李林泉 on 2017/2/21.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import "HeightCache.h"

@implementation HeightCache

//制作key
- (NSString *)makeKeyWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath{
    
    return [NSString stringWithFormat:@"%@S%ldR%ld",identifier,indexPath.section,indexPath.row];
    
}

//判断高度是否存在
- (BOOL)existInCacheByKey:(NSString *)key{
    NSNumber * value = [self.heightCacheDicCurrent objectForKey:key];
    return (value && ![value isEqualToNumber:@-1]);
}

//取出缓存的高度
- (CGFloat)heightFromCacheWithKey:(NSString *)key{
    NSNumber *value = [self.heightCacheDicCurrent objectForKey:key];
    return [value floatValue];
}

//缓存
- (void)cacheHieght:(CGFloat)hieght key:(NSString *)key{
    [self.heightCacheDicCurrent setObject:@(hieght) forKey:key];
}

//lazy
- (NSMutableDictionary *)heightCacheDicH{
    if (!_heightCacheDicH) {
        _heightCacheDicH = [[NSMutableDictionary alloc] init];
    }
    return _heightCacheDicH;
}

- (NSMutableDictionary *)heightCacheDicV{
    if (!_heightCacheDicV) {
        _heightCacheDicV = [[NSMutableDictionary alloc] init];
    }
    return _heightCacheDicV;
}

//根据横竖屏状态选择字典
- (NSMutableDictionary *)heightCacheDicCurrent{
    return UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)?self.heightCacheDicV:self.heightCacheDicH;
}

@end
