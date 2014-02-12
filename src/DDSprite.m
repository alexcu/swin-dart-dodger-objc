/**
 * @class   DDSprite
 * @author  Alex Cummaudo
 * @date    10 Sep 2013
 * @brief   Defines the parent class for all drawable
 *          sprites.
 */

// Import SwinGame Framework
#import "SwinGame.h"

// Import my interface
#import "DDSprite.h"
#import "DDGame.h"
#import "DDCanvas.h"

@implementation DDSprite

// Sythesize ivars.
@synthesize position = _position;

// Manual sythesis of centre
/**
 * @brief   Calculates the centrepoint of the 
 *          sprite based on the centrepoint of
 *          the _bitmap and the current _position
 *          of the sprite.
 * @return  The centrepoint of the sprite's _bitmap
 */
-(SGPoint2D*) centre
{
    return [SGGeometry pointAtX:_position.x + _bitmap.width /2
                              y:_position.y + _bitmap.height/2];
}
-(void) setCentre:(SGPoint2D *)centre
{
    _position = [SGGeometry pointAtX:_position.x - _bitmap.width /2
                                   y:_position.y - _bitmap.height/2];
}

/**
 * @brief   The constructor for DDSprite which intialises
 *          the bitmap and position with the given bitmap
 *          filename and x and y coordinates.
 * @return  The class's self pointer
 */
-(id) initWithBitmapFile:(NSString *)fileName atX:(int)xPos atY:(int)yPos inGame:(DDGame*)game
{
    if (self = [super init])
    {
        _bitmap     = [[SGBitmap alloc] initWithName:fileName fromFile:fileName];
        _position   = [[SGPoint2D alloc] initAtX:xPos - _bitmap.width/2
                                               y:yPos - _bitmap.height/2];
        // Automatically add me to the game canvas' sprites
        _game = game;
        [game addSprite:self];
    }
    return self;
}

/**
 * @brief   The constructor for DDSprite which intialises
 *          the bitmap and position with the given bitmap
 *          filename, a given x abscissa, and a random y
 *          ordinate whose limits are within the screen's
 *          height boundaries.
 * @return  The class's self pointer
 */
-(id) initWithBitmapFile:(NSString *)fileName atStaticX:(int)xPos inGame:(DDGame*) game
{
    if (self = [super init])
    {
        int yPos    = [SGUtils rndUpto:[SGGraphics screenHeight]];
        // Initialise ivars
        _bitmap     = [[SGBitmap alloc] initWithName:fileName fromFile:fileName];
        _position   = [[SGPoint2D alloc] initAtX:xPos - _bitmap.width/2
                                               y:yPos - _bitmap.height/2];
        // Automatically add me to the game canvas' sprites
        _game = game;
        [game addSprite:self];
    }
    return self;
}

/**
 * @brief   The constructor for DDSprite which intialises
 *          the bitmap and position with the given bitmap
 *          filename, a given y ordinate, and a random x
 *          abscissa whose limits are within the screen's
 *          height boundaries.
 * @return  The class's self pointer
 */
-(id) initWithBitmapFile:(NSString *)fileName atStaticY:(int)yPos inGame:(DDGame*) game {
    if (self = [super init])
    {
        int xPos    = [SGUtils rndUpto:[SGGraphics screenWidth]];
        // Initialise ivars
        _bitmap     = [[SGBitmap alloc] initWithName:fileName fromFile:fileName];
        _position   = [[SGPoint2D alloc] initAtX:xPos - _bitmap.width/2
                                               y:yPos - _bitmap.height/2];
        // Automatically add me to the game canvas' sprites
        _game = game;
        [game addSprite:self];
    }
    return self;
}

/**
 * @brief   Tells the canvas who I belong to to remove me and
 *          releases me.
 */
-(void) kill;
{
    [_game removeSprite:self];
    self = nil;
}

/**
 * @brief   Draws the sprite's bitmap to screen at
 *          the given coordinates
 */
-(void) draw
{
    [SGImages draw:_bitmap onScreenAt:_position];
}

@end
