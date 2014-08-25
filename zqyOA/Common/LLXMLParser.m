#import "LLXMLParser.h"

@implementation LLXMLParser

+(NSArray*)subElements:(NSString*)aSubElementName parentElement:(GDataXMLElement*)aParentElement{
	NSArray* array=[aParentElement elementsForName:aSubElementName];
	return array;
}
+(GDataXMLElement*)pathSubElement:(NSString*)aSubElementPath parentElement:(GDataXMLElement*)aParentElement{
	//**** 参数为aSubElementPath :"root//element1" ****
	//**** 取出path的数组 ****
	NSArray *aPathArray = [aSubElementPath componentsSeparatedByString:@"//"];
	GDataXMLElement *aElement = aParentElement;
	NSString *aElementName = @"";
	
	for (int i=0; i<[aPathArray count]; i++) {
		aElementName = [aPathArray objectAtIndex:i];
		NSArray *documentElements = [LLXMLParser subElements:aElementName parentElement:aElement];
		//**** 都取第一个subElements ****
		aElement = [documentElements objectAtIndex:0];
	}
	
	return aElement;
}
+(NSString*)getStringValue:(NSString*)aSubElementName parentElement:(GDataXMLElement*)aParentElement{
	NSString* strValue=nil;
	
	GDataXMLElement* subElement=nil;
	NSArray* array=[LLXMLParser subElements:aSubElementName parentElement:aParentElement];
	if (array && [array count]>0){
		subElement=[array objectAtIndex:0];
	}
	
	if(subElement){
		strValue=[subElement stringValue];
	}
	
	return strValue;
}



@end
