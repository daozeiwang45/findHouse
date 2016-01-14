//
//  requestMutableDown.m
//  PAOFUAPP
//
//  Created by 学鸿 张 on 14-5-30.
//  Copyright (c) 2014年 Steven. All rights reserved.
//

#import "requestMutableDown.h"
#import <CommonCrypto/CommonDigest.h>
#import <SystemConfiguration/SystemConfiguration.h>
@implementation requestMutableDown
#define SourceId @"1"
+ (void)requestDownData:(NSMutableURLRequest *)request
{
    NSString * time = [self getDate];
    NSString * md5 = [self md5:[NSString stringWithFormat:@"weoiefladfieewe%@%@",time,SourceId]];
    md5 = [md5 substringWithRange:NSMakeRange(0, 30)];
    [request setValue:md5 forHTTPHeaderField:@"API-AuthKey"];
    [request setValue:time forHTTPHeaderField:@"API-AuthTime"];
    [request setValue:SourceId forHTTPHeaderField:@"API-SourceID"];
}

#pragma mark 获取时间和MD5转换
+ (NSString *) getDate
{
    // get date time 10
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval interVal = [date timeIntervalSince1970];
    NSString * str = [NSString stringWithFormat:@"%f", interVal];
    NSString * time = [str substringWithRange:NSMakeRange(0, 10)];
    return time;
}

+ (NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

@end
