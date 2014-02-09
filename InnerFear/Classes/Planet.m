//
//  Planet.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import "Planet.h"
#import "CenterChangeEvent.h"

#define ARC4RANDOM_MAX 0x100000000

@implementation Planet

- (id) initWithTeam: (int) team
{
    if ((self = [super init]))
    {
        self.team = team;
        self.spaceLoc = [[SPPoint alloc] init];
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void) changeTeam: (int) newteam
{
    self.team = newteam;
    [self removeChild: self.planetimage];
    self.planetimage = [[SPImage alloc] initWithTexture:[Media atlasTexture:[NSString stringWithFormat:@"planet%d", self.team]]];
    self.planetimage.pivotX = 0;
    self.planetimage.pivotY = 0;
    self.planetimage.x = 0;
    self.planetimage.y = 0;
    [self addChild:self.planetimage];

}

- (void)setup
{
    Game* g = [Game instance];
    
    self.planetimage = [[SPImage alloc] initWithTexture:[Media atlasTexture:[NSString stringWithFormat:@"planet%d", self.team]]];
    self.planetimage.pivotX = 0;
    self.planetimage.pivotY = 0;
    self.planetimage.x = 0;
    self.planetimage.y = 0;
    [self addChild:self.planetimage];
    
    self.x = ((double)arc4random() / ARC4RANDOM_MAX) * ((g.maxX - g.minX - Sparrow.stage.width / 2.0)) + g.minX + Sparrow.stage.width / 2.0;
    self.y = ((double)arc4random() / ARC4RANDOM_MAX) * ((g.maxY - g.minY - Sparrow.stage.height / 2.0)) + g.minY + Sparrow.stage.height / 2.0;
    self.spaceLoc.x = self.x;
    self.spaceLoc.y = self.y;
    
    [self determineVisibility];
    [[Game instance] addEventListener:@selector(onCenterChange:) atObject:self forType:EVENT_TYPE_NEW_CENTER_TRIGGERED];
    
    [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
}

- (void) onCenterChange: (CenterChangeEvent*) event
{
    // NSLog(@"Center: %f, %f", event.center.x, event.center.y);
    self.x -= event.change.x;
    self.y -= event.change.y;
    [self determineVisibility];
    //   [self updateLocations];
    
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"%f, %f", self.spaceLoc.x, self.spaceLoc.y];
}

- (void) onTouch: (SPTouchEvent*) event {
//    SPTouch *drag = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] anyObject];
//    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    SPTouch *endTouch = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] anyObject];
    
    if (endTouch) {
        if(self.team == 1) {
            [self changeTeam:2];
        }
        else {
            [self changeTeam:1];
        }
    }
}


- (void) determineVisibility
{
    BOOL makevisible = YES;
    
    
    if (self.x > Sparrow.stage.width ||
        self.y > Sparrow.stage.height ||
        self.x + self.planetimage.width < 0 ||
        self.y + self.planetimage.height < 0) {
        makevisible = NO;
    }
    
    self.visible = makevisible;
}

@end
