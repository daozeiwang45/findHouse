
#import "MyThemeWebModel.h"
#import "requestMutableDown.h"
#import "NSString+UrlEncoding.h"
#import <SystemConfiguration/SystemConfiguration.h>
@implementation MyThemeWebModel
//-(void)myThemeWebCollectionWithMember_id:(NSString *)mid withTid:(NSString *)tid
//{
//    
//}
//
+ (BOOL)connectedToNetwork{
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_storage zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    
    zeroAddress.ss_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable&&!needsConnection) ? YES : NO;
}


+(void)BlockWithURL:(NSString *)url withSource:(NSString *)source withBlock:(Block)b
{
    if([self connectedToNetwork])
    {
      MyThemeWebModel *model = [[MyThemeWebModel alloc] init];
        model.block = b;
        NSURL *ConnectUrl = [NSURL URLWithString:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:ConnectUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
        [requestMutableDown requestDownData:request];
        [request setHTTPBody:[source dataUsingEncoding:NSUTF8StringEncoding]];
        //    [request setHTTPBody:[source URLEncodedString]];
        
        [request setHTTPMethod:@"POST"];
        //    NSLog(@"requestsss%@",request);
        NSURLConnection *connect = [NSURLConnection connectionWithRequest:request delegate:model];
        if (connect)
        {
            NSLog(@"创建成功");
        }
        else
        {
            NSLog(@"创建失败");
        }
    }
    else
    {
         [SVProgressHUD showErrorWithStatus:@"当前没有网络连接"];
    }
    
    
 }

/*
 公共接口 url 出了公共接口的URL部分
 param : 请求的参数字典 
 httpMethod : POST 或者 GET
 complateBlock: 请求完成回调的代码块
 */
+(void)requestWithUrl:(NSString *)url Params:(NSDictionary *)param httpMethod:(NSString *)httpMethod complateBlock:(FinishedBlock)block
{
    
        MyThemeWebModel * model = [[MyThemeWebModel alloc]init];
        model.finishedBlock = block;
    
        NSString * fullURL = [NSString stringWithFormat:@"%@%@",BASEURL,url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullURL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
        [requestMutableDown requestDownData:request];
    
        NSString * source = [self serializeParams:param];
        [request setHTTPBody:[source dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPMethod:httpMethod];
        [NSURLConnection connectionWithRequest:request delegate:model];
    
    
}
#pragma mark-Get方法
+(void)BlockWithGetURL:(NSString *)url withBlock:(Block)b
{
    if([self connectedToNetwork])
    {
      MyThemeWebModel *model = [[MyThemeWebModel alloc] init];
        model.block = b;
        NSURL *ConnectUrl = [NSURL URLWithString:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:ConnectUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
        [requestMutableDown requestDownData:request];
        //[request setHTTPBody:[source dataUsingEncoding:NSUTF8StringEncoding]];
        //    [request setHTTPBody:[source URLEncodedString]];
        //[request setHTTPMethod:@"POST"];
        //NSLog(@"requestsss%@",request);
        NSURLConnection *connect = [NSURLConnection connectionWithRequest:request delegate:model];
        if (connect)
        {
            NSLog(@"创建成功");
        }
        else
        {
            NSLog(@"创建失败");
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"当前没有网络连接"];
    }

   
}
+(NSString *)makeBase64StringWithParams:(NSDictionary *)params
{
    NSData * needBase64Data = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:nil];
    return [needBase64Data base64EncodedStringWithOptions:0];//base64Encoding];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (!self.data)
    {
        self.data = [NSMutableData data];
    }
    else
    {
        [self.data setLength:0];
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSString * dataStr = [[NSString alloc]initWithData:self.data encoding:NSUTF8StringEncoding];
    //NSLog(@"requestData : %@",dataStr);
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.data options:kNilOptions error:nil];
    if (self.block)
    {
        self.block(dict);
    }
    if (self.finishedBlock)
    {
        self.finishedBlock(dict);
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.block)
    {
        self.block(nil);
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
    }
    
    if (self.finishedBlock)
    {
        self.finishedBlock(nil);
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
    }
    
}


//拼接url   返回一个完整的url
+ (NSString *)serializeParams:(NSDictionary *)params
{
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [params keyEnumerator])
    {
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, params[key]]];
    }
    NSString* source = [pairs componentsJoinedByString:@"&"];//在字符串数组每个元素后面加上字符串
    
    return [NSString stringWithFormat:@"%@",source];
}
//异步下载数据
+(NSDictionary *)getAsyData:(NSString *)urlstr
{
    //NSLog(@"-------%@",urlstr);
    NSURL *url= [NSURL URLWithString:urlstr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 0) 网络访问超时时间
    [request setTimeoutInterval:10.0f];
    //异步方法
  __block NSDictionary *  dict;
   [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    {
        dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&connectionError];
    }
    }];
        return dict;    
}
#pragma mark GET
+(NSDictionary *)getSyData:(NSString *)urlstr
{
    if([self connectedToNetwork])
    {
        NSURL *url= [NSURL URLWithString:urlstr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        // 0) 网络访问超时时间
        [request setTimeoutInterval:10.0f];
        NSURLResponse *response = nil;
        // 同步操作没有完成，后面的代码不会执行
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
       return dict;
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"当前没有网络连接"];
        return nil;
    }
}
+(NSDictionary *)PostImagesToServer:(NSString *) strUrl dicPostParams:(NSMutableDictionary *)params dicImages:(NSMutableDictionary *) dicImages{
   // NSString * res;
    
    
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
    UIImage *image;//=[params objectForKey:@"pic"];
    //得到图片的data
    //NSData* data = UIImagePNGRepresentation(image);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [params allKeys];
    
    //遍历keys
    for(int i=0;i<[keys count];i++) {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        //if(![key isEqualToString:@"pic"]) {
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        //[body appendString:@"Content-Transfer-Encoding: 8bit"];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[params objectForKey:key]];
        //}
    }
    ////添加分界线，换行
    //[body appendFormat:@"%@\r\n",MPboundary];
    
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    //循环加入上传图片
    keys = [dicImages allKeys];
    for(int i = 0; i< [keys count] ; i++){
        //要上传的图片
        image = [dicImages objectForKey:[keys objectAtIndex:i ]];
        //得到图片的data
        NSData* data =  UIImageJPEGRepresentation(image, 0.0);
        NSMutableString *imgbody = [[NSMutableString alloc] init];
        //此处循环添加图片文件
        //添加图片信息字段
        //声明pic字段，文件名为boris.png
        //[body appendFormat:[NSString stringWithFormat: @"Content-Disposition: form-data; name=\"File\"; filename=\"%@\"\r\n", [keys objectAtIndex:i]]];
        
        ////添加分界线，换行
        [imgbody appendFormat:@"%@\r\n",MPboundary];
        [imgbody appendFormat:@"Content-Disposition: form-data; name=\"File%d\"; filename=\"%@.jpg\"\r\n", i, [keys objectAtIndex:i]];
        //声明上传文件的格式
        [imgbody appendFormat:@"Content-Type: application/octet-stream; charset=utf-8\r\n\r\n"];
        
        NSLog(@"上传的图片：%d  %@", i, [keys objectAtIndex:i]);
        
        //将body字符串转化为UTF8格式的二进制
        //[myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData appendData:[imgbody dataUsingEncoding:NSUTF8StringEncoding]];
        //将image的data加入
        [myRequestData appendData:data];
        [myRequestData appendData:[ @"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"%@\r\n",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"keep-alive" forHTTPHeaderField:@"connection"];
    //[request setValue:@"UTF-8" forHTTPHeaderField:@"Charsert"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    //建立连接，设置代理
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //设置接受response的data
    NSData *mResponseData;
    NSError *err = nil;
    mResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    
    if(mResponseData == nil){
        NSLog(@"err code : %@", [err localizedDescription]);
    }
    //res = [[NSString alloc] initWithData:mResponseData encoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:mResponseData options:kNilOptions error:nil];
    /*
     if (conn) {
     mResponseData = [NSMutableData data];
     mResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
     
     if(mResponseData == nil){
     NSLog(@"err code : %@", [err localizedDescription]);
     }
     res = [[NSString alloc] initWithData:mResponseData encoding:NSUTF8StringEncoding];
     }else{
     res = [[NSString alloc] init];
     }*/
   // NSLog(@"服务器返回：%@", res);
    return dict;
}




@end
