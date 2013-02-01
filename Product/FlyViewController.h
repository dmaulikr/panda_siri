#import <UIKit/UIKit.h>
#import "iFlyISR/IFlyRecognizeControl.h"
#import "HelloWorldLayer.h"

#define APPID @"4f4cad2e"
#define ENGINE_URL @"http://dev.voicecloud.cn:1028/index.htm"
#define H_CONTROL_ORIGIN CGPointMake(1000, 700)


@interface FlyViewController : UIViewController <IFlyRecognizeControlDelegate>
{
    IFlyRecognizeControl *recognizer;
    NSString * _keywordID;
    UILabel * label;
    NSString * request;
    HelloWorldLayer *layer1;
    
}
-(void) start_record;
-(void) setLayer:(HelloWorldLayer *)l;
-(NSString *) sendRequest:(NSString *)st;
- (void)display;

@property(retain, nonatomic) IBOutlet UILabel *label;

@end
