//
//  Planet.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import "Planet.h"
#import "CenterChangeEvent.h"

@implementation Planet



- (id)init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)setup
{
    SPImage* image = [[SPImage alloc] initWithTexture:[Media atlasTexture:[NSString stringWithFormat:@"planet%d", arc4random() % 2 + 1]]];
    image.pivotX = 0;
    image.pivotY = 0;
    image.x = arc4random() % 2000 - 1000;
    image.y = arc4random() % 2000 - 1000;
    [self addChild:image];
    
    [[Game instance] addEventListener:@selector(onCenterChange:) atObject:self forType:EVENT_TYPE_NEW_CENTER_TRIGGERED];
    
}

- (void) onCenterChange: (CenterChangeEvent*) event
{
    // NSLog(@"Center: %f, %f", event.center.x, event.center.y);
    self.x -= event.center.x;
    self.y -= event.center.y;
    //   [self updateLocations];
}

@end
