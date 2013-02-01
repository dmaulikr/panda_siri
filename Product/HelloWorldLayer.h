#import <UIKit/UIKit.h>

#import "cocos2d.h"


@class FlyViewController;


@interface HelloWorldLayer : CCLayer
{
    FlyViewController *fly;
    NSMutableArray* templates;
    NSMutableArray* tiles;
	uint tilesPerSide;
}
+(CCScene *) scene;
-(id) settLabel:(NSString *)str;
-(void) ddd;
@property (retain, nonatomic) CCLabelTTF *label;
@end
