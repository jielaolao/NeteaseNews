//
//  NetwordTool.h
//  网易新闻
//
//  Created by 杰佬 on 16/4/12.
//  Copyright © 2016年 魏明杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface NetworkTool : AFHTTPSessionManager
+ (instancetype)sharedNetworkTool;

@end
