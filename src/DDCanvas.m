/**
 * @class   DDCanvas
 * @author  Alex Cummaudo
 * @date    11 Sep 2013
 * @brief   Defines the class of the canvas object which
 *          holds all graphical objects
 */

// Import SwinGame Framework
#import "SwinGame.h"

// Import my interface
#import "DDCanvas.h"

// Import interfaces of other classes/protocols used
#import "DDSprite.h"
#import "DDCollidable.h"
#import "DDCollisionMask.h"
#import "DDBalloon.h"
#import "DDHud.h"

@implementation DDCanvas 

/**
 * @brief   The constructor for DDCanvas which intialises
 *          the HUD and sprite collection
 * @return  The class's self pointer
 */
-(id) init
{
    if (self = [super init])
    {
        _sprites     = [[NSMutableArray alloc] init];
        _hud         = [[DDHud alloc] init];
    }
    return self;
}

/**
 * @brief   Adds a sprite to the sprite collection
 * @param   sprite
 *          The sprite object to be added
 */
-(void)addSprite:(DDSprite*) sprite
{
    [_sprites addObject:sprite];
}

/**
 * @brief   Kills a sprite entirely by setting it to
 *          nill, releasing it, and removing it from
 *          the sprites collection.
 * @param   sprite
 *          The sprite object to be killed
 */
-(void) removeSprite:(DDSprite*) sprite
{
    [_sprites removeObjectIdenticalTo:sprite];
}

/**
 * @brief   Draws the canvas to the screen by iterating
 *          through all the sprites and messaging them
 *          to draw themselves, then telling the _hud
 *          to draw (calling HUD last since it sits on
 *          top)
 * @param   data
 *          The dictionary of key/value pairs that will
 *          be added to the HUD (where key references position
 *          and value is the value to be drawn)
 */
-(void) drawWithItems:(NSDictionary*) data
{
    for (DDSprite* sprite in _sprites) [sprite draw];   // Draw every sprite
    [_hud drawWithItems:data];                          // Draw the hud
    [SGGraphics refreshScreen];
}

/**
 * @brief   Returns the sprite with the given class
 *          name from the _sprites collection
 * @param   class
 *          The class to compare against every DDSprite in the _sprites
 *          collection.
 * @return  Any object with the given class name, should it exist in _sprites.
 *          Where no object of this class name is found, a nil is returned.
 */
-(id) getSprite:(Class)class
{
    for (DDSprite* sprite in _sprites)
        if ([sprite class] == class)
        {
            return sprite;
        }
    return nil;
}

/**
 * @brief   Draws special objects for debugging purposes only
 * @note    This method applies only in Debug mode
 */
-(void) drawDebug {
    [SGGraphics clearScreen];
    [SGText drawText:@"[ DART DODGER! ]" color:ColorWhite pt:[SGGeometry pointAtX:145 y:40]];
    [SGText drawText:@"By Alex Cummaudo" color:ColorWhite pt:[SGGeometry pointAtX:145 y:50]];
    [SGText drawText:@"** Debug Mode **" color:ColorWhite pt:[SGGeometry pointAtX:145 y:60]];
    int balloonCount = 0;

    // For every collidable sprite I have
    for (DDSprite<DDCollidable> *sprite in _sprites)
    {
        // Given it isn't collidable (conforms to the protocol), then move onto next
        if (![sprite conformsToProtocol:@protocol(DDCollidable)]) continue;

        // Is this one a balloon?
        if ([sprite isKindOfClass:[DDBalloon class]])
        {
            DDBalloon *balloon = (DDBalloon*)sprite;

            // Balloon count for duplicate balloons
            balloonCount++;
            
            
            if (balloonCount > 1)
            {
                // Draw Magenta/Blue col. masks (triangles) color for duplicate balloon
                [SGGraphics draw:ColorMagenta  filled:NO triangle:balloon.innerCollisionMask.shape];
                [SGGraphics draw:ColorBlue filled:NO triangle:balloon.outerCollisionMask.shape];
            }
            else
            {
                // Draw Green/Yellow col. masks (triangles) color for normal balloon
                [SGGraphics draw:ColorYellow  filled:NO triangle:balloon.innerCollisionMask.shape];
                [SGGraphics draw:ColorGreen   filled:NO triangle:balloon.outerCollisionMask.shape];
            }
        }
        else
        {
            // Draw red rectangles for other collidables
            [SGGraphics draw:ColorRed filled:NO rectangle:sprite.getCollisionMask.shape];
        }

        // Draw class name
        [SGText drawText:[sprite className]
                   color:ColorTurquoise
               onScreenX:sprite.centre.x-40
                       y:sprite.centre.y+10];
        // Memory Address
        [SGText drawText:[NSString stringWithFormat:@"%p", sprite]
                   color:ColorTurquoise
               onScreenX:sprite.centre.x-40
                       y:sprite.centre.y+20 ];
        // Centrepoint
        [SGText drawText:[SGGeometry pointToString:sprite.centre]
                   color:ColorTurquoise
               onScreenX:sprite.centre.x-40
                       y:sprite.centre.y+30  ];
    }
    [SGGraphics refreshScreen];
}

@end
