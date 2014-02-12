/**
 * @class   DDBalloon
 * @author  Alex Cummaudo
 * @date    11 Sep 2013
 * @brief   Defines the class for the balloon object,
 *          which allows the player to interact with
 *          in-game elements.
 */

// Import SwinGame Framework
#import "SwinGame.h"

// Import my interface
#import "DDBalloon.h"

// Import interfaces of other classes used
#import "DDCollisionMask.h"
#import "DDGame.h"

@implementation DDBalloon

// Synthesize properties
@synthesize health              = _health;
@synthesize isAlive             = _isAlive;
@synthesize innerCollisionMask  = _innerCollisionMask;
@synthesize outerCollisionMask  = _outerCollisionMask;

/**
 * @brief   The constructor for DDBalloon which intialises
 *          the ivars, initialising its parent DDSprite with
 *          the balloon image.
 * @param   game
 *          Game to initialise the DDBalloon within for access
 *          to that Game's game canvas (allows my parent to
 *          dynamically add my sprite to that canvas at runtime)
 * @return  The class's self pointer
 */
-(id)initInGame:(DDGame*) game
{
    if (self = [super initWithBitmapFile:@"balloon.png"
                                     atX:[SGGraphics screenWidth]/2
                                     atY:400
                                  inGame:game])
    {
        _health                     = 3;
        _isAlive                    = YES;
        _duplicate                  = nil;
        [self updateMaskPosition];
    }
    return self;
}

/**
 * @brief   Moves the balloon's position in the given
 *          direction. Does the same with the duplicate
 *          if one exists as well as the collision masks.
 * @param   dir
 *          Direction to move in---only responds to x axis
 *          movements (DDLEFT and DDRIGHT)
 */
-(void) moveInDirection:(DDDirection)dir
{
    _speed = _game.speed;                                   // Update my speed to game speed
    if (dir == DDLEFT)  { _position.x -= _speed; }          // Move the balloon
    if (dir == DDRIGHT) { _position.x += _speed; }          // Move the balloon
    [self updateMaskPosition];
}

/**
 * @brief   Updates the collision mask of the balloon
 *
 * @note    This method is private
 */
-(void) updateMaskPosition
{
    int const INNER_SCALE = 17;
    
    // Temportary point for collision boundary assignment
    SGPoint2D* ptInnerA = [SGGeometry pointAtX:_position.x + INNER_SCALE
                                             y:_position.y + _bitmap.height /2           ];
    SGPoint2D* ptInnerB = [SGGeometry pointAtX:_position.x + _bitmap.width  /2
                                             y:_position.y + INNER_SCALE * 1.7           ];
    SGPoint2D* ptInnerC = [SGGeometry pointAtX:_position.x + _bitmap.width - INNER_SCALE
                                             y:_position.y + _bitmap.height /2           ];
    
    // If the _innerCollisionMask was initialised already?
    if (_innerCollisionMask)
    {
        [_innerCollisionMask updateWithPoints:@[ptInnerA, ptInnerB, ptInnerC]];
    // Otherwise initialse it.
    }
    else
    {
        _innerCollisionMask = [[DDCollisionMask alloc] initAsTriangleAtPointA: ptInnerA
                                                                       pointB: ptInnerB
                                                                       pointC: ptInnerC];
    }
    
    // Reassignment of points for outer collision boundary assignment
    SGPoint2D* ptOuterA = [SGGeometry pointAtX:_position.x
                                             y:_position.y + _bitmap.height /2 ];
    SGPoint2D* ptOuterB = [SGGeometry pointAtX:_position.x + _bitmap.width  /2
                                             y:_position.y                     ];
    SGPoint2D* ptOuterC = [SGGeometry pointAtX:_position.x + _bitmap.width
                                             y:_position.y + _bitmap.height /2 ];
    
    // If the _innerCollisionMask was initialised already?
    if (_outerCollisionMask)
    {
        [_outerCollisionMask updateWithPoints:@[ptOuterA, ptOuterB, ptOuterC]];
    // Otherwise initialse it.
    }
    else
    {
         _outerCollisionMask    = [[DDCollisionMask alloc] initAsTriangleAtPointA:ptOuterA
                                                                           pointB:ptOuterB
                                                                           pointC:ptOuterC];
    }
}

