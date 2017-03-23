#include "WmSWIFTNetServerJNI.h"
#include "swcall.h"
#include "SwServer.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TRUE	1
#define FALSE	0
#define FILE_STATUS_EVENT_EP "File_Status_Event_EP"

// Global variables
jclass		clsPtr;
jmethodID	handleRequestMID;
jmethodID	createContextRequestMID;
jmethodID	subscribeFileEventRequestMID;
jmethodID	handleInitResponseMID;
jmethodID	debugLogMID;

JNIEnv		*jenv;
int			argc = 0;
char		**argv = 0;
static char g_authDN[100] = "";

/*
 * Class:     WmIAFAServerJNI
 * Method:    WmSwArguments
 * Signature: (I[Ljava/lang/String;)I
 */
JNIEXPORT jint JNICALL Java_com_wm_swiftnet_server_WmSWIFTNetServerJNI_WmSwArguments
(JNIEnv * env, jclass cls, jint jargc, jobjectArray jargv) {

	jint result;	
	jint i;
	jboolean isCopy;
	jstring jstr;
	int size=0;
	
	const char* cstr;

	argc = jargc;

	
	argv = (char**) malloc(sizeof(char*) * argc);

	for ( i = 0; i<argc; i++ ) {

		jstr = (jstring)(*env)->GetObjectArrayElement(env,jargv,i); 

		cstr = (const char*)((*env)->GetStringUTFChars( env, jstr, &isCopy ));



		size = strlen(cstr)+1;
		argv[i] = (char*)malloc( size ); 

		memset(argv[i], '\0', size);

		strcpy( argv[i], (const char*)cstr );


		if ( isCopy == JNI_TRUE ) { 
			(*env)->ReleaseStringUTFChars( env, jstr, cstr );
		}

		// Clear local reference.
		(*env)->DeleteLocalRef(env,jstr);

	}

	// Call our SwArguments() now. 
	result = SwArguments( (int)argc, (const char**) argv );

	
	// Return to Java.

	return result;



}

/*
 * Class:     WmIAFAServerJNI
 * Method:    WmSwCall
 * Signature: (Ljava/lang/String;Ljava/lang/StringBuffer;)I
 */
JNIEXPORT jint JNICALL Java_com_wm_swiftnet_server_WmSWIFTNetServerJNI_WmSwCall
(JNIEnv *env, jclass jcls, jstring jstr, jobject jStringBuffer) {

	const char* request;
	char *response = 0;
	jboolean isCopy;
	jint result;
	jmethodID sbAppendMID;
	jstring _jstring;

	request = (const char*)((*env)->GetStringUTFChars( env, jstr, &isCopy ));

	result = SwCall((SwCallRequest) request, (SwCallResponse*) &response);

	if ( isCopy == JNI_TRUE ) { 

			(*env)->ReleaseStringUTFChars( env, jstr, request );

	}

	jcls = (*env)->GetObjectClass(env,jStringBuffer);

	//jmethodID handleRequestMID;
	sbAppendMID = (*env)->GetMethodID (env, jcls,
		                                     "append","(Ljava/lang/String;)Ljava/lang/StringBuffer;");

    if(sbAppendMID == NULL)
		return result;

	_jstring = (*env)->NewStringUTF (env, (const char *) response);

	// Call the StringBuffer object's append method passing the handle to 
	// the new Java String object.

	(*env)->CallObjectMethod (env, jStringBuffer, sbAppendMID, _jstring);

	if(response != 0)
		SwXmlBufferFree(response);

	// Clear local reference.
	(*env)->DeleteLocalRef(env,_jstring);
	
	return result;
}

