#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "SGAnimations.h"
#import "SGSDK.h"
#import "SwinGame.h"

#import <stdlib.h>

@implementation SGAnimations : NSObject


+ (int)animationCurrentCell:(SGAnimation *)anim
{
    int result;
    result = sg_Animations_AnimationCurrentCell(anim->pointer);
    return result;
}

+ (SGVector *)animationCurrentVector:(SGAnimation *)anim
{
    SGVector * result;
    result = [SGVector vectorForData:sg_Animations_AnimationCurrentVector(anim->pointer)];
    return result;
}

+ (BOOL)animationEnded:(SGAnimation *)anim
{
    BOOL result;
    result = sg_Animations_AnimationEnded(anim->pointer) != 0;
    return result;
}

+ (BOOL)animationEnteredFrame:(SGAnimation *)anim
{
    BOOL result;
    result = sg_Animations_AnimationEnteredFrame(anim->pointer) != 0;
    return result;
}

+ (float)animationFrameTime:(SGAnimation *)anim
{
    float result;
    result = sg_Animations_AnimationFrameTime(anim->pointer);
    return result;
}

+ (int)animationScript:(SGAnimationScript *)temp  indexOfAnimation:(NSString *)name
{
    char name_temp[[name length] + 1];
    int result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_Animations_AnimationIndex(temp->pointer, name_temp);
    return result;
}

