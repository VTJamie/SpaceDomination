//
//  Game.m
//  AppInnerFear
//

#import "Game.h"
#import "Background.h"
#import "Fleet.h"
#import "Planet.h"
#import "CenterChangeEvent.h"

// --- private interface ---------------------------------------------------------------------------

@interface Game ()

- (void)setup;

@end


// --- class implementation ------------------------------------------------------------------------

@implementation Game
{
    
}

- (id)init
{
    if ((self = [super init]))
    {
        gameInstance = self;
     
        self.minX = -500;
        self.maxX = 500;
        self.minY = -500;
        self.maxY = 500;
        self.numberofplanets = 5;
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
    self.computer = [[Fleet alloc] initWithSide:2];
    self.player = [[Fleet alloc] initWithSide:1];
    
    for (int i = 0; i < self.numberofplanets; i++)
    {
        Planet* playerPlanet = [[Planet alloc] initWithTeam:1];
        Planet* computerPlanet = [[Planet alloc] initWithTeam:2];
        
        [self.planets addObject:playerPlanet];
        [self.planets addObject:computerPlanet];
        
        [self addChild:playerPlanet];
        [self addChild:computerPlanet];
    }
    
    [self addChild:self.player];
    [self addChild:self.computer];
    
    // The controller autorotates the game to all supported device orientations.
    // Choose the orienations you want to support in the Xcode Target Settings ("Summary"-tab).
    // To update the game content accordingly, listen to the "RESIZE" event; it is dispatched
    // to all game elements (just like an ENTER_FRAME event).
    //
    // To force the game to start up in landscape, add the key "Initial Interface Orientation"
    // to the "App-Info.plist" file and choose any landscape orientation.
    
 //   [self addEventListener:@selector(onResize:) atObject:self forType:SP_EVENT_TYPE_RESIZE];
    
    [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
 
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
//            NSLog(@"Not Dragging");
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
