/*
================================================================================
=                                                                              =
=  MODULE     :  SERVICE MESSAGE definition                                    =
=                                                                              =
=  DESCRIPTION:   general global define for module string                      =
=                                                                              =
=  FILE       :  SRVMGAPI.H                                                    =
=                                                                              =
=  AUTHOR     :    PHU              MAR 95                                     =
=                                                                              =
=  UPDATES   :     HUYBENS PIERRE MAY 95 put all string in service mg          =
=                  30 Apr 2002 AL for the purist!                              =
=                                                                              =
=                                                                              =
================================================================================
*/

/* string identification # are offset from a specific base offset for */
/* each Module or Function the base OFFSET is define in cus_typ.h     */
/* each module or function is idetified by 3 letters                  */
/* see srvmg services                                                 */

/*  message string identification API  for logging and message */
/* =--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

enum
       {
       CUSAPI_SUCCESS = API_BASE,        /* success of the request */
       CUSAPI_PROGRESS,                  /* request will be manage by CASmf */

       CUSAPI_MAPID_NOT,                 /* mapid does not exist */
       CUSAPI_NOT_INIT ,                 /* session initied */
       CUSAPI_NOT_OPEN ,                 /* session not open   */
       CUSAPI_INV_LVL ,                  /* invalid api level routines */
       CUSAPI_ERROR,                     /* fatal software error */
       CUSAPI_INIT_TWO,                  /* already init */
       CUSAPI_MAPID_BUZY,                /* mapid used by another session */
       CUSAPI_SESS_FAIL,                 /* session opening failure */
       CUSAPI_UNEX_LREP,                 /* unexpected lrep */
       CUSAPI_WRONG_HANDLER,             /* wrong ctx_id  number */
       CUSAPI_TIMEOUT,                   /* timout on event */ 
       CUSAPI_APDU_ERR,                  /* APDU wrong value */ 
       CUSAPI_SUBFMT_ERR,                /* msg subformat error */ 
       CUSAPI_FORMAT_ERR,                /* msg format error */ 
       CUSAPI_NOCASMF,      /* CASmf not running  */ 
       CUSAPI_WRNG_LREP,    /* wrong LREP # expected %d # received %d */
       CUSAPI_WRNG_FLOW,    /* flow does not allow to send data */
       CUSAPI_ALLOCATED,   /* try to stop while mapid(s) are still allocated */
       CUSAPI_WRNG_PARAM,    /* wrong parameter(s) */

                          /* internal status only or event logging */

       CUSAPI_UNEXP_EVT,                 /* unexpected event %d in state %d */ 
       CUSAPI_NO_REC_FIL, /* recovery file not found for %s */
       CUSAPI_REC_FILERR, /* recovery file error %s for mapid %s */
       CUSAPI_REC_CASMF,  /* recovery with casmf info for %s sess %d seq %d */
       CUSAPI_REC_USER,   /* recovery with user info for %s is sess %d seq %d */
       CUSAPI_NORMAL_SES, /* not recovery mode for mapid %s */
       CUSAPI_CALLOC,     /* error when alloc memory */
       CUSAPI_BUFREF,       /* buffer pool reference (internal error) */ 
       CUSAPI_RESOURCE,   /* user application stop before fee CUS resource */
       CUSAPI_CONTINUE,                /* read queue again */ 
       CUSAPI_NBR_MSG
       };
            
/* for the purist */

/* #define CUSAPI_SUCCESS CUSAPI_SUCCES  */

void mg_msg_api(); 

