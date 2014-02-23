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
#import "ZoomChangedEvent.h"

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
    
    self.playarea = [[Playable alloc] init];
    [self addChild:self.playarea];
    [self.playarea start];
}

+(Game*) instance
{
    return gameInstance;
}

@end
