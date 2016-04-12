//
//  Headline.h
//  网易新闻
//
//  Created by 杰佬 on 16/4/12.
//  Copyright © 2016年 魏明杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Headline : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgsrc;

+ (instancetype)headlineWithDic:(NSDictionary *)dic;
+ (void)headlineWithSuccess:(void (^)(NSArray *))success failed:(void (^)(NSError *))failed;
@end
