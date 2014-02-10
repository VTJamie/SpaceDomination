//
//  Fleet.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import "Fleet.h"
#import "Planet.h"
#import "Game.h"
#import "TouchBackgroundEvent.h"
#import "CenterChangeEvent.h"
#import "PlanetTouchEvent.h"

@implementation Fleet

- (id)initWithSide: (int) team
{
    if ((self = [super init]))
    {
        self.team = team;
        self.currentLoc = [[SPPoint alloc] init];

        [self setup];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)setup
{ 
    self.shipImage = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"ship"]];
    
    self.shipImage.pivotX = self.shipImage.width / 2.0;
    self.shipImage.pivotY = self.shipImage.height / 2.0;
    self.shipImage.x = 0;
    self.shipImage.y = 0;
    [self addChild:self.shipImage];
    
    self.x = Sparrow.stage.width / 2.0;
    self.y = Sparrow.stage.height / 2.0;

    if (self.team == 1)
    {
      //  [[Game instance] addEventListener:@selector(moveFleetThroughSpace:) atObject:self forType:EVENT_TYPE_MOVE_FLEET];
        [[Game instance] addEventListener:@selector(flyToPlanet:) atObject:self forType:EVENT_TYPE_PLANET_TOUCH];
    }
    
  //  [[Game instance] addEventListener:@selector(onCenterChange:) atObject:self forType:EVENT_TYPE_NEW_CENTER_TRIGGERED];
}

- (void) flyToPlanet: (PlanetTouchEvent*) planetevent
{
    self.x = planetevent.planet.x;
    self.y = planetevent.planet.y;
}

- (void) moveFleetThroughSpace: (TouchBackgroundEvent*) touchevent
{

//    self.currentLoc = [[Game instance] currentcenter];

   // self.x = touchevent.touchpoint.x - self.parent.x;
    //self.y = touchevent.touchpoint.y - self.parent.y;
    
//    self.currentLoc.x = self
}


@end