/* -----------------------------------------------------------------------------------*/
/* This function is invoked by SNL when it receives a request for this application    */
/* -----------------------------------------------------------------------------------*/
int SwCallback(SwCallRequest request, SwCallResponse* response)
{

	jstring jRequest;
	jstring jResponse;
	jstring jUserDN;
	jboolean isCopy;
	const char *resp;

	static int first_time = TRUE;


	// Exchange initialization primitives on startup
	if(first_time) {
		
		initializationPrimitivesExchange();

		// create jstring object to pass as an argument to WmIAFAServerJNI.getHandleInitResponse()
		jUserDN = (*jenv)->NewStringUTF( jenv, (const char *) g_authDN ); 

		//invoke WmIAFAServerJNI.handleRequest() static method
		jResponse = (jstring) (*jenv)->CallStaticObjectMethod(jenv,clsPtr,handleInitResponseMID,jUserDN);
		resp = (char*)((*jenv)->GetStringUTFChars( jenv, jResponse, &isCopy ));	
		

		*response = (char *) malloc(sizeof(char) * (strlen((char*) resp) + 1));
		memset(*response,'\0',sizeof(char) * (strlen((char*) resp) + 1));
		strcpy(*response,(const char*) resp);
		if ( isCopy == JNI_TRUE ) { 

			(*jenv)->ReleaseStringUTFChars( jenv, jResponse,resp );

		}

		// Clear local references.
		(*jenv)->DeleteLocalRef(jenv,jUserDN);

		first_time = FALSE;
		
		return 0;

	}

	// WmIAFAServerJNI.handleRequest() method not found... highly unlikely!
	if(handleRequestMID == NULL)
		return 1;

	
	// create jstring object to pass as an argument to WmIAFAServerJNI.handleRequest()
	jRequest = (*jenv)->NewStringUTF( jenv, (const char *) request ); 

	//invoke WmIAFAServerJNI.handleRequest() static method
	//printf("In JNI Code(): About to call handleRequest in server\n");
	//printf("In JNI Code(): Second print statement About to call handleRequest in server\n");

	
	jResponse = (jstring) (*jenv)->CallStaticObjectMethod(jenv,clsPtr,handleRequestMID,jRequest);
	/*
	if(jResponse != NULL)
	    printf("In JNI Code(): After calling handleRequest method in server; jResponse != NULL\n");
	else
		printf("In JNI Code(): After calling handleRequest method in server; jResponse == NULL\n");
	*/
	resp = (*jenv)->GetStringUTFChars( jenv, jResponse, 0);	
	//printf("In JNI Code(): Response received = %s\n",resp);

	*response = (char *) malloc(strlen(resp) + 1);
	memset(*response,'\0',strlen(resp) + 1);
	strcpy(*response,(const char*) resp);

	//printf("In JNI Code():  copied resp to response\n");
	
	(*jenv)->ReleaseStringUTFChars( jenv, jResponse,resp );
	

	// Clear local references.
	(*jenv)->DeleteLocalRef(jenv,jRequest);
	(*jenv)->DeleteLocalRef(jenv,jResponse);

	//printf("In JNI Code(): returning 0\n");
	return 0;

}

/*
Callback function to free the memory allocated for callback response inside the
SwCallback() function.
*/
void AppXmlBufferFree(void* buf)
{
	free( buf );
}

JNIEXPORT jint JNICALL Java_com_wm_swiftnet_server_WmSWIFTNetServerJNI_WmSwRegisterCallBack
(JNIEnv *env, jclass cls) {
	
	jint rcode;
	int i;

	
	initializeJVMVariables(env, cls);

	SwRegisterSwCallback(SwCallback);
	SwRegisterSwAppXmlBufferFree(AppXmlBufferFree);

	rcode = SwServer(argc,argv);

	// Release allocated memory.
	for ( i=0; i<argc; i++ ) {
		free( argv[i] );
		argv[i] = 0;
	}

	if(argv != NULL)
		free(argv);
	
	return rcode;
}

/* -----------------------------------------------------------------------------------*/
/* Initializes JVM variables i.e. pointers to the JVM and static java methods												  */
/* -----------------------------------------------------------------------------------*/
void initializeJVMVariables(JNIEnv *env, jclass cls) {

	//Global variables initialization

	clsPtr = cls; // store reference to WmIAFAServerJNI class. this will be used
				  // in SwCallBack function

	// Get a handle to WmIAFAServerJNI.handleRequest() static method
	handleRequestMID = (*env)->GetStaticMethodID(env, cls, "handleRequest", 
							"(Ljava/lang/String;)Ljava/lang/String;");

	// Get a handle to WmIAFAServerJNI.getCreateContextRequest() static method
	createContextRequestMID = (*env)->GetStaticMethodID(env, cls, "getCreateContextRequest", 
							"()Ljava/lang/String;");

	// Get a handle to WmIAFAServerJNI.getSubscribeFileEventRequest() static method
	subscribeFileEventRequestMID = (*env)->GetStaticMethodID(env, cls, "getSubscribeFileEventRequest", 
							"()Ljava/lang/String;");

	// Get a handle to WmIAFAServerJNI.getHandleInitResponse() static method
	handleInitResponseMID = (*env)->GetStaticMethodID(env, cls, "getHandleInitResponse", 
							"(Ljava/lang/String;)Ljava/lang/String;");

	// Get a handle to WmIAFAServerJNI.debugLog() static method
	debugLogMID = (*env)->GetStaticMethodID(env, cls, "debugLog", 
							"(Ljava/lang/String;Ljava/lang/String;)I");

	// Store handle to the Java VM
	jenv = env;

}

