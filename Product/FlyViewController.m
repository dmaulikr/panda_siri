#import "FlyViewController.h"
#import <UIKit/UIKit.h>


@implementation FlyViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self create_recognizer];
}


- (void)didReceiveMemoryWarning{[super didReceiveMemoryWarning];}



- (void)create_recognizer
{
    NSString *initParam = [[NSString alloc] initWithFormat:
						   @"server_url=%@,appid=%@",ENGINE_URL,APPID];
    
	// 识别控件
	recognizer = [[IFlyRecognizeControl alloc] initWithOrigin:H_CONTROL_ORIGIN theInitParam:initParam];
	[self.view addSubview:recognizer];
	[recognizer setEngine:@"sms" theEngineParam:nil theGrammarID:nil];
	[recognizer setSampleRate:16000];
	recognizer.delegate = self;
	[initParam release];
}
-(void)start_record
{
    [recognizer start];
}

- (void)onRecognizeEnd:(IFlyRecognizeControl *)iFlyRecognizeControl theError:(SpeechError) error{}

- (void)onUpdateTextView:(NSString *)sentence{}


- (void)onRecognizeResult:(NSArray *)array
{
	[self performSelectorOnMainThread:@selector(onUpdateTextView:) withObject:[array objectAtIndex:0] waitUntilDone:YES];
}

- (void)onKeywordResult:(NSArray*)array
{
	NSMutableString *sentence = [[[NSMutableString alloc] init] autorelease];
	
	for (int i = 0; i < [array count]; i++)
	{
		[sentence appendFormat:@"%@		置信度:%@\n",[[array objectAtIndex:i] objectForKey:@"NAME"],
		 [[array objectAtIndex:i] objectForKey:@"SCORE"]];
	}
	[self performSelectorOnMainThread:@selector(onUpdateTextView:) withObject:sentence waitUntilDone:YES];
	
	NSLog(@"keyword result : %@", sentence);
}
- (NSString *)urlEncodeValue:(NSString *)str
{
    NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
    return result;
}
-(NSString *) sendRequest:(NSString *)st
{
    NSMutableData *responseData = [NSMutableData data];
    NSString *astring = @"http://uwen.com/uwenIm/s?id=200001&status=puretext&format=default&question=";
    NSString *tr = [NSString stringWithFormat:@"%@%@", astring, [self urlEncodeValue:st]];
    NSLog( @"tr: %@", tr);
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:tr]];
    responseData = [NSURLConnection sendSynchronousRequest:Request returningResponse:nil error:nil];
    if (responseData != nil )
    {
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];        
        NSLog(@"%@", responseString);
        return responseString;
    }
}
- (void)onResult:(IFlyRecognizeControl *)iFlyRecognizeControl theResult:(NSArray *)resultArray
{
    [_keywordID release];
    _keywordID = [[resultArray objectAtIndex:0] retain];
    request = [[resultArray objectAtIndex:0] objectForKey:@"NAME"];
    NSLog(@"log:                %@", request);
    NSString *response = [self sendRequest:request];
    [self display];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{return (interfaceOrientation == UIInterfaceOrientationPortrait);}


-(void) setLayer:(HelloWorldLayer *)l
{
    layer1 = l;
}
-(void) display
{
    [layer1 ddd];
}

@end
