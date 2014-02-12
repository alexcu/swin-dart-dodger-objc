#import "SGConnection.h"

#import <stdlib.h>

#import "SGSDK.h"
#import "SwinGame.h"

@implementation SGConnection : NSObject

+ (void) getConnections:(connection *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz
{
    int i;
    int count = [in_data count];
    count = count <= sz ? count : sz; //get min of sz and count
    for ( i = 0; i < count; i++ ) 
    {
        SGConnection *obj = [in_data objectAtIndex:i];
        *(firstPtr + i) = obj->pointer;
    }
}

+ (NSArray *) arrayOfConnections:(connection *)firstPtr size:(int)sz
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:sz];
    int i;
    SGConnection *obj;
    
    for (i = 0; i < sz; i++)
    {
        obj = [SGConnection createWithId: *(firstPtr + i)];
        [result addObject: obj];
    }
    
    return [result autorelease];
}

+ (id)createWithId:(connection)ptr
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

- (id)initWithId:(connection)ptr
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







- (void)clearMessageQueue
{
    sg_Networking_ClearMessageQueue(self->pointer);
}

- (BOOL)close
{
    BOOL result;
    result = sg_Networking_CloseConnection(&self->pointer) != 0;
    return result;
}

- (uint)connectionIP
{
    uint result;
    result = sg_Networking_ConnectionIP(self->pointer);
    return result;
}

- (int)connectionPort
{
    int result;
    result = sg_Networking_ConnectionPort(self->pointer);
    return result;
}

- (void)enqueueMessage:(NSString *)aMsg
{
    char aMsg_temp[[aMsg length] + 1];
    [aMsg getCString:aMsg_temp maxLength:[aMsg length] + 1 encoding:NSASCIIStringEncoding];
    sg_Networking_EnqueueMessage(aMsg_temp, self->pointer);
}

- (void)enqueueNewConnection
{
    sg_Networking_EnqueueNewConnection(self->pointer);
}

- (int)messageCount
{
    int result;
    result = sg_Networking_MessageCount(self->pointer);
    return result;
}

- (NSString *)readLastMessage
{
    char result[2048];
    sg_Networking_ReadLastMessage(self->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

- (NSString *)readMessage
{
    char result[2048];
    sg_Networking_ReadMessage(self->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

- (SGConnection *)sendTCPMessage:(NSString *)aMsg
{
    char aMsg_temp[[aMsg length] + 1];
    SGConnection * result;
    [aMsg getCString:aMsg_temp maxLength:[aMsg length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGConnection createWithId:sg_Networking_SendTCPMessage(aMsg_temp, self->pointer)];
    return result;
}

- (BOOL)sendUDPMessage:(NSString *)aMsg
{
    char aMsg_temp[[aMsg length] + 1];
    BOOL result;
    [aMsg getCString:aMsg_temp maxLength:[aMsg length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_Networking_SendUDPMessage(aMsg_temp, self->pointer) != 0;
    return result;
}

- (void)free
{
    sg_Networking_FreeConnection(&self->pointer);
}


@end
