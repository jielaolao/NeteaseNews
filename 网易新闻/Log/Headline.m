//
//  Headline.m
//  网易新闻
//
//  Created by 杰佬 on 16/4/12.
//  Copyright © 2016年 魏明杰. All rights reserved.
//

#import "Headline.h"
#import "NetworkTool.h"

@implementation Headline
+ (instancetype)headlineWithDic:(NSDictionary *)dic {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dic];
    
    return obj;
}
+ (void)headlineWithSuccess:(void (^)(NSArray *))success failed:(void (^)(NSError *))failed  {
    [[NetworkTool sharedNetworkTool] GET:@"headline/0-4.html" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
//        NSLog(@"responseObject = %@",responseObject);
        NSString *key = responseObject.keyEnumerator.nextObject;
        NSArray *headlines = responseObject[key];
        NSMutableArray *arrayM = [NSMutableArray array];
        [headlines enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrayM addObject:[Headline headlineWithDic:obj]];
        }];
        success(arrayM);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        failed(error);
    }];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}
@end
