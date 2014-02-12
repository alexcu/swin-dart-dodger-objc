#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "SGUserInterface.h"
#import "SGSDK.h"
#import "SwinGame.h"

#import <stdlib.h>

@implementation SGUserInterface : NSObject


+ (void)activatePanel:(SGPanel *)p
{
    sg_UserInterface_ActivatePanel(p->pointer);
}

+ (SGRegion *)activeRadioButton:(SGGUIRadioGroup *)grp
{
    SGRegion * result;
    result = [SGRegion createWithId:sg_UserInterface_ActiveRadioButton(grp->pointer)];
    return result;
}

+ (SGRegion *)activeRadioButtonWithID:(NSString *)id
{
    char id_temp[[id length] + 1];
    SGRegion * result;
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGRegion createWithId:sg_UserInterface_ActiveRadioButtonWithID(id_temp)];
    return result;
}

+ (SGRegion *)activeRadioButtonOnPanel:(SGPanel *)pnl  withId:(NSString *)id
{
    char id_temp[[id length] + 1];
    SGRegion * result;
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGRegion createWithId:sg_UserInterface_ActiveRadioButtonOnPanelWithId(pnl->pointer, id_temp)];
    return result;
}

+ (int)activeRadioButtonIndex:(SGGUIRadioGroup *)RadioGroup
{
    int result;
    result = sg_UserInterface_ActiveRadioButtonIndex(RadioGroup->pointer);
    return result;
}

+ (int)activeRadioButtonIndexFromID:(NSString *)id
{
    char id_temp[[id length] + 1];
    int result;
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_ActiveRadioButtonIndexFromID(id_temp);
    return result;
}

+ (int)activeRadioButtonIndexOnPanel:(SGPanel *)pnl  withId:(NSString *)id
{
    char id_temp[[id length] + 1];
    int result;
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_ActiveRadioButtonIndexOnPanel(pnl->pointer, id_temp);
    return result;
}

+ (SGPanel *)activeTextBoxParent
{
    SGPanel * result;
    result = [SGPanel createWithId:sg_UserInterface_ActiveTextBoxParent()];
    return result;
}

+ (int)activeTextIndex
{
    int result;
    result = sg_UserInterface_ActiveTextIndex();
    return result;
}

+ (BOOL)buttonNamedClicked:(NSString *)name
{
    char name_temp[[name length] + 1];
    BOOL result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_ButtonNamedClicked(name_temp) != 0;
    return result;
}

+ (BOOL)buttonClicked:(SGRegion *)r
{
    BOOL result;
    result = sg_UserInterface_ButtonClicked(r->pointer) != 0;
    return result;
}

+ (SGGUICheckbox *)checkboxFromRegion:(SGRegion *)r
{
    SGGUICheckbox * result;
    result = [SGGUICheckbox createWithId:sg_UserInterface_CheckboxFromRegion(r->pointer)];
    return result;
}

+ (void)checkBox:(SGGUICheckbox *)chk  setCheckBoxState:(BOOL)val
{
    sg_UserInterface_CheckboxSetState(chk->pointer, (val ? 1 : 0));
}

+ (void)checkbox:(NSString *)id  setState:(BOOL)val
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_CheckBoxSetStateWithId(id_temp, (val ? 1 : 0));
}

+ (void)region:(SGRegion *)r  setCheckBotState:(BOOL)val
{
    sg_UserInterface_CheckboxSetStateFromRegion(r->pointer, (val ? 1 : 0));
}

+ (void)checkboxOnPanel:(SGPanel *)pnl  withID:(NSString *)id  setState:(BOOL)val
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_CheckboxSetStateOnPanel(pnl->pointer, id_temp, (val ? 1 : 0));
}

+ (BOOL)checkboxStateFromRegion:(SGRegion *)r
{
    BOOL result;
    result = sg_UserInterface_CheckboxStateFromRegion(r->pointer) != 0;
    return result;
}

