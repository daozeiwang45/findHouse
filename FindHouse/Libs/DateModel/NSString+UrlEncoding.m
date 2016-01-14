
//
//  NSString+UrlEncoding.m
//  PAOFUAPP
//
//  Created by Users on 14-6-30.
//  Copyright (c) 2014年 Steven. All rights reserved.
//

#import "NSString+UrlEncoding.h"

@implementation NSString (UrlEncoding)
- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}
@end