/* -----------------------------------------------------------------------------------*/
/* Initialization primitives												  */
/* -----------------------------------------------------------------------------------*/
void initializationPrimitivesExchange() {


	jstring jRequest;
	char *request = 0;
	char *p_response = 0;
	jboolean isCopy;
	jstring jFunction;
	jstring jErrorMessage;	
	jint blah;


	//invoke WmIAFAServerJNI.getCreateContextRequest() static method
	jRequest = (jstring) (*jenv)->CallStaticObjectMethod(jenv,clsPtr,createContextRequestMID);

	request = (char*)((*jenv)->GetStringUTFChars( jenv, jRequest, &isCopy ));

	//printf("In initializationPrimitivesExchange(): createContextRequest = \n%s\n",request);

    if(SwCall((const char*) request, (char **) &p_response) == SwOperationFailed) {
		jFunction = (*jenv)->NewStringUTF( jenv, (const char *) "CreateContextRequest Error"); 
		jErrorMessage = (*jenv)->NewStringUTF (jenv, (const char *) p_response);
		if(debugLogMID == NULL)
			;
		else
		blah = (jint) (*jenv)->CallStaticObjectMethod(jenv,clsPtr,debugLogMID,jFunction,jErrorMessage);
		// Clear local references.
		(*jenv)->DeleteLocalRef(jenv,jFunction);
		(*jenv)->DeleteLocalRef(jenv,jErrorMessage);
	}


	if ( isCopy == JNI_TRUE ) { 
		(*jenv)->ReleaseStringUTFChars( jenv, jRequest,request );
	}

	
	/* get authorisation context from CreateContextResponse */
	strcpy (g_authDN, extract_tag (p_response, "SwSec:UserDN", 1));


	if (p_response != 0)
	{
		SwXmlBufferFree (p_response);
		p_response = 0;
	}

	// Clear local references.
	(*jenv)->DeleteLocalRef(jenv,jRequest);

	//invoke WmIAFAServerJNI.getSubscribeFileEventRequest() static method
	jRequest = (jstring) (*jenv)->CallStaticObjectMethod(jenv,clsPtr,subscribeFileEventRequestMID);

	request = (char*)((*jenv)->GetStringUTFChars( jenv, jRequest, &isCopy ));
		//printf("In initializationPrimitivesExchange(): getSubscribeFileEventRequest = \n%s\n",request);


    if(SwCall((const char*) request, (char **) &p_response) == SwOperationFailed) {
		jFunction = (*jenv)->NewStringUTF( jenv, (const char *) "SubscribeFileEventRequest Error"); 
		jErrorMessage = (*jenv)->NewStringUTF (jenv, (const char *) p_response);
		blah = (jint) (*jenv)->CallStaticObjectMethod(jenv,clsPtr,debugLogMID,jFunction,jErrorMessage);

		// Clear local references.
		(*jenv)->DeleteLocalRef(jenv,jFunction);
		(*jenv)->DeleteLocalRef(jenv,jErrorMessage);
	}



	if ( isCopy == JNI_TRUE ) { 
		(*jenv)->ReleaseStringUTFChars( jenv, jRequest,request );
	}

	if (p_response != 0)
	{
		SwXmlBufferFree (p_response);
		p_response = 0;
	}

	// Clear local references.
	(*jenv)->DeleteLocalRef(jenv,jRequest);

}

/* -----------------------------------------------------------------------------------*/
/* Returns the value of an XML tag													  */
/* -----------------------------------------------------------------------------------*/

char *extract_tag (char *a_xml_string, char *a_tag_name, int a_occurence)
{
	char *p_tag;
	char *start_address;
	char *end_address;
	static char tag_value [MAX_BUFF];
	char complete_end_tag [MAX_BUFF];
	char start_tag [MAX_BUFF];
	int  occurence;

	memset (&tag_value, '\0', MAX_BUFF);
	occurence = 1;
	start_address = a_xml_string;
	sprintf (start_tag, "<%s", a_tag_name);

	while (1)
	{
		p_tag = (char*) strstr (start_address, start_tag);
		
		if (p_tag == NULL)
		{
			return ("");
		}
		p_tag = p_tag + strlen (a_tag_name);
		if ( *(p_tag+1) == '/')
		{
			if (a_occurence == occurence)
			{	
				/* empty element */
				return ("");
			}
			start_address = p_tag;
			occurence++;
		}

		if ( *(p_tag+1) == ' ')		/*	we can have attributes */
		{
			while ( *(p_tag+1) != '>')
				p_tag++;
		}

		if ( *(p_tag+1) == '>')
		{
			p_tag = p_tag + 2; /* point to first character of value */
			
			strcpy (complete_end_tag, "</");
			strcat (complete_end_tag, a_tag_name);
			strcat (complete_end_tag, ">");
			end_address = (char*) strstr (start_address, complete_end_tag);

			if (end_address == NULL)
			{
				return ("");
			}

			if (a_occurence == occurence)
			{
				strncpy ( tag_value, p_tag, end_address - p_tag);
				return (tag_value);
			}
			start_address = end_address + strlen (complete_end_tag);
			occurence++;
		}
		else
		{
			start_address = p_tag;
		}
	}
}


