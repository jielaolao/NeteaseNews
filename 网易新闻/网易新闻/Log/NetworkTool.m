//
//  NetwordTool.m
//  网易新闻
//
//  Created by 杰佬 on 16/4/12.
//  Copyright © 2016年 魏明杰. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool
+ (instancetype)sharedNetworkTool {
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/ad/"];
        instance = [[self alloc] initWithBaseURL:baseURL];
    });
    
    return instance;
}
@end
