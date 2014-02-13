//
//  Game.m
//  AppInnerFear
//

#import "Game.h"
#import "Background.h"
#import "Fleet.h"
#import "Planet.h"
#import "CenterChangeEvent.h"
#import "TouchBackgroundEvent.h"
#import "GamePieceContainer.h"
#import "PlanetTouchEvent.h"

// --- private interface ---------------------------------------------------------------------------

@interface Game ()

- (void)setup;

@end


// --- class implementation ------------------------------------------------------------------------

@implementation Game

- (id)init
{
    if ((self = [super init]))
    {
        gameInstance = self;
        self.gameJuggler = [SPJuggler juggler];
        self.menuJuggler = [SPJuggler juggler];
        self.minX = -500;
        self.maxX = 500;
        self.minY = -500;
        self.maxY = 500;
        self.numberofplanets = 5;
        self.menuopened = NO;
        self.currentcenter = [[SPPoint alloc] init];
        self.planets = [[NSMutableArray alloc] init];
        [self setup];
    }
    
    return self;
}

- (void)dealloc
{
    // release any resources here
    [Media releaseAtlas];
    [Media releaseSound];
}

- (void)setup
{
    [SPAudioEngine start];  // starts up the sound engine
    
    
    [Media initAtlas];      // loads your texture atlas -> see Media.h/Media.m
    //  [Media initSound];      // loads all your sounds    -> see Media.h/Media.m
    
    [self addChild:[[Background alloc] init]];
    GamePieceContainer* piececontainer = [[GamePieceContainer alloc] init];
    [self addChild:piececontainer];
    self.computer = [[Fleet alloc] initWithSide:2];
    self.player = [[Fleet alloc] initWithSide:1];
    
    for (int i = 0; i < self.numberofplanets; i++)
    {
        Planet* playerPlanet = [[Planet alloc] initWithTeam:1];
        Planet* computerPlanet = [[Planet alloc] initWithTeam:2];
        [playerPlanet addEventListener:@selector(planetTouch:) atObject:self forType:EVENT_TYPE_PLANET_TOUCH];
        
        [computerPlanet addEventListener:@selector(planetTouch:) atObject:self forType:EVENT_TYPE_PLANET_TOUCH];
        
        [self.planets addObject:playerPlanet];
        [self.planets addObject:computerPlanet];
        
        [piececontainer addChild:playerPlanet];
        [piececontainer addChild:computerPlanet];
    }
    
    [piececontainer addChild:self.player];
    [piececontainer addChild:self.computer];
    
    // The controller autorotates the game to all supported device orientations.
    // Choose the orienations you want to support in the Xcode Target Settings ("Summary"-tab).
    // To update the game content accordingly, listen to the "RESIZE" event; it is dispatched
    // to all game elements (just like an ENTER_FRAME event).
    //
    // To force the game to start up in landscape, add the key "Initial Interface Orientation"
    // to the "App-Info.plist" file and choose any landscape orientation.
    
    //   [self addEventListener:@selector(onResize:) atObject:self forType:SP_EVENT_TYPE_RESIZE];
    
    [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

- (void) planetTouch: (PlanetTouchEvent*) planetevent
{
    [self dispatchEvent:planetevent];
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event
{
    [self.gameJuggler advanceTime:event.passedTime];
    [self.menuJuggler advanceTime:event.passedTime];
    [self.player advanceTime:event.passedTime];
    [self.computer advanceTime:event.passedTime];

    for (int i = 0; i < self.planets.count; i++)
    {
        [[self.planets objectAtIndex:i] advanceTime:event.passedTime];
    }
    
}

- (void) onTouch: (SPTouchEvent*) event {
    SPTouch *drag = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] anyObject];
    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    SPTouch *endTouch = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] anyObject];
    static SPPoint *startpoint = nil;
    static BOOL dragging = NO;
    if(touch){
        dragging = NO;
        startpoint = [touch locationInSpace:self];
        
    } else if (drag) {
        dragging = YES;
        SPPoint *dp = [drag locationInSpace:self];
        
        CenterChangeEvent* changecenter = [[CenterChangeEvent alloc] initWithType:EVENT_TYPE_NEW_CENTER_TRIGGERED];
        
        changecenter.change.x = startpoint.x - dp.x;
        changecenter.change.y = startpoint.y - dp.y;
        
        
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
        startpoint = dp;
    }
    else if (endTouch) {
        if (!dragging) {
            
        }
        dragging = NO;
    }
}
//
//- (void)onResize:(SPResizeEvent *)event
//{
//    // NSLog(@"new size: %.0fx%.0f (%@)", event.width, event.height,
//    //     event.isPortrait ? @"portrait" : @"landscape");
//
//    //   [self updateLocations];
//}

+(Game*) instance
{
    return gameInstance;
}

@end