+ (NSString *)animationScript:(SGAnimationScript *)temp  nameOfAnimation:(int)idx
{
    char result[2048];
    sg_Animations_AnimationName(temp->pointer, idx, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)animationScriptName:(SGAnimationScript *)script
{
    char result[2048];
    sg_Animations_AnimationScriptName(script->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (SGAnimationScript *)animationScriptNamed:(NSString *)name
{
    char name_temp[[name length] + 1];
    SGAnimationScript * result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGAnimationScript createWithId:sg_Animations_AnimationScriptNamed(name_temp)];
    return result;
}

+ (void)assignAnimationNamed:(SGAnimation *)anim  to:(NSString *)name  from:(SGAnimationScript *)script
{
    char name_temp[[name length] + 1];
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    sg_Animations_AssignAnimationNamed(anim->pointer, name_temp, script->pointer);
}

+ (void)assignAnimation:(SGAnimation *)anim  to:(int)idx  from:(SGAnimationScript *)script
{
    sg_Animations_AssignAnimation(anim->pointer, idx, script->pointer);
}

+ (void)assignAnimationNamed:(SGAnimation *)anim  to:(NSString *)name  from:(SGAnimationScript *)script  withSound:(BOOL)withSound
{
    char name_temp[[name length] + 1];
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    sg_Animations_AssignAnimationNamedWithSound(anim->pointer, name_temp, script->pointer, (withSound ? 1 : 0));
}

+ (void)assignAnimation:(SGAnimation *)anim  to:(int)idx  from:(SGAnimationScript *)script  withSound:(BOOL)withSound
{
    sg_Animations_AssignAnimationWithSound(anim->pointer, idx, script->pointer, (withSound ? 1 : 0));
}

+ (SGAnimation *)animationAtIndex:(int)identifier  from:(SGAnimationScript *)script
{
    SGAnimation * result;
    result = [SGAnimation createWithId:sg_Animations_CreateAnimationWithSound(identifier, script->pointer)];
    return result;
}

+ (SGAnimation *)animationNamed:(NSString *)identifier  from:(SGAnimationScript *)script
{
    char identifier_temp[[identifier length] + 1];
    SGAnimation * result;
    [identifier getCString:identifier_temp maxLength:[identifier length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGAnimation createWithId:sg_Animations_CreateAnimationNamed(identifier_temp, script->pointer)];
    return result;
}

+ (SGAnimation *)animationAtIndex:(int)identifier  from:(SGAnimationScript *)script  withSound:(BOOL)withSound
{
    SGAnimation * result;
    result = [SGAnimation createWithId:sg_Animations_CreateAnimation(identifier, script->pointer, (withSound ? 1 : 0))];
    return result;
}

+ (SGAnimation *)animationNamed:(NSString *)identifier  from:(SGAnimationScript *)script  withSound:(BOOL)withSound
{
    char identifier_temp[[identifier length] + 1];
    SGAnimation * result;
    [identifier getCString:identifier_temp maxLength:[identifier length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGAnimation createWithId:sg_Animations_CreateAnimationNamedWithSound(identifier_temp, script->pointer, (withSound ? 1 : 0))];
    return result;
}

+ (void)drawAnimation:(SGAnimation *)ani  bitmap:(SGBitmap *)bmp  pt:(SGPoint2D *)pt
{
    sg_Animations_DrawAnimationAtPoint(ani->pointer, bmp->pointer, &pt->data);
}

+ (void)drawAnimation:(SGAnimation *)ani  bitmap:(SGBitmap *)bmp  x:(int)x  y:(int)y
{
    sg_Animations_DrawAnimation(ani->pointer, bmp->pointer, x, y);
}

+ (void)drawOnto:(SGBitmap *)dest  animation:(SGAnimation *)ani  bitmap:(SGBitmap *)bmp  pt:(SGPoint2D *)pt
{
    sg_Animations_DrawAnimationOntoDestAtPt(dest->pointer, ani->pointer, bmp->pointer, &pt->data);
}

+ (void)drawOnto:(SGBitmap *)dest  animation:(SGAnimation *)ani  bitmap:(SGBitmap *)bmp  x:(int)x  y:(int)y
{
    sg_Animations_DrawAnimationOntoDest(dest->pointer, ani->pointer, bmp->pointer, x, y);
}

+ (void)drawAnimation:(SGAnimation *)ani  bitmap:(SGBitmap *)bmp  onScreenAtPt:(SGPoint2D *)pt
{
    sg_Animations_DrawAnimationOnScreenAtPt(ani->pointer, bmp->pointer, &pt->data);
}

+ (void)drawAnimation:(SGAnimation *)ani  bitmap:(SGBitmap *)bmp  onScreenAtX:(int)x  y:(int)y
{
    sg_Animations_DrawAnimationOnScreen(ani->pointer, bmp->pointer, x, y);
}

+ (void)freeAnimation:(SGAnimation *)ani
{
    sg_Animations_FreeAnimation(&ani->pointer);
}

+ (void)freeAnimationScript:(SGAnimationScript *)scriptToFree
{
    sg_Animations_FreeAnimationScript(&scriptToFree->pointer);
}

+ (BOOL)hasAnimationScript:(NSString *)name
{
    char name_temp[[name length] + 1];
    BOOL result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_Animations_HasAnimationScript(name_temp) != 0;
    return result;
}

+ (SGAnimationScript *)loadAnimationScriptFromFile:(NSString *)filename
{
    char filename_temp[[filename length] + 1];
    SGAnimationScript * result;
    [filename getCString:filename_temp maxLength:[filename length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGAnimationScript createWithId:sg_Animations_LoadAnimationScript(filename_temp)];
    return result;
}

+ (SGAnimationScript *)loadAnimationScriptNamed:(NSString *)name  fromFile:(NSString *)filename
{
    char name_temp[[name length] + 1];
    char filename_temp[[filename length] + 1];
    SGAnimationScript * result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    [filename getCString:filename_temp maxLength:[filename length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGAnimationScript createWithId:sg_Animations_LoadAnimationScriptNamed(name_temp, filename_temp)];
    return result;
}

+ (void)releaseAllAnimationScripts
{
    sg_Animations_ReleaseAllAnimationScripts();
}

+ (void)releaseAnimationScript:(NSString *)name
{
    char name_temp[[name length] + 1];
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    sg_Animations_ReleaseAnimationScript(name_temp);
}

+ (void)restartAnimation:(SGAnimation *)anim
{
    sg_Animations_RestartAnimation(anim->pointer);
}

+ (void)resetAnimation:(SGAnimation *)anim  withSound:(BOOL)withSound
{
    sg_Animations_ResetAnimationWithSound(anim->pointer, (withSound ? 1 : 0));
}

+ (void)updateAnimation:(SGAnimation *)anim
{
    sg_Animations_UpdateAnimation(anim->pointer);
}

+ (void)updateAnimation:(SGAnimation *)anim  pct:(float)pct
{
    sg_Animations_UpdateAnimationPct(anim->pointer, pct);
}

+ (void)updateAnimation:(SGAnimation *)anim  pct:(float)pct  withSound:(BOOL)withSound
{
    sg_Animations_UpdateAnimationPctAndSound(anim->pointer, pct, (withSound ? 1 : 0));
}









@end
