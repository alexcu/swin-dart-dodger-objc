/**
 * @class   DDGame
 * @author  Alex Cummaudo
 * @date    11 Sep 2013
 * @brief   Defines the class of the game object which
 *          maintains a game.
 */

// Import SwinGame Framework
#import "SwinGame.h"

// Import my interface
#import "DDGame.h"

// Import interfaces of other classes used
#import "DDBackground.h"
#import "DDBalloon.h"
#import "DDCanvas.h"
#import "DDCollisionMask.h"
#import "DDDart.h"
#import "DDHealth.h"
#import "DDCloud.h"
#import "DDInterrupt.h"

@implementation DDGame
// Synthesize properties
@synthesize speed   = _speed;
@synthesize score   = _score;

/**
 * @brief   The constructor for DDGame which intialises
 *          instance variables to be used.
 * @return  The class's self pointer
 */
-(id)init
{
    if (self = [super init])
    {
        _score      = 0;
        _recScore   = 0;
        _maxDarts   = 5;
        _speed      = 3;
        // Initialise canvas first
        // @todo: use a fake nsmutabledict instead for now
        NSMutableDictionary* hudEls = [[NSMutableDictionary alloc] init];
        _canvas     = [[DDCanvas alloc] init];
        [hudEls release];
        
        // Add objects to canvas in order of priority
        _background = [[DDBackground alloc] initInGame:self];
        _balloon    = [[DDBalloon alloc] initInGame:self];

        _darts      = [[NSMutableArray alloc] init];
        
        // Init and start the timers (had to use C function
        // here since create on its own does not exist in SG)
        _scoreTimer     = [SGTimer createWithId:create_timer()];
        _chanceTimer    = [SGTimer createWithId:create_timer()];
        _dyingTimer     = [SGTimer createWithId:create_timer()];
        [_scoreTimer start];
        [_chanceTimer start];
    }
    return self;
}

/**
 * @brief   Updates the game using a series of private
 *          methods. Returns an id as a flag to kill the
 *          game (i.e. to the controller) as required.
 */
-(void)updateGame
{
    [self checkCollisions];
    [self updateDifficulty];
    [self updateDarts];
    [self updateScore];
    
    // Check if balloon is off screen for duplicate
    // balloon creation
    [_balloon checkOffScreen];
    
    
    // Make all fallables fall
    [[_canvas getSprite:[DDBackground class]] fall];
    [[_canvas getSprite:[DDHealth class]] fall];
    [[_canvas getSprite:[DDCloud class]] fall];
    
    // Make all dart objects fall
    for (int i = 0; i < [_darts count]; i++)
    {
        [[_darts objectAtIndex:i] fall];
    }
    
    // Enable debug mode on spacebar
    if ([SGInput keyDown:VK_SPACE])
    {
        [_canvas drawDebug];
        
        // Testing cheats :D
        if ([SGInput keyDown:VK_Q])
        {
            _score++;
        }
        if ([SGInput keyTyped:VK_C])
        {
            [self spawnCloud];
        }
        if ([SGInput keyTyped:VK_H])
        {
            [self spawnHealth];
        }
        
    }
    // Draw normal game canvas if not debug
    else { [_canvas drawWithItems:@{@"left":  [NSString stringWithFormat:@"%d metres" ,
                                               _score],
                                    @"right": [NSString stringWithFormat:@"Patches: %d" ,
                                               _balloon.health]}]; }
}

/**
 * @brief   Adds a sprite to the game cansnvas
 * @param   sprite
 *          The sprite to add
 */
-(void)addSprite:(DDSprite *)sprite
{
    [_canvas addSprite:sprite];
    NSLog(@"  Allocated %9p for a %@", sprite, [sprite className]);
}

/**
 * @brief   Removes a sprite from the game canvas and destroys all references
 *          to this sprite henceforth, depending on what kind it is
 * @param   sprite
 *          The sprite to remove
 */
-(void)removeSprite:(DDSprite *)sprite
{
    // Remove sprite from the canvas
    [_canvas removeSprite:sprite];
    
    // Removing a dart?
    if ([sprite class] == [DDDart class])
    {
        // Remove the dart from the _darts collection
        [_darts removeObjectIdenticalTo:sprite];
    }
    
    // Lastly, clear all references to this sprite
    NSLog(@"Deallocated %9p for a %@", sprite, [sprite className]);
}

