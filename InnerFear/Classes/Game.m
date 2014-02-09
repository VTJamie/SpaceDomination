//
//  Game.m
//  AppInnerFear
//

#import "Game.h"
#import "Background.h"
#import "Planets.h"
#import "CenterChangeEvent.h"

// --- private interface ---------------------------------------------------------------------------

@interface Game ()

- (void)setup;
- (void)onResize:(SPResizeEvent *)event;

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
        [self setup];
    }
    
    return self;
}

- (void)dealloc
{
    // release any resources here
    [Media releaseAtlas];
   // [Media releaseSound];
}

- (void)setup
{
    // This is where the code of your game will start. 
    // In this sample, we add just a few simple elements to get a feeling about how it's done.
    
  //  [SPAudioEngine start];  // starts up the sound engine
    
    
    // The Application contains a very handy "Media" class which loads your texture atlas
    // and all available sound files automatically. Extend this class as you need it --
    // that way, you will be able to access your textures and sounds throughout your 
    // application, without duplicating any resources.
    
    [Media initAtlas];      // loads your texture atlas -> see Media.h/Media.m
  //  [Media initSound];      // loads all your sounds    -> see Media.h/Media.m
    
    
    // Create some placeholder content: a background image, the Sparrow logo, and a text field.
    // The positions are updated when the device is rotated. To make that easy, we put all objects
    // in one sprite (_contents): it will simply be rotated to be upright when the device rotates.

    
    [self addChild:[[Background alloc] init]];
    [self addChild:[[Planets alloc] init]];

//    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"background.jpg"];
//    [_contents addChild:background];
    
    //NSString *text = @"To find out how to create your own game out of this InnerFear, "
    //                 @"have a look at the 'First Steps' section of the Sparrow website!";
    
//    SPTextField *textField = [[SPTextField alloc] initWithWidth:280 height:80 text:text];
//    textField.x = (background.width - textField.width) / 2;
//    textField.y = (background.height / 2) - 135;
//    [_contents addChild:textField];
    
    // play a sound when the image is touched
    
    // and animate it a little

    // The controller autorotates the game to all supported device orientations. 
    // Choose the orienations you want to support in the Xcode Target Settings ("Summary"-tab).
    // To update the game content accordingly, listen to the "RESIZE" event; it is dispatched
    // to all game elements (just like an ENTER_FRAME event).
    // 
    // To force the game to start up in landscape, add the key "Initial Interface Orientation"
    // to the "App-Info.plist" file and choose any landscape orientation.
    
    [self addEventListener:@selector(onResize:) atObject:self forType:SP_EVENT_TYPE_RESIZE];
    
    [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    // Per default, this project compiles as a universal application. To change that, enter the 
    // project info screen, and in the "Build"-tab, find the setting "Targeted device family".
    //
    // Now choose:  
    //   * iPhone      -> iPhone only App
    //   * iPad        -> iPad only App
    //   * iPhone/iPad -> Universal App  
    // 
    // Sparrow's minimum deployment target is iOS 5.1
}
//
//- (void)updateLocations
//{
//    int gameWidth  = Sparrow.stage.width;
//    int gameHeight = Sparrow.stage.height;
//    
//    _contents.x = (int) (gameWidth  - _contents.width)  / 2;
//    _contents.y = (int) (gameHeight - _contents.height) / 2;
//}


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
        
        changecenter.center.x = startpoint.x - dp.x;
        changecenter.center.y = startpoint.y - dp.y;
    
        [self dispatchEvent:changecenter];
        startpoint = dp;
    }
    else if (endTouch) {
        if (!dragging) {
        //    img.pivotX = img.width / 2.0f;
        //    img.pivotY = img.height / 2.0f;
      //      NSLog(@"Rotated aboout(%f %f)",img.pivotX,img.pivotY);
        //    img.rotation = SP_D2R(90);
            NSLog(@"Not Dragging");
        }
        dragging = NO;
    }
}

- (void)onResize:(SPResizeEvent *)event
{
   // NSLog(@"new size: %.0fx%.0f (%@)", event.width, event.height,
     //     event.isPortrait ? @"portrait" : @"landscape");
    
 //   [self updateLocations];
}

+(Game*) instance
{
    return gameInstance;
}

@end
