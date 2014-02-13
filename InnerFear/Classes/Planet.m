//
//  Planet.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import "Planet.h"
#import "CenterChangeEvent.h"
#import "PlanetTouchEvent.h"

#define ARC4RANDOM_MAX 0x100000000

@implementation Planet

- (id) initWithTeam: (int) team
{
    if ((self = [super init]))
    {
        self.team = team;
        self.underattack = NO;
        self.spaceLoc = [[SPPoint alloc] init];
        self.shipFactory = [[TimeFactory alloc] initWithTimeForUnit:1.0 unitSize:1];
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void) advanceTime: (double) passedTime
{
 //   NSLog(@"Planet Team: %d, %f", self.team, passedTime);
    [self advanceFactory:passedTime];
    [self advanceBattle:passedTime];
}

- (void) advanceBattle: (double) passedTime
{
    if (self.underattack)
    {
        
    }
}

- (void) advanceFactory: (double) passedTime
{
    if (!self.underattack)
    {
        int unit = [self.shipFactory getUnit:passedTime];
        if (unit > 0)
        {
            NSLog(@"SHIP GENERATED FIGHT!: %d", unit);
        }
    }
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
    self.planetimage.pivotX = self.planetimage.width / 2.0;
    self.planetimage.pivotY = self.planetimage.height / 2.0;
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
   // self.x -= event.change.x;
   // self.y -= event.change.y;
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
        PlanetTouchEvent* planettouch = [[PlanetTouchEvent alloc] initWithType:EVENT_TYPE_PLANET_TOUCH];
        planettouch.planet = self;
        [self dispatchEvent:planettouch];
    }
}


- (void) determineVisibility
{
    BOOL makevisible = YES;
    int x = self.x + self.parent.x - self.planetimage.width / 2.0;
    int y = self.y + self.parent.y - self.planetimage.height / 2.0;
    
    if (x > Sparrow.stage.width ||
        y > Sparrow.stage.height ||
        x + self.planetimage.width < 0 ||
        y + self.planetimage.height < 0) {
        makevisible = NO;
    }
    
    self.visible = makevisible;
}

@end
