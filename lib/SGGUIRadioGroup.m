#import "SGGUIRadioGroup.h"

#import <stdlib.h>

#import "SGSDK.h"
#import "SwinGame.h"

@implementation SGGUIRadioGroup : NSObject

+ (void) getGUIRadioGroups:(guiradio_group *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz
{
    int i;
    int count = [in_data count];
    count = count <= sz ? count : sz; //get min of sz and count
    for ( i = 0; i < count; i++ ) 
    {
        SGGUIRadioGroup *obj = [in_data objectAtIndex:i];
        *(firstPtr + i) = obj->pointer;
    }
}

+ (NSArray *) arrayOfGUIRadioGroups:(guiradio_group *)firstPtr size:(int)sz
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:sz];
    int i;
    SGGUIRadioGroup *obj;
    
    for (i = 0; i < sz; i++)
    {
        obj = [SGGUIRadioGroup createWithId: *(firstPtr + i)];
        [result addObject: obj];
    }
    
    return [result autorelease];
}

+ (id)createWithId:(guiradio_group)ptr
{
    if (ptr == nil) return nil;
    id obj = [PointerManager objectForKey: (id)ptr];
    
    if (obj == nil)
    {
        // Create and assign to obj...
        obj = [[[self alloc] initWithId:ptr] autorelease];
    }
    
    return obj;
}

- (id)initWithId:(guiradio_group)ptr
{
    if (ptr == nil)
    {
        [self release];
        return nil;
    }
    //Assign super's initialised value to the self pointer
    self = [super init];
    if (self != nil)
    {
        //If self isn't nil then assign pointer.
        pointer = ptr;
        [PointerManager registerObject:self withKey:(id)ptr];
    }
    return self;
}

- (void)releasePointer
{
    pointer = nil;
}



- (id)initOnPanel:(SGPanel *)pnl  withId :(NSString *)id
{
    char id_temp[[id length] + 1];
    SGGUIRadioGroup * result;
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    result = [self initWithId: sg_UserInterface_RadioGroupOnPanelWidthId(pnl->pointer, id_temp)];
    return result;
}






@end
