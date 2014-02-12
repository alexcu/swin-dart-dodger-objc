/**
 * @class   DDBackground
 * @author  Alex Cummaudo
 * @date    13 Sep 2013
 * @brief   Defines the class for the background object.
 */

// Import SwinGame Framework
#import "SwinGame.h"

// Import my interface
#import "DDBackground.h"
#import "DDGame.h"

@implementation DDBackground

/**
 * @brief   The constructor for DDBackground which intialises
 *          the speed at 3, initialising its parent DDSprite with
 *          the background image.
 * @param   game
 *          Game to initialise the DDBalloon within for access
 *          to that Game's game canvas (allows my parent to
 *          dynamically add my sprite to that canvas at runtime)
 * @return  The class's self pointer
 */
-(id) initInGame:(DDGame*) game
{
   if (self = [super initWithBitmapFile:@"background.png"
                                    atX:[SGGraphics screenWidth]/2
                                    atY:[SGGraphics screenHeight]/2
                                 inGame:game])
   {
       _speed = 3;
   }
    return self;
}

/**
 * @brief   Scrolls the background repeatedly in the given
 *          direction at the _speed.
 */
-(void)fall
{
    _speed = _game.speed;
    _position.y += _speed;

    // Realign bitmap once it is off the screen
	if (_position.y > 0)
    { _position.y -= [SGGraphics screenHeight]; }
    if (_position.y + _bitmap.height < [SGGraphics screenHeight])
    { _position.y += [SGGraphics screenHeight]; }
}

@end
