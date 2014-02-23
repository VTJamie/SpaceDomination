//
//  Playable.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/23/14.
//
//

#import "Playable.h"
#import "Planet.h"
#import "PlanetTouchEvent.h"

@implementation Playable

- (id)init
{
    if ((self = [super init]))
    {
        self.numberofplanets = 2;
        double gamesize = (self.numberofplanets/2 * 60);
        self.minX = -gamesize;
        self.maxX = gamesize;
        self.minY = -gamesize;
        self.maxY = gamesize;
        self.currentcenter = [[SPPoint alloc] init];
        self.planets = [[NSMutableArray alloc] init];
        self.overallscale = 1.0;
        self.gameover = NO;
    }
    
    return self;
}

- (void)dealloc
{
}

- (void)start
{
    self.backgroundSprite = [[Background alloc] init];
    [self addChild:self.backgroundSprite];
    self.gamepieceSprite = [[GamePieceContainer alloc] init];
    [self addChild:self.gamepieceSprite];
    self.computer = [[Fleet alloc] initWithSide:2];
    self.player = [[Fleet alloc] initWithSide:1];
    
    Planet* playerplanet = [[Planet alloc] initWithTeam:1 X: 0 Y: 0 size: 1.5];
    [playerplanet addEventListener:@selector(planetTouch:) atObject:self forType:EVENT_TYPE_PLANET_TOUCH];
    [self.planets addObject:playerplanet];
    [self.gamepieceSprite addChild:playerplanet];
    
    Planet* computerplanet = [[Planet alloc] initWithTeam:2 X: self.maxX + 60 Y: self.maxY + 60 size: 1.5];
    [computerplanet addEventListener:@selector(planetTouch:) atObject:self forType:EVENT_TYPE_PLANET_TOUCH];
    [self.planets addObject:computerplanet];
    [self.gamepieceSprite addChild:computerplanet];
    
    self.player.x = playerplanet.x;
    self.player.y = playerplanet.y;
    
    self.computer.x = computerplanet.x;
    self.computer.y = computerplanet.y;
    
    for (int i = 1; i <= self.numberofplanets/2; i++)
    {
        for (int j = 1; j <= self.numberofplanets/2; j++)
        {
            Planet* planet = [[Planet alloc] initWithTeam:0 X: i*60 Y: j*60 size: 1.0];
            [planet addEventListener:@selector(planetTouch:) atObject:self forType:EVENT_TYPE_PLANET_TOUCH];
            [self.planets addObject:planet];
            [self.gamepieceSprite addChild:planet];
        }
    }
    
    [self.gamepieceSprite addChild:self.player];
    [self.gamepieceSprite addChild:self.computer];
    
    [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];

}


- (void) planetTouch: (PlanetTouchEvent*) planetevent
{
    [self dispatchEvent:planetevent];
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event
{
    BOOL foundenemy = NO;
    BOOL foundplayer = NO;
    for (int i = 0; i < self.planets.count; i++)
    {
        if ([[self.planets objectAtIndex:i] team] == self.computer.team)
        {
            foundenemy = YES;
        }
        else if ([[self.planets objectAtIndex:i] team] == self.player.team)
        {
            foundplayer = YES;
        }
    }
    
    self.gameover = !foundenemy || !foundplayer;
    
    if (!self.gameover)
    {
        for (int i = 0; i < self.planets.count; i++)
        {
            [[self.planets objectAtIndex:i] advanceTime:event.passedTime];
        }
        [[Game instance].gameJuggler advanceTime:event.passedTime];
        [[Game instance].menuJuggler advanceTime:event.passedTime];
        [self.player advanceTime:event.passedTime];
        [self.computer advanceTime:event.passedTime];
    }
}

- (void) onTouch: (SPTouchEvent*) event {
    
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    
    if ([touches count] == 1)
    {
        SPTouch *touch = touches[0];
        SPPoint *movement = [touch movementInSpace:self.parent];
        
        CenterChangeEvent* changecenter = [[CenterChangeEvent alloc] initWithType:EVENT_TYPE_NEW_CENTER_TRIGGERED];
        
        changecenter.change.x = -movement.x;
        changecenter.change.y = -movement.y;
        
        
        if (self.currentcenter.x + changecenter.change.x < self.minX)
        {
            changecenter.change.x = self.minX - self.currentcenter.x;
        }
        
        if (self.currentcenter.x + changecenter.change.x > self.maxX)
        {
            changecenter.change.x = self.maxX - self.currentcenter.x;
        }
        
        if (self.currentcenter.y + changecenter.change.y < self.minY)
        {
            changecenter.change.y = self.minY - self.currentcenter.y;
        }
        
        if (self.currentcenter.y + changecenter.change.y > self.maxY)
        {
            changecenter.change.y = self.maxY - self.currentcenter.y;
        }
        
        self.currentcenter.x = self.currentcenter.x + changecenter.change.x;
        self.currentcenter.y = self.currentcenter.y + changecenter.change.y;
        
        changecenter.newcenter = self.currentcenter;
        
        [self dispatchEvent:changecenter];
    }
    else if ([touches count] == 2) {
        // two fingers touching -> rotate and scale
        //        SPTouch *touch1 = touches[0];
        //        SPTouch *touch2 = touches[1];
        //
        //        SPPoint *touch1PrevPos = [touch1 previousLocationInSpace:self];
        //        SPPoint *touch1Pos = [touch1 locationInSpace:self];
        //        SPPoint *touch2PrevPos = [touch2 previousLocationInSpace:self];
        //        SPPoint *touch2Pos = [touch2 locationInSpace:self];
        //
        //        SPPoint *prevVector = [touch1PrevPos subtractPoint:touch2PrevPos];
        //        SPPoint *vector = [touch1Pos subtractPoint:touch2Pos];
        //
        //        // update pivot point based on previous center
        //        SPPoint *touch1PrevLocalPos = [touch1 previousLocationInSpace:self];
        //        SPPoint *touch2PrevLocalPos = [touch2 previousLocationInSpace:self];
        //        self.pivotX = (touch1PrevLocalPos.x + touch2PrevLocalPos.x) * 0.5f;
        //        self.pivotY = (touch1PrevLocalPos.y + touch2PrevLocalPos.y) * 0.5f;
        //
        //        // update location based on the current center
        //        self.x = (touch1Pos.x + touch2Pos.x) * 0.5f;
        //        self.y = (touch1Pos.y + touch2Pos.y) * 0.5f;
        //
        //       // float angleDiff = vector.angle - prevVector.angle;
        //       // self.rotation += angleDiff;
        //
        //        float sizeDiff = vector.length / prevVector.length;
        //        self.scaleX = self.scaleY = MAX(0.5f, self.scaleX * sizeDiff);
        //        self.overallscale = self.scaleX;
        //        ZoomChangedEvent* changedzoom = [[ZoomChangedEvent alloc] initWithType:EVENT_TYPE_NEW_ZOOM];
        //        [self dispatchEvent:changedzoom];
    }
}


@end
