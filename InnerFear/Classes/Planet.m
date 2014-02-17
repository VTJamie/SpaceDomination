//
//  Planet.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import "Planet.h"
#import "CenterChangeEvent.h"
#import "ZoomChangedEvent.h"
#import "PlanetTouchEvent.h"
#import "Sapphire.h"
#import "Babylon.h"
#import "Mako.h"


@implementation Planet

- (id) initWithTeam: (int) team X: (double) x Y: (double) y
{
    if ((self = [super init]))
    {
        self.team = team;
        self.underattack = NO;
        self.spaceLoc = [[SPPoint alloc] init];
        self.shipFactory = [[ShipFactory alloc] initWithTimeForUnit:1.0 unitSize:1];
        self.x = x;
        self.y = y;
        self.ships = [[NSMutableArray alloc] init];
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
        [self.ships addObjectsFromArray:[self.shipFactory getBuildUnits:passedTime]];
        SPEvent* shipbuiltevent = [[SPEvent alloc] initWithType:EVENT_TYPE_PLANET_FACTORY_UPDATE];
        [self dispatchEvent:shipbuiltevent];
    }
}

- (void) changeTeam: (int) newteam
{
    self.team = newteam;
    if (self.team == 1)
    {
        self.planetimage.color = 0x44FF44;
    }
    else if (self.team == 2)
    {
        self.planetimage.color = 0xFF4444;
    }
}

- (void)setup
{
   // Game* g = [Game instance];
    
    self.planetimage = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"monoplanet"]];
    if (self.team == 1)
    {
        self.planetimage.color = 0x44FF44;
    }
    else if (self.team == 2)
    {
        self.planetimage.color = 0xFF4444;
    }
    
    self.planetimage.pivotX = self.planetimage.width / 2.0;
    self.planetimage.pivotY = self.planetimage.height / 2.0;
    self.planetimage.x = 0;
    self.planetimage.y = 0;
    [self addChild:self.planetimage];
    //NSLog(@"%d", (arc4random() % 10) - 5);
    //self.x += (arc4random() % 10) - 5;
    //self.y += (arc4random() % 10) - 5;
    
    self.spaceLoc.x = self.x;
    self.spaceLoc.y = self.y;
    
    [self determineVisibility];
    [[Game instance] addEventListener:@selector(onCenterChange:) atObject:self forType:EVENT_TYPE_NEW_CENTER_TRIGGERED];
    
    [[Game instance] addEventListener:@selector(onZoomChanged:) atObject:self forType:EVENT_TYPE_NEW_ZOOM];
    
    [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
}

- (void) onCenterChange: (CenterChangeEvent*) event
{
    [self determineVisibility];
}

- (void) onZoomChanged: (ZoomChangedEvent*) event {
    [self determineVisibility];
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"%f, %f", self.spaceLoc.x, self.spaceLoc.y];
}

- (void) onTouch: (SPTouchEvent*) event {
//    SPTouch *drag = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] anyObject];
//    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    NSArray *endTouches = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    
    if ([endTouches count] == 1) {
        PlanetTouchEvent* planettouch = [[PlanetTouchEvent alloc] initWithType:EVENT_TYPE_PLANET_TOUCH];
        planettouch.planet = self;
        [self dispatchEvent:planettouch];
    }
}


- (void) determineVisibility
{
    BOOL makevisible = YES;
    double gamezoom = [[Game instance] overallscale];
    int x = (self.x + self.parent.x + [Game instance].x - self.planetimage.width / 2.0) * gamezoom;
    int y = (self.y + self.parent.y + [Game instance].y - self.planetimage.height / 2.0) * gamezoom;
    
    if (x > Sparrow.stage.width ||
        y > Sparrow.stage.height ||
        x + self.planetimage.width < 0 ||
        y + self.planetimage.height  < 0) {
        makevisible = NO;
    }

    self.visible = makevisible;
}

- (NSArray*) sapphireShips
{
    NSMutableArray* ships = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.ships.count; i++)
    {
        if ([[[self.ships objectAtIndex: i] class] isSubclassOfClass:[Sapphire class]])
        {
            [ships addObject:[self.ships objectAtIndex:i]];
        }
    }
    return ships;
}
- (NSArray*) babylonShips
{
    NSMutableArray* ships = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.ships.count; i++)
    {
        if ([[[self.ships objectAtIndex: i] class] isSubclassOfClass:[Babylon class]])
        {
            [ships addObject:[self.ships objectAtIndex:i]];
        }
    }

    return ships;
    
}
- (NSArray*) makoShips
{
    NSMutableArray* ships = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.ships.count; i++)
    {
        if ([[[self.ships objectAtIndex: i] class] isSubclassOfClass:[Mako class]])
        {
            [ships addObject:[self.ships objectAtIndex:i]];
        }
    }

    return ships;
    
}

- (Sapphire*) popSapphire
{
    for (int i = 0; i < self.ships.count; i++)
    {
        if ([[[self.ships objectAtIndex: i] class] isSubclassOfClass:[Sapphire class]])
        {
            Sapphire* ship = [self.ships objectAtIndex: i];
            [self.ships removeObjectAtIndex:i];
            return ship;
        }
    }
    return nil;
}
- (Babylon*) popBabylon
{
    for (int i = 0; i < self.ships.count; i++)
    {
        if ([[[self.ships objectAtIndex: i] class] isSubclassOfClass:[Babylon class]])
        {
            Babylon* ship = [self.ships objectAtIndex: i];
            [self.ships removeObjectAtIndex:i];
            return ship;
        }
    }
    return nil;
}
- (Mako*) popMako
{
    for (int i = 0; i < self.ships.count; i++)
    {
        if ([[[self.ships objectAtIndex: i] class] isSubclassOfClass:[Mako class]])
        {
            Mako* ship = [self.ships objectAtIndex: i];
            [self.ships removeObjectAtIndex:i];
            return ship;
        }
    }
    return nil;
}

@end
