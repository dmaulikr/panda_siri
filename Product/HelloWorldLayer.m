#import "HelloWorldLayer.h"
#import "FlyViewController.h"



// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize label;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	return scene;
}

-(void) create_buttonlabel
{
    CCLabelTTF *tlabel = [CCLabelTTF labelWithString:@"321" fontName:@"Marker Felt" fontSize:64];
    CCMenuItemLabel *labelItem = [CCMenuItemLabel itemWithLabel:tlabel target:self selector:@selector(click_event)];
    CCMenu *menu = [CCMenu menuWithItems:labelItem, nil];
    [menu alignItemsHorizontally];
    [self addChild:menu];
    
    self.label = [CCLabelTTF labelWithString:@"我 (2012-03-16 22:04:21):这是怎么回事呢" fontName:@"Marker Felt" fontSize:21];
    [self addChild:self.label];
    label.position = CGPointMake(20, 70);
}
// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init])) {

        [self create_buttonlabel];
        
        fly = [[FlyViewController alloc] initWithNibName:@"FlyViewController" bundle:nil];
        [fly.view setFrame:CGRectMake(0, 0, 0, 0)];
      //  [[[CCDirector sharedDirector] openGLView] addSubview:fly.view];  
        
        
        tiles = [[NSMutableArray array] retain];
        templates = [[NSMutableArray array] retain];
        tilesPerSide = 1;
        
	}
	return self;
}


-(id)click_event
{
    [fly setLayer:self];
    
    //[fly start_record];
}

-(void) ddd
{
    [self settLabel:@"333"];
}
-(id) settLabel:(NSString *)str
{
    NSString * ts = [NSString stringWithFormat:@"%@", str];
    NSLog(@"ts: %s", ts);
    [self.label setString:@"321"];
}

- (void) dealloc{[super dealloc];}

@end
