//
//  BattleMenu.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/16/14.
//
//

#import "BattleMenu.h"
#import "Planet.h"
#import "PlanetMenu.h"

@implementation BattleMenu

- (id)initWithPlanet: (Planet*) planet
{
    if ((self = [super init]))
    {
        self.planet = planet;
        self.planet.underattack = YES;
        [self setup];
    }
    
    return self;
}

- (void)dealloc
{
    // release any resources here
    
}

- (void)setup
{
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"spacedock.png"];
    background.pivotX = 0;
    background.pivotY = 0;
    background.x = 0;
    background.y = 0;
    background.scaleX = Sparrow.stage.width / background.width ;
    background.scaleY = Sparrow.stage.height / background.height;
    //NSLog(@"%f, %f", background.width, background.height);
    [self addChild:background];
    
    SPQuad* bgmask = [[SPQuad alloc] initWithWidth:background.width height:background.height color:0x000000];
    bgmask.alpha = 0.75;
    [self addChild:bgmask];
    
        [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event
{
    Fleet* player = [Game instance].player;
    if (player.ships.count == 0)
    {
        NSLog(@"PLAYER HAS LOST!");
        self.planet.underattack = NO;
        [self removeFromParent];
        [self removeEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    }
    else if (self.planet.ships.count == 0) {
        NSLog(@"PLAYER HAS WON!");
        self.planet.underattack = NO;
        [self removeFromParent];
        [self removeEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
        [self.planet changeTeam:player.team];
        [Sparrow.stage addChild:[[PlanetMenu alloc] initWithPlanet:self.planet]];
    }
}

@end