/**
 * @brief   Asks the balloon to move in a specific direction
 * @param   dir
 *          The direction to move in
 */
-(void) moveBalloonInDirection:(DDDirection)dir
{
    [_balloon moveInDirection:dir];
}

/**
 * @brief   Checks for collisions between objects by iterating through
 *          all collidable sprites and running their check collision
 *          with method
 *
 * @note    This method is private.
 */
-(void)checkCollisions
{
    for (int i = 0; i < _darts.count; i++ )             // For every dart
    {
        // Check collision with balloon
        if ([_balloon collideWithSprite:[_darts objectAtIndex:i]])
        {
            if (!_balloon.isAlive && [_dyingTimer ticks] == 0)      // This dart killed the player?
                [_dyingTimer start];                                // Start death timer
        }
        // If a health kit exists in canvas?
        if ([_canvas getSprite:[DDHealth class]])
        {
            DDHealth* health =
                [_canvas getSprite:[DDHealth class]];               // Get that healthkit
            [health collideWithSprite:_balloon];                    // Check if it collided
                                                                    // with a balloon
            [[_darts objectAtIndex:i] collideWithSprite:health];    // Check if dart hit
                                                                    // health kit
        }
    }
    // If a cloud exists in canvas?
    if ([_canvas getSprite:[DDCloud class]])
    {
        // Get that cloud
        DDCloud* cloud =
            [_canvas getSprite:[DDCloud class]];
        [cloud collideWithSprite:_balloon];
    }
}

/**
 * @brief   Updates the dart allocation for the number
 *          of allowable darts
 *
 * @note    This method is private
 */
-(void)updateDarts
{
    // Add _maxDarts number of darts (and do not readd if _darts = _maxDarts)
    for (int i = 0; i < _maxDarts && [_darts count] <= _maxDarts; i++)
    {
        [self spawnDart];
    }
}

/**
 * @brief   Updates the game score.
 *
 * @note    This method is private.
 */
-(void)updateScore
{
    // For player alive
    if (([_scoreTimer ticks] >= 3000/_speed) &&     // For every ~1 second (depends on _speed)
        (_balloon.isAlive)) {                       // and balloon is alive
        _score++;
        [_scoreTimer reset];
        
        // Check for recovery score
        if (_score < _recScore) {                   // Actual score < recovered score?
            _score = _recScore - _score / 2;       // Add the difference between the two / 2
            _recScore = _score;                     // _recScore is now _score
        } else if (_score > _recScore) {            // Rec score < actual score?
            _recScore = _score;                     // _recScore is now _score            
        }
    }
    // If player dead?
    else if (!(_balloon.isAlive)) {
        // Death sound if not playing
        if (![SGAudio soundEffectNamedPlaying:@"dying"])
            [SGAudio playSoundEffect:[[SGSoundEffect alloc] initWithName:@"dying"
                                                            fromFile:@"die-1.ogg"]];
        _speed = -5;
        if ([_dyingTimer ticks] >= 500) {          // Every 1.5 secs
            [self spawnHealth];                     // Give chance to have new health
            [_dyingTimer reset];
        }
        if ([_scoreTimer ticks] >= 100) {           // Every 100ms
            _score -= 3;                            // Eat away at life
            [_scoreTimer reset];
        } else if (_score <= 0) {                   // Out of score to eat away?
            [SGAudio stopSoundEffectNamed:@"dying"];
            
            [SGAudio stopMusic];
            [SGAudio playSoundEffect:[[SGSoundEffect alloc] initFromFile:@"die-2.ogg"]];

            [_canvas drawWithItems:@{@"center" : @"G A M E  O V E R!",
                                     @"backCol": @"red"}];
            [SGUtils delay:3000];                               // Delay everything
            [SGAudio playMusicNamed:@"song" looped:-1];
            [DDInterrupt killGame];                             // Force an interrupt to kill
                                                                // the entire game (game over)
        }
    }
}

/**
 * @brief   Updates game difficulty based on score
 *
 * @note    This method is private.
 */
