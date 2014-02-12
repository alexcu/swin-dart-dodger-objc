#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "SGNetworking.h"
#import "SGSDK.h"
#import "SwinGame.h"

#import <stdlib.h>

@implementation SGNetworking : NSObject


+ (int)acceptTCPConnection
{
    int result;
    result = sg_Networking_AcceptTCPConnection();
    return result;
}

+ (void)broadcastTCPMessage:(NSString *)aMsg
{
    char aMsg_temp[[aMsg length] + 1];
    [aMsg getCString:aMsg_temp maxLength:[aMsg length] + 1 encoding:NSASCIIStringEncoding];
    sg_Networking_BroadcastTCPMessage(aMsg_temp);
}

+ (void)broadcastUDPMessage:(NSString *)aMsg
{
    char aMsg_temp[[aMsg length] + 1];
    [aMsg getCString:aMsg_temp maxLength:[aMsg length] + 1 encoding:NSASCIIStringEncoding];
    sg_Networking_BroadcastUDPMessage(aMsg_temp);
}

+ (void)clearMessageQueue:(SGConnection *)aConnection
{
    sg_Networking_ClearMessageQueue(aConnection->pointer);
}

+ (void)closeAllConnections
{
    sg_Networking_CloseAllConnections();
}

+ (void)closeAllSockets
{
    sg_Networking_CloseAllSockets();
}

+ (void)closeAllTCPHostSockets
{
    sg_Networking_CloseAllTCPHostSockets();
}

+ (void)closeAllUDPSockets
{
    sg_Networking_CloseAllUDPSockets();
}

+ (BOOL)closeConnection:(SGConnection *)aConnection
{
    BOOL result;
    result = sg_Networking_CloseConnection(&aConnection->pointer) != 0;
    return result;
}

+ (BOOL)closeTCPHostSocketPort:(int)aPort
{
    BOOL result;
    result = sg_Networking_CloseTCPHostSocket(aPort) != 0;
    return result;
}

+ (BOOL)closeUDPSocket:(int)aPort
{
    BOOL result;
    result = sg_Networking_CloseUDPSocket(aPort) != 0;
    return result;
}

+ (int)connectionCount
{
    int result;
    result = sg_Networking_ConnectionCount();
    return result;
}

+ (uint)connectionIP:(SGConnection *)aConnection
{
    uint result;
    result = sg_Networking_ConnectionIP(aConnection->pointer);
    return result;
}

+ (int)connectionPort:(SGConnection *)aConnection
{
    int result;
    result = sg_Networking_ConnectionPort(aConnection->pointer);
    return result;
}

+ (int)connectionQueueSize
{
    int result;
    result = sg_Networking_ConnectionQueueSize();
    return result;
}

+ (SGConnection *)createTCPConnection:(NSString *)aIP  port:(int)aPort
{
    char aIP_temp[[aIP length] + 1];
    SGConnection * result;
    [aIP getCString:aIP_temp maxLength:[aIP length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGConnection createWithId:sg_Networking_CreateTCPConnection(aIP_temp, aPort)];
    return result;
}

+ (BOOL)createTCPHost:(int)aPort
{
    BOOL result;
    result = sg_Networking_CreateTCPHost(aPort) != 0;
    return result;
}

+ (SGConnection *)createUDPConnectionIP:(NSString *)aDestIP  port:(int)aDestPort  inPort:(int)aInPort
{
    char aDestIP_temp[[aDestIP length] + 1];
    SGConnection * result;
    [aDestIP getCString:aDestIP_temp maxLength:[aDestIP length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGConnection createWithId:sg_Networking_CreateUDPConnection(aDestIP_temp, aDestPort, aInPort)];
    return result;
}

+ (int)createUDPHost:(int)aPort
{
    int result;
    result = sg_Networking_CreateUDPHost(aPort);
    return result;
}

+ (NSString *)decToHex:(uint)aDec
{
    char result[2048];
    sg_Networking_DecToHex(aDec, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (void)enqueueMessage:(NSString *)aMsg  toConnection:(SGConnection *)aConnection
{
    char aMsg_temp[[aMsg length] + 1];
    [aMsg getCString:aMsg_temp maxLength:[aMsg length] + 1 encoding:NSASCIIStringEncoding];
    sg_Networking_EnqueueMessage(aMsg_temp, aConnection->pointer);
}

+ (void)enqueueNewConnection:(SGConnection *)aConnection
{
    sg_Networking_EnqueueNewConnection(aConnection->pointer);
}

+ (SGConnection *)fetchConnection
{
    SGConnection * result;
    result = [SGConnection createWithId:sg_Networking_FetchConnection()];
    return result;
}

+ (void)freeConnection:(SGConnection *)aConnection
{
    sg_Networking_FreeConnection(&aConnection->pointer);
}

+ (NSString *)hexStrToIPv4:(NSString *)aHex
{
    char aHex_temp[[aHex length] + 1];
    char result[2048];
    [aHex getCString:aHex_temp maxLength:[aHex length] + 1 encoding:NSASCIIStringEncoding];
    sg_Networking_HexStrToIPv4(aHex_temp, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)hexToDecString:(NSString *)aHex
{
    char aHex_temp[[aHex length] + 1];
    char result[2048];
    [aHex getCString:aHex_temp maxLength:[aHex length] + 1 encoding:NSASCIIStringEncoding];
    sg_Networking_HexToDecString(aHex_temp, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (uint)iPv4ToDec:(NSString *)aIP
{
    char aIP_temp[[aIP length] + 1];
    uint result;
    [aIP getCString:aIP_temp maxLength:[aIP length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_Networking_IPv4ToDec(aIP_temp);
    return result;
}

+ (int)messageCountOnConnection:(SGConnection *)aConnection
{
    int result;
    result = sg_Networking_MessageCount(aConnection->pointer);
    return result;
}

+ (NSString *)myIP
{
    char result[2048];
    sg_Networking_MyIP(result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)readLastMessage:(SGConnection *)aConnection
{
    char result[2048];
    sg_Networking_ReadLastMessage(aConnection->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)readMessage:(SGConnection *)aConnection
{
    char result[2048];
    sg_Networking_ReadMessage(aConnection->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (void)releaseAllConnections
{
    sg_Networking_ReleaseAllConnections();
}

+ (SGConnection *)retreiveConnection:(int)aConnectionAt
{
    SGConnection * result;
    result = [SGConnection createWithId:sg_Networking_RetreiveConnection(aConnectionAt)];
    return result;
}

+ (SGConnection *)sendTCPMessage:(NSString *)aMsg  toConnection:(SGConnection *)aConnection
{
    char aMsg_temp[[aMsg length] + 1];
    SGConnection * result;
    [aMsg getCString:aMsg_temp maxLength:[aMsg length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGConnection createWithId:sg_Networking_SendTCPMessage(aMsg_temp, aConnection->pointer)];
    return result;
}

+ (BOOL)sendUDPMessage:(NSString *)aMsg  toConnection:(SGConnection *)aConnection
{
    char aMsg_temp[[aMsg length] + 1];
    BOOL result;
    [aMsg getCString:aMsg_temp maxLength:[aMsg length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_Networking_SendUDPMessage(aMsg_temp, aConnection->pointer) != 0;
    return result;
}

+ (BOOL)tCPMessageReceived
{
    BOOL result;
    result = sg_Networking_TCPMessageReceived() != 0;
    return result;
}

+ (BOOL)uDPMessageReceived
{
    BOOL result;
    result = sg_Networking_UDPMessageReceived() != 0;
    return result;
}









@end