/**
 * @brief   Checks if the balloon is off the screen.
 *          If balloon moves off the screen, then duplicate the
 *          balloon so that there is another instance of it on
 *          the other side of the screen, however this is an
 *          imposter so kill it once the `real' balloon is back.
 */
-(void) checkOffScreen
{
    // Balloon off screen (left)?
    if (_position.x < 0)
    {
        // Create duplicate if it doesn't already exists
        if (!_duplicate) _duplicate = [self duplicateOnSide:DDRIGHT];
        // Else duplicate exists
        else
        {
            // Update position
            _duplicate.position.x = _position.x + [SGGraphics screenWidth];
            // So update its mask position
            [_duplicate updateMaskPosition];
        }
        // Fully past leftmost outer-screen limits?
        // Or returned back?
        if (_position.x < -_bitmap.width ||
            _position.x > 0)
        {
            // Place me at duplicate
            _position.x = _duplicate.position.x;
            
            // Replace my inner coll. bound with the duplicate's
            [_innerCollisionMask
             updateWithPoints:_duplicate.innerCollisionMask.points];

            // Replace my inner coll. bound with the duplicate's
            [_outerCollisionMask
             updateWithPoints:_duplicate.outerCollisionMask.points];
            
            // Kill the duplicate
            [_duplicate kill];
            _duplicate = nil;
        }
    }
    // Balloon off screen (right)?
    else if (_position.x + _bitmap.width > [SGGraphics screenWidth])
    {
        // Create duplicate if it doesn't already exists
        if (!_duplicate) _duplicate = [self duplicateOnSide:DDLEFT];
        // Else duplicate exists
        else
        {
            // Update position
            _duplicate.position.x = _position.x - [SGGraphics screenWidth];
            // So update its mask position
            [_duplicate updateMaskPosition];
        }
        // Fully past rightmost outer-screen limits?
        if (_position.x > [SGGraphics screenWidth] ||
            // Or returned back?
            _position.x + _bitmap.width < [SGGraphics screenWidth])
        {
            // Place me at duplicate
            _position.x = _duplicate.position.x;
             // Replace my inner coll. bound with the duplicate's
            
            [_innerCollisionMask
             updateWithPoints:_duplicate.innerCollisionMask.points];
            
             // Replace my inner coll. bound with the duplicate's
            [_outerCollisionMask
            updateWithPoints:_duplicate.outerCollisionMask.points];

            // Kill the duplicate
            [_duplicate kill];
            _duplicate = nil;
        }
    }
    
    // If the balloon is definately in the centre
    if ([SGGeometry point:[self centre]
                  inRectX:_bitmap.width
                        y:0
                    width:[SGGraphics screenWidth] - 2 * _bitmap.width
                   height:[SGGraphics screenHeight]]
        )
    {
        // Then obviously no duplicates allowed! the duplicate
        [_duplicate kill];
        _duplicate = nil;
    }
}

/**
 * @brief   Allows the balloon to be duplicated either left or right
 *          relative to this balloon's x (i.e. _position.x)
 * @note    This method is private
 * @param   side
 *          Side to duplicate the new balloon on relative to the
 *          `old' balloon
 */
