//
//  GamePieceContainer.m
//  SpaceDomination
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import "GamePieceContainer.h"
#import "Game.h"
#import "CenterChangeEvent.h"

@implementation GamePieceContainer

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
    // release any resources here
//    [Media releaseAtlas];
//    [Media releaseSound];
}

- (void)setup
{
        [[Game instance].playarea addEventListener:@selector(onCenterChange:) atObject:self forType:EVENT_TYPE_NEW_CENTER_TRIGGERED];
}

- (void) onCenterChange: (CenterChangeEvent*) event
{
    // NSLog(@"Center: %f, %f", event.center.x, event.center.y);
    self.x -= event.change.x;
    self.y -= event.change.y;
    //    [self determineVisibility];
    //   [self updateLocations];
    
}
@end