-(void)updateDifficulty
{
    float healthChance = 0.00f;
    float cloudChance  = 0.00f;
    // If the ballon is alive
    if (_balloon.isAlive) {
        // Check conditions for each round
        // ROUND 1
        if (_score >= 0  && _score <= 9)
        {
            _maxDarts       = 3;
            _speed          = 3;
            healthChance    = 0.00f;
            cloudChance     = 0.00f;
        }
        else
        // ROUND 2
        if (_score >= 10 && _score <= 19)
        {
            _maxDarts       = 4;
            _speed          = 3;
            healthChance    = 0.50f;
            cloudChance     = 0.00f;
        }
        else
        // ROUND 3
        if (_score >= 20 && _score <= 29)
        {
            _maxDarts       = 5;
            _speed          = 4;
            healthChance    = 0.10f;
            cloudChance     = 0.10f;
        }
        else
        // ROUND 4
        if (_score >= 30 && _score <= 39)
        {
            _maxDarts       = 8;
            _speed          = 4;
            healthChance    = 0.20f;
            cloudChance     = 0.20f;
        }
        else
        // ROUND 5
        if (_score >= 40 && _score <= 49)
        {
            _maxDarts       = 10;
            _speed          = 5;
            healthChance    = 0.30f;
            cloudChance     = 0.30f;
        }
        else
        // ROUND 6
        if (_score >= 50 && _score <= 59)
        {
            _maxDarts       = 12;
            _speed          = 5;
            healthChance    = 0.50f;
            cloudChance     = 0.50f;
        }
        else
        // ROUND 7
        if (_score >= 60 && _score <= 69)
        {
            _maxDarts       = 14;
            _speed          = 6;
            healthChance    = 0.20f;
            cloudChance     = 0.60f;
        } else
        // ROUND 8
        if (_score >= 70 && _score <= 79)
        {
            _maxDarts       = 18;
            _speed          = 7;
            healthChance    = 0.20f;
            cloudChance     = 0.65f;
        } else
        // GREATER THAN ROUND 8
        {
            _maxDarts       = 30;
            _speed          = 7;
            healthChance    = 0.20f;
            cloudChance     = 0.65f;
        }
    }
    // Now check the chance timer for > 3500
    // and create health and clouds accordingly
    // to their chances
    if ([_chanceTimer ticks] > 3500)
    {
        // Cloud isn't on screen (i.e. doesn't exist) and
        // rnd is < chance possibility?
        if (![_canvas getSprite:[DDCloud class]] &&
            [SGUtils rnd] < cloudChance)
        {
            [self spawnCloud];
        }
        // Health isn't on screen (i.e. doesn't exist) and
        // rnd is < chance possibility?
        if (![_canvas getSprite:[DDCloud class]] &&
            [SGUtils rnd] < healthChance)
        {
            [self spawnHealth];
        }
        
        // Reset the timer for next time
        [_chanceTimer reset];
    }
}

/**
 * @brief   Adds a singular dart, which is created
 *          and initalised here, to _darts
 *
 * @note    This method is private.
 */
-(void)spawnDart
{
    DDDart* dartToAdd = [[DDDart alloc] initInGame:self];
    [_darts addObject:dartToAdd];
    [dartToAdd release];
}

/**
 * @brief   Creates a singular cloud object moving
 *          in a random direction (either left or 
 *          right).
 *
 * @note    This method is private.
 */
-(void)spawnCloud
{
    // 50/50 Chance
    float side = [SGUtils rnd];
    DDDirection dir;
    
    if (side > 0.50f) { dir = DDRIGHT; }
    else              { dir = DDLEFT;  }
    
    // Although this variable is unused, it is still referenced
    // by the _canvas' _sprites collection; ARC therefore doesn't
    // destroy it because it is still being referenced!
    DDCloud* __unused cloud = [[DDCloud alloc] initInGame:self inDirection:dir];
}

/**
 * @brief   Creates a singular health kit object 
 *
 * @note    This method is private.
 */
-(void)spawnHealth
{
    // Although this variable is unused, it is still referenced
    // by the _canvas' _sprites collection; ARC therefore doesn't
    // destroy it because it is still being referenced!
    DDHealth* __unused health = [[DDHealth alloc] initInGame:self];
}

@end
