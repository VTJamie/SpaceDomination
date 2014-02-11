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
#import "PlanetMenu.h"

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
    //Create the corresponding tween and feed him the door object,
    //state the time it takes to close and the final value for Y.
    //In our case this is 0, since we want the door to shut
    //completely.
    
    if(self.currenttween)
    {
        [[Sparrow juggler] removeObjectsWithTarget:self];
    }
    
    self.currenttween = [SPTween tweenWithTarget:self
                                         time:4.0f transition:SP_TRANSITION_LINEAR];

    
    //Tell the tween that it should transition the Y value to 0.
    [self.currenttween animateProperty:@"x" targetValue:planetevent.planet.x];
    [self.currenttween animateProperty:@"y" targetValue:planetevent.planet.y];
    
    __block Fleet* that = self;
    __block Planet* thatplanet = planetevent.planet;
    
    self.currenttween.onComplete = ^{
        [[Game instance] addChild:[[PlanetMenu alloc] initWithPlanet:thatplanet]];
        that.currenttween = nil;
    };
    //Register the tween at the nearest juggler.
    //(We will come back to jugglers later.)
    [[Sparrow juggler] addObject:self.currenttween];
    
//    self.x = planetevent.planet.x;
  //  self.y = planetevent.planet.y;
}

- (void) moveFleetThroughSpace: (TouchBackgroundEvent*) touchevent
{

//    self.currentLoc = [[Game instance] currentcenter];

   // self.x = touchevent.touchpoint.x - self.parent.x;
    //self.y = touchevent.touchpoint.y - self.parent.y;
    
//    self.currentLoc.x = self
}


@end
