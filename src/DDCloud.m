/**
 * @class   DDCloud
 * @author  Alex Cummaudo
 * @date    01 Oct 2013
 * @brief   Defines the class for a DDCloud, which
 *          allows for the creation of cloud objects
 *          which force the player to move in a certain
 *          direction.
 */

// Import SwinGame Framework
#import "SwinGame.h"

// Import my interface
#import "DDCloud.h"

// Import interfaces of other classes used
#import "DDCollisionMask.h"
#import "DDGame.h"
#import "DDCollidable.h"
#import "DDBalloon.h"

@implementation DDCloud

/**
 * @brief   Constructor for the cloud initialises the collision
 *          mask and direction
 * @param   game
 *          Game to initialise the DDBalloon within for access
 *          to that Game's game canvas (allows my parent to
 *          dynamically add my sprite to that canvas at runtime)
 * @param   dir
 *          Direction to start moving in (responds to either
 *          DDLEFT or DDRIGHT)
 * @return  The class's self pointer
 */
-(id) initInGame:(DDGame *)game inDirection:(DDDirection)dir
{
    
    // Define the spawn position
    SGPoint2D* pos;
    NSString* img;
    
    // Moving left = spawn right
    if (dir == DDLEFT)
    {
        img = @"cloudR.png";
        pos = [SGGeometry pointAtX:[SGGraphics screenWidth]
                                 y:400];
    }
    // Moving left = spawn right
    if (dir == DDRIGHT)
    {
        img = @"cloudL.png";
        pos = [SGGeometry pointAtX:-[SGGraphics screenWidth]/2
                                 y:400];
        
    }
    
    if (self = [super initWithBitmapFile:img
                                     atX:pos.x
                                     atY:pos.y
                                  inGame:game])
    {
        _collisionMask  = [[DDCollisionMask alloc]
                           initAsRectangleAtPointA:_position
                           pointB:[SGGeometry pointAtX:_position.x+_bitmap.width
                                                     y:_position.y+_bitmap.height]];
        _movingDirection = dir;
    }
    return self;
    
}


/**
 * @brief   Causes the cloud to move left or right
 *          depending on its _movingDirection by game speed
 */
-(void)fall
{
    _speed = abs(_game.speed); // Always move left or right abs'ly
    
    // Move left if left, else right
    if ( _movingDirection == DDLEFT  )  { _position.x -= _speed; }
    if ( _movingDirection == DDRIGHT )  { _position.x += _speed; }
    
    NSArray* pts = [[NSArray alloc] initWithObjects:_position,
                    [SGGeometry pointAtX:_position.x+_bitmap.width
                                       y:_position.y+_bitmap.height],
                    nil];
    [_collisionMask updateWithPoints:pts];
    
    // Kill myself if off right and moving left if off left and moving right
    if ((_position.x > [SGGraphics screenWidth] && _movingDirection == DDRIGHT) ||
        (_position.x < -_bitmap.width           && _movingDirection == DDLEFT))
    {
        [self kill];
        self = nil;
    }
    [pts release];
}


/**
 * @brief   Returns the _collisionMask (required for DDCanvas)
 * @note    This method is required by the DDCollidable protocol.
 */
-(DDCollisionMask*) getCollisionMask
{
    return _collisionMask;
}

/**
 * @brief   This method checks collision between its own collision mask
 *          and that of the passed sprite
 * @note    This method is required by the DDCollidable protocol.
 * @param   sprite
 *          The sprite to check if both this sprite's and that sprite's
 *          collision masks are overlapping
 * @return  YES on a collision, NO otherwise
 */
-(BOOL)collideWithSprite:(DDSprite<DDCollidable>*) sprite
{
    // For collision with a balloon
    if ([sprite class] == [DDBalloon class])
    {
        
        // Make mask for both outer triangle
        SGTriangle* outerColMsk = sprite.getCollisionMask.shape;
        
        // Cast the sprite as a balloon
        DDBalloon* balloon = (DDBalloon*)sprite;
        
        // Now check the collision
        if ([SGGeometry triangle:outerColMsk
             intersectsRectangle:_collisionMask.shape])
        {

            // Move balloon left or right, accordingly
            if (_movingDirection == DDLEFT ) { [balloon moveInDirection:DDLEFT]; }
            if (_movingDirection == DDRIGHT) { [balloon moveInDirection:DDRIGHT]; }
            
            return YES;
        }
    }
    return YES;
}



@end