+ (BOOL)checkboxState:(NSString *)s
{
    char s_temp[[s length] + 1];
    BOOL result;
    [s getCString:s_temp maxLength:[s length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_CheckboxState(s_temp) != 0;
    return result;
}

+ (BOOL)checkboxStateFromCheckbox:(SGGUICheckbox *)chk
{
    BOOL result;
    result = sg_UserInterface_CheckboxStateFromCheckbox(chk->pointer) != 0;
    return result;
}

+ (BOOL)panel:(SGPanel *)p  checkboxStateForId:(NSString *)s
{
    char s_temp[[s length] + 1];
    BOOL result;
    [s getCString:s_temp maxLength:[s length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_CheckboxStateOnPanel(p->pointer, s_temp) != 0;
    return result;
}

+ (void)deactivatePanel:(SGPanel *)p
{
    sg_UserInterface_DeactivatePanel(p->pointer);
}

+ (void)deactivateTextBox
{
    sg_UserInterface_DeactivateTextBox();
}

+ (BOOL)dialogCancelled
{
    BOOL result;
    result = sg_UserInterface_DialogCancelled() != 0;
    return result;
}

+ (BOOL)dialogComplete
{
    BOOL result;
    result = sg_UserInterface_DialogComplete() != 0;
    return result;
}

+ (NSString *)dialogPath
{
    char result[2048];
    sg_UserInterface_DialogPath(result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (void)dialogSetPath:(NSString *)fullname
{
    char fullname_temp[[fullname length] + 1];
    [fullname getCString:fullname_temp maxLength:[fullname length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_DialogSetPath(fullname_temp);
}

+ (void)drawGUIAsVectors:(BOOL)b
{
    sg_UserInterface_DrawGUIAsVectors((b ? 1 : 0));
}

+ (void)drawInterface
{
    sg_UserInterface_DrawInterface();
}

+ (void)finishReadingText
{
    sg_UserInterface_FinishReadingText();
}

+ (void)freePanel:(SGPanel *)pnl
{
    sg_UserInterface_FreePanel(&pnl->pointer);
}

+ (BOOL)gUIClicked
{
    BOOL result;
    result = sg_UserInterface_GUIClicked() != 0;
    return result;
}

+ (void)gUISetActiveTextboxFromRegion:(SGRegion *)r
{
    sg_UserInterface_GUISetActiveTextboxFromRegion(r->pointer);
}

+ (void)gUISetActiveTextboxNamed:(NSString *)name
{
    char name_temp[[name length] + 1];
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_GUISetActiveTextboxNamed(name_temp);
}

+ (void)gUISetActiveTextbox:(SGGUITextbox *)t
{
    sg_UserInterface_GUISetActiveTextbox(t->pointer);
}

+ (void)gUISetBackgroundColor:(color)c
{
    sg_UserInterface_GUISetBackgroundColor(c);
}

+ (void)gUISetBackgroundColorInactive:(color)c
{
    sg_UserInterface_GUISetBackgroundColorInactive(c);
}

+ (void)gUISetForegroundColor:(color)c
{
    sg_UserInterface_GUISetForegroundColor(c);
}

+ (void)gUISetForegroundColorInactive:(color)c
{
    sg_UserInterface_GUISetForegroundColorInactive(c);
}

+ (SGGUITextbox *)gUITextBoxOfTextEntered
{
    SGGUITextbox * result;
    result = [SGGUITextbox createWithId:sg_UserInterface_GUITextBoxOfTextEntered()];
    return result;
}

+ (BOOL)gUITextEntryComplete
{
    BOOL result;
    result = sg_UserInterface_GUITextEntryComplete() != 0;
    return result;
}

+ (BOOL)hasPanel:(NSString *)name
{
    char name_temp[[name length] + 1];
    BOOL result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_HasPanel(name_temp) != 0;
    return result;
}

+ (void)hidePanelNamed:(NSString *)name
{
    char name_temp[[name length] + 1];
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_HidePanelNamed(name_temp);
}

+ (void)hidePanel:(SGPanel *)p
{
    sg_UserInterface_HidePanel(p->pointer);
}

+ (int)indexOfLastUpdatedTextBox
{
    int result;
    result = sg_UserInterface_IndexOfLastUpdatedTextBox();
    return result;
}

+ (BOOL)isDragging
{
    BOOL result;
    result = sg_UserInterface_IsDragging() != 0;
    return result;
}

+ (BOOL)panelIsDragging:(SGPanel *)pnl
{
    BOOL result;
    result = sg_UserInterface_PanelIsDragging(pnl->pointer) != 0;
    return result;
}

+ (font_alignment)labelAlignementFromRegion:(SGRegion *)r
{
    font_alignment result;
    result = (font_alignment)sg_UserInterface_LabelAlignementFromRegion(r->pointer);
    return result;
}

+ (font_alignment)labelAlignment:(SGGUILabel *)lbl
{
    font_alignment result;
    result = (font_alignment)sg_UserInterface_LabelAlignment(lbl->pointer);
    return result;
}

+ (SGFont *)labelFromRegionGetFont:(SGRegion *)r
{
    SGFont * result;
    result = [SGFont createWithId:sg_UserInterface_LabelFromRegionGetFont(r->pointer)];
    return result;
}

+ (SGFont *)labelFont:(SGGUILabel *)l
{
    SGFont * result;
    result = [SGFont createWithId:sg_UserInterface_LabelFont(l->pointer)];
    return result;
}

+ (SGGUILabel *)labelFromRegion:(SGRegion *)r
{
    SGGUILabel * result;
    result = [SGGUILabel createWithId:sg_UserInterface_LabelFromRegion(r->pointer)];
    return result;
}

+ (void)labelFromRegion:(SGRegion *)r  setAlignment:(font_alignment)align
{
    sg_UserInterface_SetLabelAlignmentFromRegion(r->pointer, (int)align);
}

+ (void)label:(SGGUILabel *)tb  setAlignment:(font_alignment)align
{
    sg_UserInterface_SetLabelAlignment(tb->pointer, (int)align);
}

+ (void)label:(SGGUILabel *)l  setFont:(NSString *)s
{
    char s_temp[[s length] + 1];
    [s getCString:s_temp maxLength:[s length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_LabelSetFont(l->pointer, s_temp);
}

+ (void)label:(SGGUILabel *)lb  setText:(NSString *)newString
{
    char newString_temp[[newString length] + 1];
    [newString getCString:newString_temp maxLength:[newString length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_LabelSetText(lb->pointer, newString_temp);
}

+ (void)labelForRegion:(SGRegion *)r  setText:(NSString *)newString
{
    char newString_temp[[newString length] + 1];
    [newString getCString:newString_temp maxLength:[newString length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_LabelFromRegionSetText(r->pointer, newString_temp);
}

+ (void)labelWithId:(NSString *)id  setText:(NSString *)newString
{
    char id_temp[[id length] + 1];
    char newString_temp[[newString length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    [newString getCString:newString_temp maxLength:[newString length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_LabelWithIdSetText(id_temp, newString_temp);
}

+ (void)labelOnPanel:(SGPanel *)pnl  withId:(NSString *)id  setText:(NSString *)newString
{
    char id_temp[[id length] + 1];
    char newString_temp[[newString length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    [newString getCString:newString_temp maxLength:[newString length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_LabelOnPanelWithIdSetText(pnl->pointer, id_temp, newString_temp);
}

+ (NSString *)labelTextFromRegion:(SGRegion *)r
{
    char result[2048];
    sg_UserInterface_LabelTextFromRegion(r->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)labelText:(SGGUILabel *)lb
{
    char result[2048];
    sg_UserInterface_LabelText(lb->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)labelTextWithId:(NSString *)id
{
    char id_temp[[id length] + 1];
    char result[2048];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_LabelTextWithId(id_temp, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)textOfLabelOnPanel:(SGPanel *)pnl  withId:(NSString *)id
{
    char id_temp[[id length] + 1];
    char result[2048];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_LabelTextOnPanelWithId(pnl->pointer, id_temp, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (int)listActiveItemIndex:(SGGUIList *)lst
{
    int result;
    result = sg_UserInterface_ListActiveItemIndex(lst->pointer);
    return result;
}

+ (int)listActiveItemIndexWithId:(NSString *)id
{
    char id_temp[[id length] + 1];
    int result;
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_ListActiveItemIndexWithId(id_temp);
    return result;
}

+ (int)listActiveItemIndexFromRegion:(SGRegion *)r
{
    int result;
    result = sg_UserInterface_ListActiveItemIndexFromRegion(r->pointer);
    return result;
}

+ (int)listActiveItemIndexOnPanel:(SGPanel *)pnl  withId:(NSString *)id
{
    char id_temp[[id length] + 1];
    int result;
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_ListActiveItemIndexOnPanelWithId(pnl->pointer, id_temp);
    return result;
}

+ (NSString *)listActiveItemText:(SGGUIList *)list
{
    char result[2048];
    sg_UserInterface_ListActiveItemText(list->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)listActiveItemTextFromRegion:(SGRegion *)r
{
    char result[2048];
    sg_UserInterface_ListActiveItemTextFromRegion(r->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)listWithIdActiveItemText:(NSString *)ID
{
    char ID_temp[[ID length] + 1];
    char result[2048];
    [ID getCString:ID_temp maxLength:[ID length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListWithIdActiveItemText(ID_temp, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)listActiveItemTextOnPanel:(SGPanel *)pnl  withId:(NSString *)ID
{
    char ID_temp[[ID length] + 1];
    char result[2048];
    [ID getCString:ID_temp maxLength:[ID length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListActiveItemTextOnPanelWithId(pnl->pointer, ID_temp, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (void)list:(SGGUIList *)lst  addBitmap:(SGBitmap *)img
{
    sg_UserInterface_AddItemByBitmap(lst->pointer, img->pointer);
}

+ (void)listWithId:(NSString *)id  addBitmap:(SGBitmap *)img
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_AddItemWithIdByBitmap(id_temp, img->pointer);
}

+ (void)list:(SGGUIList *)lst  addBitmapCell:(SGBitmapCell *)img
{
    sg_UserInterface_ListAddItemWithCell(lst->pointer, &img->data);
}

+ (void)list:(SGGUIList *)lst  addText:(NSString *)text
{
    char text_temp[[text length] + 1];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_AddItemByText(lst->pointer, text_temp);
}

+ (void)listWithId:(NSString *)id  addText:(NSString *)text
{
    char id_temp[[id length] + 1];
    char text_temp[[text length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_AddItemWithIdByText(id_temp, text_temp);
}

+ (void)listForRegion:(SGRegion *)r  addBitmap:(SGBitmap *)img
{
    sg_UserInterface_ListAddItemByBitmapFromRegion(r->pointer, img->pointer);
}

+ (void)region:(SGRegion *)r  addBitmapCell:(SGBitmapCell *)img
{
    sg_UserInterface_ListAddItemWithCellFromRegion(r->pointer, &img->data);
}

+ (void)listWithId:(NSString *)id  addBitmapCell:(SGBitmapCell *)img
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListWithIdAddItemWithCell(id_temp, &img->data);
}

+ (void)listOfRegion:(SGRegion *)r  addText:(NSString *)text
{
    char text_temp[[text length] + 1];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListAddItemByTextFromRegion(r->pointer, text_temp);
}

+ (void)listOnPanel:(SGPanel *)pnl  withId:(NSString *)id  addBitmap:(SGBitmap *)img
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListAddItemBitmap(pnl->pointer, id_temp, img->pointer);
}

+ (void)region:(SGRegion *)r  addBitmapCell:(SGBitmapCell *)img  andText:(NSString *)text
{
    char text_temp[[text length] + 1];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListAddItemWithCellAndTextFromRegion(r->pointer, &img->data, text_temp);
}

+ (void)list:(SGGUIList *)lst  addItemBitmap:(SGBitmap *)img  withText:(NSString *)text
{
    char text_temp[[text length] + 1];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListAddBitmapAndTextItem(lst->pointer, img->pointer, text_temp);
}

+ (void)listOnPanel:(SGPanel *)pnl  withId:(NSString *)id  addBitmapCell:(SGBitmapCell *)img
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListOnPanelWithIdAddItemWithCell(pnl->pointer, id_temp, &img->data);
}

+ (void)listById:(NSString *)id  addBitmap:(SGBitmap *)img  andText:(NSString *)text
{
    char id_temp[[id length] + 1];
    char text_temp[[text length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListWithIDAddBitmapWithTextItem(id_temp, img->pointer, text_temp);
}

+ (void)listForRegion:(SGRegion *)r  addBitmap:(SGBitmap *)img  andText:(NSString *)text
{
    char text_temp[[text length] + 1];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListAddBitmapAndTextItemFromRegion(r->pointer, img->pointer, text_temp);
}

+ (void)list:(SGGUIList *)lst  addBitmapCell:(SGBitmapCell *)img  andText:(NSString *)text
{
    char text_temp[[text length] + 1];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListAddItemWithCellAndText(lst->pointer, &img->data, text_temp);
}

+ (void)listOnPanel:(SGPanel *)pnl  withId:(NSString *)id  addText:(NSString *)text
{
    char id_temp[[id length] + 1];
    char text_temp[[text length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_AddItemOnPanelWithIdByText(pnl->pointer, id_temp, text_temp);
}

+ (void)listWithId:(NSString *)id  addBitmapCell:(SGBitmapCell *)img  andText:(NSString *)text
{
    char id_temp[[id length] + 1];
    char text_temp[[text length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListWithIdAddItemWithCellAndText(id_temp, &img->data, text_temp);
}

+ (void)listOnPanel:(SGPanel *)pnl  withId:(NSString *)id  addBitmapCell:(SGBitmapCell *)img  andText:(NSString *)text
{
    char id_temp[[id length] + 1];
    char text_temp[[text length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListOnPanelWithIdAddItemWithCellAndText(pnl->pointer, id_temp, &img->data, text_temp);
}

+ (void)listOnPanel:(SGPanel *)pnl  withId:(NSString *)id  addBitmap:(SGBitmap *)img  andText:(NSString *)text
{
    char id_temp[[id length] + 1];
    char text_temp[[text length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListOnPanelWithIdAddBitmapWithTextItem(pnl->pointer, id_temp, img->pointer, text_temp);
}

+ (int)list:(SGGUIList *)lst  indexOfBitmap:(SGBitmap *)img
{
    int result;
    result = sg_UserInterface_ListBitmapIndex(lst->pointer, img->pointer);
    return result;
}

+ (int)list:(SGGUIList *)lst  indexOfCell:(SGBitmapCell *)img
{
    int result;
    result = sg_UserInterface_ListBitmapCellIndex(lst->pointer, &img->data);
    return result;
}

+ (void)listclearItemsWithId:(NSString *)id
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListclearItemsWithId(id_temp);
}

+ (void)listClearItems:(SGGUIList *)lst
{
    sg_UserInterface_ListClearItems(lst->pointer);
}

+ (void)listClearItemsFromRegion:(SGRegion *)r
{
    sg_UserInterface_ListClearItemsFromRegion(r->pointer);
}

+ (void)clearItemsListOnPanel:(SGPanel *)pnl  withId:(NSString *)id
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListClearItemsGivenPanelWithId(pnl->pointer, id_temp);
}

+ (SGFont *)listFont:(SGGUIList *)lst
{
    SGFont * result;
    result = [SGFont createWithId:sg_UserInterface_ListFont(lst->pointer)];
    return result;
}

+ (SGFont *)listFontFromRegion:(SGRegion *)r
{
    SGFont * result;
    result = [SGFont createWithId:sg_UserInterface_ListFontFromRegion(r->pointer)];
    return result;
}

+ (font_alignment)listFontAlignment:(SGGUIList *)lst
{
    font_alignment result;
    result = (font_alignment)sg_UserInterface_ListFontAlignment(lst->pointer);
    return result;
}

+ (font_alignment)listFontAlignmentFromRegion:(SGRegion *)r
{
    font_alignment result;
    result = (font_alignment)sg_UserInterface_ListFontAlignmentFromRegion(r->pointer);
    return result;
}

+ (SGGUIList *)listFromRegion:(SGRegion *)r
{
    SGGUIList * result;
    result = [SGGUIList createWithId:sg_UserInterface_ListFromRegion(r->pointer)];
    return result;
}

+ (int)listItemCount:(SGGUIList *)lst
{
    int result;
    result = sg_UserInterface_ListItemCount(lst->pointer);
    return result;
}

+ (int)listItemCountFromRegion:(SGRegion *)r
{
    int result;
    result = sg_UserInterface_ListItemCountFromRegion(r->pointer);
    return result;
}

+ (int)listItemCountWithId:(NSString *)id
{
    char id_temp[[id length] + 1];
    int result;
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_ListItemCountWithId(id_temp);
    return result;
}

+ (int)listItemCountFrom:(SGPanel *)pnl  withId:(NSString *)id
{
    char id_temp[[id length] + 1];
    int result;
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_ListItemCountOnPanelWithId(pnl->pointer, id_temp);
    return result;
}

+ (NSString *)listWithId:(NSString *)id  textAtIndex:(int)idx
{
    char id_temp[[id length] + 1];
    char result[2048];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListItemTextFromId(id_temp, idx, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)list:(SGGUIList *)lst  textAtIndex:(int)idx
{
    char result[2048];
    sg_UserInterface_ListItemText(lst->pointer, idx, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)listForRegion:(SGRegion *)r  textAtIndex:(int)idx
{
    char result[2048];
    sg_UserInterface_ListItemTextFromRegion(r->pointer, idx, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)listOnPanel:(SGPanel *)pnl  withId :(NSString *)id  textAtIndex:(int)idx
{
    char id_temp[[id length] + 1];
    char result[2048];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListItemTextOnPanelWithId(pnl->pointer, id_temp, idx, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (int)listLargestStartIndex:(SGGUIList *)lst
{
    int result;
    result = sg_UserInterface_ListLargestStartIndex(lst->pointer);
    return result;
}

+ (void)listRemoveActiveItemFromRegion:(SGRegion *)r
{
    sg_UserInterface_ListRemoveActiveItemFromRegion(r->pointer);
}

+ (void)listRemoveActiveItemFromId:(NSString *)id
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListRemoveActiveItemFromId(id_temp);
}

+ (void)listRemoveActiveItemOnPanel:(SGPanel *)pnl  withId:(NSString *)id
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListRemoveActiveItemOnPanelWithId(pnl->pointer, id_temp);
}

+ (void)listWithId:(NSString *)id  removeItemAtIndex:(int)idx
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListRemoveItemFromWithId(id_temp, idx);
}

+ (void)list:(SGGUIList *)lst  removeItemAtIndex:(int)idx
{
    sg_UserInterface_ListRemoveItem(lst->pointer, idx);
}

+ (void)listOnPanel:(SGPanel *)pnl  withId:(NSString *)id  removeItemAtIndex:(int)idx
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListRemoveItemOnPanelWithId(pnl->pointer, id_temp, idx);
}

+ (int)listScrollIncrement:(SGGUIList *)lst
{
    int result;
    result = sg_UserInterface_ListScrollIncrement(lst->pointer);
    return result;
}

+ (void)listSetActiveItemWithId:(NSString *)id  atIndex:(int)idx
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListSetActiveItemIndexWithId(id_temp, idx);
}

+ (void)list:(SGGUIList *)lst  setActiveItemIndex:(int)idx
{
    sg_UserInterface_ListSetActiveItemIndex(lst->pointer, idx);
}

+ (void)listSetActiveItemFromPane:(SGPanel *)pnl  withId:(NSString *)id  at:(int)idx
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListSet(pnl->pointer, id_temp, idx);
}

+ (void)list:(SGGUIList *)lst  setFont:(SGFont *)f
{
    sg_UserInterface_ListSetFont(lst->pointer, f->pointer);
}

+ (void)listForRegion:(SGRegion *)r  setFontAlignment:(font_alignment)align
{
    sg_UserInterface_ListSetFontAlignmentFromRegion(r->pointer, (int)align);
}

+ (void)list:(SGGUIList *)lst  setFontAlignment:(font_alignment)align
{
    sg_UserInterface_ListSetFontAlignment(lst->pointer, (int)align);
}

+ (void)listForRegion:(SGRegion *)r  setStartat:(int)idx
{
    sg_UserInterface_ListSetStartingAtFromRegion(r->pointer, idx);
}

+ (void)list:(SGGUIList *)lst  setStartAt:(int)idx
{
    sg_UserInterface_ListSetStartingAt(lst->pointer, idx);
}

+ (int)listStartAt:(SGGUIList *)lst
{
    int result;
    result = sg_UserInterface_ListStartAt(lst->pointer);
    return result;
}

+ (int)listStartingAtFromRegion:(SGRegion *)r
{
    int result;
    result = sg_UserInterface_ListStartingAtFromRegion(r->pointer);
    return result;
}

+ (int)list:(SGGUIList *)lst  indexOfText:(NSString *)value
{
    char value_temp[[value length] + 1];
    int result;
    [value getCString:value_temp maxLength:[value length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_ListTextIndex(lst->pointer, value_temp);
    return result;
}

+ (SGPanel *)loadPanel:(NSString *)filename
{
    char filename_temp[[filename length] + 1];
    SGPanel * result;
    [filename getCString:filename_temp maxLength:[filename length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGPanel createWithId:sg_UserInterface_LoadPanel(filename_temp)];
    return result;
}

+ (SGPanel *)loadPanelNamed:(NSString *)name  fromFile:(NSString *)filename
{
    char name_temp[[name length] + 1];
    char filename_temp[[filename length] + 1];
    SGPanel * result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    [filename getCString:filename_temp maxLength:[filename length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGPanel createWithId:sg_UserInterface_LoadPanelNamed(name_temp, filename_temp)];
    return result;
}

+ (void)panel:(SGPanel *)p  moveBy:(SGVector *)mvmt
{
    sg_UserInterface_MovePanel(p->pointer, &mvmt->data);
}

+ (SGPanel *)createPanelNamed:(NSString *)pnlName
{
    char pnlName_temp[[pnlName length] + 1];
    SGPanel * result;
    [pnlName getCString:pnlName_temp maxLength:[pnlName length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGPanel createWithId:sg_UserInterface_NewPanel(pnlName_temp)];
    return result;
}

+ (BOOL)panelActive:(SGPanel *)pnl
{
    BOOL result;
    result = sg_UserInterface_PanelActive(pnl->pointer) != 0;
    return result;
}

+ (SGPanel *)panelAtPoint:(SGPoint2D *)pt
{
    SGPanel * result;
    result = [SGPanel createWithId:sg_UserInterface_PanelAtPoint(&pt->data)];
    return result;
}

+ (SGPanel *)panelClicked
{
    SGPanel * result;
    result = [SGPanel createWithId:sg_UserInterface_PanelClicked()];
    return result;
}

+ (BOOL)panelWasClicked:(SGPanel *)pnl
{
    BOOL result;
    result = sg_UserInterface_PanelWasClicked(pnl->pointer) != 0;
    return result;
}

+ (BOOL)panelDraggable:(SGPanel *)p
{
    BOOL result;
    result = sg_UserInterface_PanelDraggable(p->pointer) != 0;
    return result;
}

+ (NSString *)panelFilename:(SGPanel *)pnl
{
    char result[2048];
    sg_UserInterface_PanelFilename(pnl->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (int)panelHeight:(SGPanel *)p
{
    int result;
    result = sg_UserInterface_PanelHeight(p->pointer);
    return result;
}

+ (int)panelNamedHeight:(NSString *)name
{
    char name_temp[[name length] + 1];
    int result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_PanelNamedHeight(name_temp);
    return result;
}

+ (NSString *)panelName:(SGPanel *)pnl
{
    char result[2048];
    sg_UserInterface_PanelName(pnl->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (SGPanel *)panelNamed:(NSString *)name
{
    char name_temp[[name length] + 1];
    SGPanel * result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGPanel createWithId:sg_UserInterface_PanelNamed(name_temp)];
    return result;
}

+ (void)panel:(SGPanel *)p  setDraggable:(BOOL)b
{
    sg_UserInterface_PanelSetDraggable(p->pointer, (b ? 1 : 0));
}

+ (BOOL)panelVisible:(SGPanel *)p
{
    BOOL result;
    result = sg_UserInterface_PanelVisible(p->pointer) != 0;
    return result;
}

+ (int)panelNamedWidth:(NSString *)name
{
    char name_temp[[name length] + 1];
    int result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_PanelNamedWidth(name_temp);
    return result;
}

+ (int)panelWidth:(SGPanel *)p
{
    int result;
    result = sg_UserInterface_PanelWidth(p->pointer);
    return result;
}

+ (float)panelX:(SGPanel *)p
{
    float result;
    result = sg_UserInterface_PanelX(p->pointer);
    return result;
}

+ (float)panelY:(SGPanel *)p
{
    float result;
    result = sg_UserInterface_PanelY(p->pointer);
    return result;
}

+ (BOOL)pointInRegion:(SGPoint2D *)pt  ofPanel:(SGPanel *)p
{
    BOOL result;
    result = sg_UserInterface_PointInRegion(&pt->data, p->pointer) != 0;
    return result;
}

+ (BOOL)pointInRegion:(SGPoint2D *)pt  ofPanel:(SGPanel *)p  kind:(guielement_kind)kind
{
    BOOL result;
    result = sg_UserInterface_PointInRegionWithKind(&pt->data, p->pointer, (int)kind) != 0;
    return result;
}

+ (SGGUIRadioGroup *)radioGroupFromId:(NSString *)id
{
    char id_temp[[id length] + 1];
    SGGUIRadioGroup * result;
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGGUIRadioGroup createWithId:sg_UserInterface_RadioGroupFromId(id_temp)];
    return result;
}

+ (SGGUIRadioGroup *)radioGroupOnPanel:(SGPanel *)pnl  withId:(NSString *)id
{
    char id_temp[[id length] + 1];
    SGGUIRadioGroup * result;
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGGUIRadioGroup createWithId:sg_UserInterface_RadioGroupOnPanelWidthId(pnl->pointer, id_temp)];
    return result;
}

+ (SGGUIRadioGroup *)radioGroupFromRegion:(SGRegion *)r
{
    SGGUIRadioGroup * result;
    result = [SGGUIRadioGroup createWithId:sg_UserInterface_RadioGroupFromRegion(r->pointer)];
    return result;
}

+ (BOOL)regionActive:(SGRegion *)forRegion
{
    BOOL result;
    result = sg_UserInterface_RegionActive(forRegion->pointer) != 0;
    return result;
}

+ (SGRegion *)regionOnPanel:(SGPanel *)p  atPoint:(SGPoint2D *)pt
{
    SGRegion * result;
    result = [SGRegion createWithId:sg_UserInterface_RegionAtPoint(p->pointer, &pt->data)];
    return result;
}

+ (SGRegion *)regionClicked
{
    SGRegion * result;
    result = [SGRegion createWithId:sg_UserInterface_RegionClicked()];
    return result;
}

+ (NSString *)regionClickedID
{
    char result[2048];
    sg_UserInterface_RegionClickedID(result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (int)regionHeight:(SGRegion *)r
{
    int result;
    result = sg_UserInterface_RegionHeight(r->pointer);
    return result;
}

+ (NSString *)regionID:(SGRegion *)r
{
    char result[2048];
    sg_UserInterface_RegionID(r->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (SGRegion *)regionOfLastUpdatedTextBox
{
    SGRegion * result;
    result = [SGRegion createWithId:sg_UserInterface_RegionOfLastUpdatedTextBox()];
    return result;
}

+ (SGPanel *)regionPanel:(SGRegion *)r
{
    SGPanel * result;
    result = [SGPanel createWithId:sg_UserInterface_RegionPanel(r->pointer)];
    return result;
}

+ (int)regionWidth:(SGRegion *)r
{
    int result;
    result = sg_UserInterface_RegionWidth(r->pointer);
    return result;
}

+ (SGRegion *)globalRegionWithID:(NSString *)ID
{
    char ID_temp[[ID length] + 1];
    SGRegion * result;
    [ID getCString:ID_temp maxLength:[ID length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGRegion createWithId:sg_UserInterface_GlobalRegionWithID(ID_temp)];
    return result;
}

+ (SGRegion *)regionOfPanel:(SGPanel *)pnl  withId:(NSString *)ID
{
    char ID_temp[[ID length] + 1];
    SGRegion * result;
    [ID getCString:ID_temp maxLength:[ID length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGRegion createWithId:sg_UserInterface_RegionWithID(pnl->pointer, ID_temp)];
    return result;
}

+ (float)regionX:(SGRegion *)r
{
    float result;
    result = sg_UserInterface_RegionX(r->pointer);
    return result;
}

+ (float)regionY:(SGRegion *)r
{
    float result;
    result = sg_UserInterface_RegionY(r->pointer);
    return result;
}

+ (void)region:(SGRegion *)r  registerEventCallback:(guievent_callback)callback
{
    sg_UserInterface_RegisterEventCallback(r->pointer, callback);
}

+ (void)releaseAllPanels
{
    sg_UserInterface_ReleaseAllPanels();
}

+ (void)releasePanel:(NSString *)name
{
    char name_temp[[name length] + 1];
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ReleasePanel(name_temp);
}

+ (void)selectRadioButton:(SGRegion *)r
{
    sg_UserInterface_SelectRadioButton(r->pointer);
}

+ (void)selectRadioButtonWithID:(NSString *)id
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_SelectRadioButtonWithID(id_temp);
}

+ (void)radioGroup:(SGGUIRadioGroup *)rGroup  selectButton:(SGRegion *)r
{
    sg_UserInterface_SelectRadioButtonFromRadioGroupAndRegion(rGroup->pointer, r->pointer);
}

+ (void)radioButtonOnPanel:(SGPanel *)pnl  withId:(NSString *)id
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_SelectRadioButtonOnPanelWithId(pnl->pointer, id_temp);
}

+ (void)radioGroup:(SGGUIRadioGroup *)rGroup  selectButtonIdx:(int)idx
{
    sg_UserInterface_SelectRadioButtonFromRadioGroupAndIndex(rGroup->pointer, idx);
}

+ (void)region:(SGRegion *)forRegion  setActive:(BOOL)b
{
    sg_UserInterface_SetRegionActive(forRegion->pointer, (b ? 1 : 0));
}

+ (void)showOpenDialog
{
    sg_UserInterface_ShowOpenDialog();
}

+ (void)showOpenDialogWithType:(file_dialog_select_type)select
{
    sg_UserInterface_ShowOpenDialogWithType((int)select);
}

+ (void)showPanel:(SGPanel *)p
{
    sg_UserInterface_ShowPanel(p->pointer);
}

+ (void)showPanelNamed:(NSString *)name
{
    char name_temp[[name length] + 1];
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ShowPanelNamed(name_temp);
}

+ (void)showPanelDialog:(SGPanel *)p
{
    sg_UserInterface_ShowPanelDialog(p->pointer);
}

+ (void)showSaveDialog
{
    sg_UserInterface_ShowSaveDialog();
}

+ (void)showSaveDialogWithType:(file_dialog_select_type)select
{
    sg_UserInterface_ShowSaveDialogWithType((int)select);
}

+ (SGFont *)textBoxFont:(SGGUITextbox *)tb
{
    SGFont * result;
    result = [SGFont createWithId:sg_UserInterface_TextBoxFont(tb->pointer)];
    return result;
}

+ (SGFont *)textBoxFontFromRegion:(SGRegion *)r
{
    SGFont * result;
    result = [SGFont createWithId:sg_UserInterface_TextBoxFontFromRegion(r->pointer)];
    return result;
}

+ (SGGUITextbox *)textBoxFromID:(NSString *)id
{
    char id_temp[[id length] + 1];
    SGGUITextbox * result;
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGGUITextbox createWithId:sg_UserInterface_TextBoxFromID(id_temp)];
    return result;
}

+ (SGGUITextbox *)textboxFromRegion:(SGRegion *)r
{
    SGGUITextbox * result;
    result = [SGGUITextbox createWithId:sg_UserInterface_TextboxFromRegion(r->pointer)];
    return result;
}

+ (NSString *)textBoxText:(SGGUITextbox *)tb
{
    char result[2048];
    sg_UserInterface_TextBoxText(tb->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)textboxTextWithId:(NSString *)id
{
    char id_temp[[id length] + 1];
    char result[2048];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_TextboxTextWithId(id_temp, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)textboxTextFromRegion:(SGRegion *)r
{
    char result[2048];
    sg_UserInterface_TextboxTextFromRegion(r->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (NSString *)textboxTextOnPanel:(SGPanel *)pnl  withId:(NSString *)id
{
    char id_temp[[id length] + 1];
    char result[2048];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_TextboxTextOnPanelWithId(pnl->pointer, id_temp, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

+ (font_alignment)textBoxAlignmentFromRegion:(SGRegion *)r
{
    font_alignment result;
    result = (font_alignment)sg_UserInterface_TextBoxAlignmentFromRegion(r->pointer);
    return result;
}

+ (font_alignment)textboxAlignment:(SGGUITextbox *)tb
{
    font_alignment result;
    result = (font_alignment)sg_UserInterface_TextboxAlignment(tb->pointer);
    return result;
}

+ (void)textboxForRegion:(SGRegion *)r  setAlignment:(font_alignment)align
{
    sg_UserInterface_TextBoxSetAlignmentFromRegion(r->pointer, (int)align);
}

+ (void)textbox:(SGGUITextbox *)tb  setAlignment:(font_alignment)align
{
    sg_UserInterface_TextboxSetAlignment(tb->pointer, (int)align);
}

+ (void)textbox:(SGGUITextbox *)Tb  setFont:(SGFont *)f
{
    sg_UserInterface_TextboxSetFont(Tb->pointer, f->pointer);
}

+ (void)textboxForId:(NSString *)id  setInt:(int)i
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_TextboxSetTextToIntWithId(id_temp, i);
}

+ (void)textboxWithId:(NSString *)id  setFloat:(float)single
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_TextboxSetTextToSingleFromId(id_temp, single);
}

+ (void)textboxForRegion:(SGRegion *)r  setText:(NSString *)s
{
    char s_temp[[s length] + 1];
    [s getCString:s_temp maxLength:[s length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_TextboxSetTextFromRegion(r->pointer, s_temp);
}

+ (void)textbox:(SGGUITextbox *)tb  setText:(NSString *)s
{
    char s_temp[[s length] + 1];
    [s getCString:s_temp maxLength:[s length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_TextboxSetText(tb->pointer, s_temp);
}

+ (void)textboxWithId:(NSString *)id  setText:(NSString *)s
{
    char id_temp[[id length] + 1];
    char s_temp[[s length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    [s getCString:s_temp maxLength:[s length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_TextboxSetTextFromId(id_temp, s_temp);
}

+ (void)textboxForRegion:(SGRegion *)r  setInt:(int)i
{
    sg_UserInterface_TextboxSetTextToIntFromRegion(r->pointer, i);
}

+ (void)textbox:(SGGUITextbox *)tb  setInt:(int)i
{
    sg_UserInterface_TextboxSetTextToInt(tb->pointer, i);
}

+ (void)textbox:(SGGUITextbox *)tb  setFloat:(float)single
{
    sg_UserInterface_TextboxSetTextToSingle(tb->pointer, single);
}

+ (void)textboxForRegion:(SGRegion *)r  setFloat:(float)single
{
    sg_UserInterface_TextboxSetTextToSingleFromRegion(r->pointer, single);
}

+ (void)textboxOnPanel:(SGPanel *)pnl  withId:(NSString *)id  setText:(NSString *)s
{
    char id_temp[[id length] + 1];
    char s_temp[[s length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    [s getCString:s_temp maxLength:[s length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_TextboxSetTextOnPanelAndId(pnl->pointer, id_temp, s_temp);
}

+ (void)textboxOnPanel:(SGPanel *)pnl  withId:(NSString *)id  setInt:(int)i
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_TextboxSetTextToIntOnPanelWithId(pnl->pointer, id_temp, i);
}

+ (void)textboxOnPanel:(SGPanel *)pnl  withId:(NSString *)id  setFloat:(float)single
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_TextboxSetTextToSingleOnPanel(pnl->pointer, id_temp, single);
}

+ (void)toggleActivatePanel:(SGPanel *)p
{
    sg_UserInterface_ToggleActivatePanel(p->pointer);
}

+ (void)toggleCheckboxStateFromID:(NSString *)id
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ToggleCheckboxStateFromID(id_temp);
}

+ (void)toggleCheckboxState:(SGGUICheckbox *)c
{
    sg_UserInterface_ToggleCheckboxState(c->pointer);
}

+ (void)toggleCheckBoxOnPanel:(SGPanel *)pnl  withID:(NSString *)id
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ToggleCheckboxStateOnPanel(pnl->pointer, id_temp);
}

+ (void)toggleRegionActive:(SGRegion *)forRegion
{
    sg_UserInterface_ToggleRegionActive(forRegion->pointer);
}

+ (void)toggleShowPanel:(SGPanel *)p
{
    sg_UserInterface_ToggleShowPanel(p->pointer);
}

+ (void)updateInterface
{
    sg_UserInterface_UpdateInterface();
}









@end
