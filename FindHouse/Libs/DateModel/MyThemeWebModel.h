
#import <Foundation/Foundation.h>
#define MyThemeCollectionUrl @"http://jrapi.soshow.org/nxapi.php/Forum/add_favorite"
#define BASEURL @"http://jrapi.soshow.org/nxapi.php/"
typedef void(^Block)(NSDictionary *results);
typedef void(^FinishedBlock)(id results);

@interface MyThemeWebModel : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
@property (nonatomic,copy) Block block;
@property (nonatomic,copy) FinishedBlock finishedBlock;
@property (nonatomic,strong) NSMutableData *data;
+(void)BlockWithURL:(NSString *)url withSource:(NSString *)source withBlock:(Block)block;

//新的网络请求方法.不需要自己拼接参数
+(void)requestWithUrl:(NSString *)url Params:(NSDictionary *)param httpMethod:(NSString *)httpMethod complateBlock:(FinishedBlock)block;
+(void)BlockWithGetURL:(NSString *)url withBlock:(Block)b;
+(NSString *)makeBase64StringWithParams:(NSDictionary *)params;
+(NSDictionary *)getAsyData:(NSString *)urlstr;
+(NSDictionary *)getSyData:(NSString *)urlstr;
+(NSDictionary *)PostImagesToServer:(NSString *) strUrl dicPostParams:(NSMutableDictionary *)params dicImages:(NSMutableDictionary *) dicImages;



@end