-(DDBalloon*) duplicateOnSide:(DDDirection) side
{
    // Create a new balloon on the same canvas as my own
    DDBalloon* duplicate = [[DDBalloon alloc] initInGame:_game];

    // Set duplicate's x to org's x
    duplicate.position.x = _position.x;

    // Duplicate can never die (it dies when it goes off screen)
    duplicate.health = 999;
    
    // Given we want the duplicate on the left
    if (side == DDLEFT)
    {
        // Place it on the left with its collision boundaries
        duplicate.position.x -= [SGGraphics screenWidth];
        [duplicate.innerCollisionMask moveInDirection:DDLEFT
                                              atSpeed:[SGGraphics screenWidth]/2
                                                      + _bitmap.width  /2];
        [duplicate.outerCollisionMask moveInDirection:DDLEFT
                                              atSpeed:[SGGraphics screenWidth]/2
                                                      + _bitmap.width  /2];
    }
    // Given we want the duplicate on the right
    else if (side == DDRIGHT)
    {
        // Place it on the right with its collision boundaries
        duplicate.position.x += [SGGraphics screenWidth];
        [duplicate.innerCollisionMask moveInDirection:DDRIGHT
                                              atSpeed:[SGGraphics screenWidth]/2
                                                       + _bitmap.width  /2];
        [duplicate.outerCollisionMask moveInDirection:DDRIGHT
                                              atSpeed:[SGGraphics screenWidth]/2
                                                       + _bitmap.width  /2];
    }
    return duplicate;
}

/**
 * @brief   Returns the outer collision mask by default.
 * @note    This method is required by the DDCollidable protocol.
 * @return  By default, just gets the outermost collision mask
 */
-(DDCollisionMask*) getCollisionMask
{
    return _outerCollisionMask;
}

/**
 * @brief   Checks if the balloon has collided with any collidable
 *          sprite and performs an appropriate action depending on
 *          what sprite that is.
 * @note    This method is required by the DDCollidable protocol.
 * @param   sprite
 *          The secondary sprite which DDBalloon checks collision with
 * @return  YES or NO on a collision.
 */
-(BOOL) collideWithSprite:(DDSprite<DDCollidable>*) sprite
{
    // Get the collision point of the other shape
    // Note we cast as a rectangle since only balloon use triangles
    SGPoint2D* collisionPoint = [SGGeometry rectangleCenterBottom:
                                 (SGRectangle*)[sprite getCollisionMask].shape];
    
    // Inner collision?
    if ([SGGeometry point:collisionPoint inTriangle:_innerCollisionMask.shape])
    {
        [self burst];           // burst balloon
        
        [sprite kill];          // kill the other sprite on inner
        sprite = nil;
        
        return YES;
    } else
    // Outer collision?
    if ([SGGeometry point:collisionPoint inTriangle:_outerCollisionMask.shape])
    {
        [self jiggle]; // just jiggle
        return YES;
    }

    // Repeat the same on the duplicate
    if (_duplicate) {
        int dupPrevHealth = _duplicate.health;
        // And if it has caused it to hit, return true (else false too)
        if ([_duplicate collideWithSprite:sprite])
        {
            int dupPostHealth = _duplicate.health;
            // Update the heath of real balloon (instead of just _duplicate)
            _health += (dupPostHealth - dupPrevHealth);
            return YES;
        }
    }
    return YES;
}

/**
 * @brief   Jiggles a balloon's position left and right rapidly,
 *          playing the jiggle sound effect.
 */
-(void) jiggle
{
    if (round([SGUtils rnd]) == 0) { _position.x += [SGUtils rndUpto:_speed*1.5]; }
    else                           { _position.x -= [SGUtils rndUpto:_speed*1.5]; }
    [self updateMaskPosition];
    [SGAudio playSoundEffect:[[SGSoundEffect alloc] initFromFile:@"slidepast-1.ogg"]];

}

/**
 * @brief   Bursts the balloon (i.e. subtracts a life), playing the
 *          burst sound effect
 */
-(void) burst
{
    _health--;
    if (_health < 1)
    { _isAlive = NO; _health = 0; }
    [SGAudio playSoundEffect:[[SGSoundEffect alloc] initFromFile:@"loselife-1.ogg"]];
}

/**
 * @brief   Increments health by one; makes it alive if health > 0
 */
-(void) oneUp
{
    _health++;
    [SGAudio playSoundEffect:[[SGSoundEffect alloc] initFromFile:@"newround.ogg"]];
    if (_health > 0)
    {
        [SGAudio stopSoundEffectNamed:@"dying"];
        _isAlive = YES;
    }
    
}

@end
