#include "WmSWIFTNetClientJNI.h"
#include "swcall.h"
#include "SwServer.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


/*
 * Class:     WmIAFAClientJNI
 * Method:    WmSwArguments
 * Signature: (I[Ljava/lang/String;)I
 */
JNIEXPORT jint JNICALL Java_com_wm_swiftnet_client_WmSWIFTNetClientJNI_WmSwArguments
(JNIEnv * env, jclass cls, jint argc, jobjectArray jargv) {

	jint result;	
	jint i;
	jboolean isCopy;
	jstring jstr;
	int size=0;
	int argcc;

	const char* cstr;
	char **argv;

	argcc = argc;
	
	
	argv = (char**) malloc(sizeof(char*) * argc );	

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
	result = SwArguments( argcc, (const char**) argv );

	// Release allocated memory.
	for ( i=0; i<argc; i++ ) {
		free( argv[i] );
	}

	if(argv != NULL)
		free(argv);

	// Return to Java.

	return result;



}

/*
 * Class:     WmIAFAClientJNI
 * Method:    WmSwCall
 * Signature: (Ljava/lang/String;Ljava/lang/StringBuffer;)I
 */
JNIEXPORT jint JNICALL Java_com_wm_swiftnet_client_WmSWIFTNetClientJNI_WmSwCall
(JNIEnv *env, jclass jcls, jstring jstr, jobject jStringBuffer) {

	const char* request;
	char *response = 0;
	jboolean isCopy;
	jint result;
	jmethodID sbAppendMID;
	jstring _jstring;

	request = (const char*)((*env)->GetStringUTFChars( env, jstr, &isCopy ));

	// Invoke SwCall() to send request to SNL
	result = SwCall((SwCallRequest) request, (SwCallResponse*) &response);

	if ( isCopy == JNI_TRUE ) { 

			(*env)->ReleaseStringUTFChars( env, jstr, request );

	}

	// Clear local reference.
	(*env)->DeleteLocalRef(env,jstr);

	jcls = (*env)->GetObjectClass(env,jStringBuffer);

	//jmethodID sbAppendMID;
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
	
	return result;
}

