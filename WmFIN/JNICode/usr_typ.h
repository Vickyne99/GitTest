/*
================================================================================
=                                                                              =
=  MODULE     :  all USR TYP defintion                                         =
=                                                                              =
=  DESCRIPTION:  common generation file for user level  used                   =
=                 by srv_typ and cus_typ                                       =
=                 avoid user application to include cus_typ srv_typ            =
=  FILE       :  USR_TYP.H                                                     =
=                                                                              =
=  AUTHOR     :  PHU                    DATE:    MAY-96                        =
=                                                                              =
=                                                                              =
================================================================================
*/

#ifndef __USR_TYP_H__
#define __USR_TYP_H__


/* definitions of type used by service and needed by user to trace */
/* =============================================================== */

typedef unsigned char  hdr_id_t;                      /* used by srv tr_   */
typedef char module_id_t;                /* used by services tr_ and cq_   */
typedef short ctx_id_t;             /* value -1 could be used for broacast */


/* definitions of base retcod are module dependant application */
/* =========================================================== */

enum 
    {
    MO_NOT_USED,       /*      0     do not used value 0                  */
    MO_TRA_ID,         /*      1     this is tracing  move in usr_typ     */
    MO_LOG_ID,         /*      2     this is for logging   "  "    "      */
    MO_CTL_ID,         /*      3     this is CTL  ID value                */
    MO_SHD_ID,         /*      4     this is SHD  ID value                */
    MO_NET_ID,         /*      5     this is NET  ID value                */
    MO_TIM_ID,         /*      6     this is timer expiration             */
    MO_CMD_ID,         /*      7     this is for user interface command   */
    MO_APL_ID,         /*      8     this is for CUS application part     */
    MO_API_ID,         /*      9     this is for API application          */
    MO_GSE_ID,         /*      10    this is for GSE application          */
    MO_ASN_ID,         /*      11    this is for tracing ASN1 msg         */
    NBR_MO_ID          /* number of module   must   be the last of enum   */
    };


#define MOD_CTX -1              /* when primitive is related to a MODULE */
#define ALL_CTX -2           /* when primitive is not related to all ctx */

#define MOD_OFFSET   1000               /* offset between module retcod */

/* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */ 
/* retcod  base definition for all Module  */ 
/* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */ 

#define TRA_BASE   MO_TRA_ID * MOD_OFFSET   
#define LOG_BASE   MO_LOG_ID * MOD_OFFSET   
#define CTL_BASE   MO_CTL_ID * MOD_OFFSET   
#define SHD_BASE   MO_SHD_ID * MOD_OFFSET   
#define NET_BASE   MO_NET_ID * MOD_OFFSET   
#define TIM_BASE   MO_TIM_ID * MOD_OFFSET   
#define CMD_BASE   MO_CMD_ID * MOD_OFFSET   
#define APL_BASE   MO_APL_ID * MOD_OFFSET   
#define API_BASE   MO_API_ID * MOD_OFFSET   

#define ASN_BASE   (API_BASE +  MOD_OFFSET)   /* asn1 error   */
#define ABO_BASE   (ASN_BASE +  MOD_OFFSET)   /* shd abort reason */
#define GSE_BASE   (ABO_BASE +  MOD_OFFSET)   /* GSE application */

#define NBR_MOD_MAX (NBR_MO_ID + 2)       /* message for ASN and ABO reason */


/* definitions of field size used by services and by user application */
/* ================================================================== */

/* I) shared from cus_typ  for ct_ctx_t  */
/* ------------------------------------- */

#define MAPID_LG       26      /* message partner name max length (SPDU) */
#define TGET_ROUT_LG   20      /* target routing point length (from LPI) */ 
#define MSG_TYP_LG      6      /* message_typ from message block */
#define ADR_FULL_LG    12      /* address full name 12 char bic + lt + branc */ 
#define NICKNAM_LG     31      /* nickname max 31 char */ 
#define BRANCH_LG       3      /* branch code lg = 3 char */ 
#define KEY_LG         32      /* key is 32 char represented (SA2 algo)*/
#define NET_APL_LG      4      /* TPI fld network applic name is FIN or APC */
#define MSG_SYN_LG     15      /* message syntax table is 9505 or 96xx or ...*/

/* II) shared with (SHD_APL) for struct exchange  */
/* ---------------------------------------------- */

#define SENDREF_LG           40     /* max lenght for a sender reference  */
#define TRANSMISS_LG         36     /* transimission   lenght */
#define AUTHEN_LG             8     /* authentification */
#define MAN_ROUT_LG           6     /* manual routing info */
#define DEFERTIME_LG         11     /* cbt defered time info */
#define ACK_TXT_LG          300     /* ack_text lg from transmis report */
#define TXT_256_LG          256     /* text lenght */
#define CASTIME_LG           14     /* from                             */
#define API_TXT_LG           80     /* used in API_STS                  */
#define NET_SRV_LG           50     /* from TPI.NetworkService (CAS2) */
#define NET_VAL_LG           50     /* from TPI.Networkvalidation (CAS2) */
#define NET_REL_LG           32     /* from TPI.networkService.relea (CAS2) */

#define MIR_LG         28        /* message input ref        (from TPI) */
#define USR_PRI_LG      4        /* user priority            (from SRI) */
#define USR_REF_LG     30        /* user reference           (from SRI) */
#define CKSUM_LG       12        /* ckecsum is 12 bytes      (from SRI) */
#define AUTH_LG        40        /* authenfification field   (from SRI) */
#define DELAY_LG       36        /* if message is delayed    (from TPI) */
#define TXT_6_LG        6        /* telex */
#define TXT_2_LG        2        /* telex */
#define TXT_25_LG      25        /* address */
#define TXT_50_LG      50        /*    */
#define TXT_35_LG      35        /* City  */

/* III) shared with (API and SHD_APL)  */
/* ----------------------------------- */


/* the apdu_msg   exchange beteen USR <-> API <-> SHD_APL */

#define API_MSG_DAT 1         /* data   message       */
#define API_MSG_LRP 2         /* lrep   message       */
#define API_MSG_REP 3         /* report message       */
#define API_MSG_STS 4         /* status block         */
#define API_MSG_OPE 5         /* open   block         */
#define API_MSG_CLO 6         /* session close        */
#define API_MSG_ABO 7         /* session abort by CBT   (sts)  */
#define API_MSG_CAB 8         /* session abort by CASmf (sts)  */
#define API_MSG_TIM 9         /* user timer event is delivred by CASmf */
#define API_MSG_NDA 10        /* receive a data with NOMESSAGE APDU CAS2 */
#define API_MSG_NLR 11        /* receive a LRP with NOMESSAGE APDU CAS2 */
#define API_MSG_STP 12        /* receive external request to stop SESSION */
#define API_MSG_ORI 13        /* receive original message after a report */

/* report type in api_rep.rpt_typ  */ 

#define PROCESSI_REP  1         /*  */
#define TRANSMIS_REP  2         /*  */
#define DELIVERY_REP  3         /* idem */


/* logical reply success failure */ 

#define LRP_SUCCESS   1          /*  */
#define LRP_FAILURE   0          /*  */



/* sequence # management in API and SHD */


#define SEQ_NB_MODULO  1000000              /* sequence number modulo .. */ 
#define MOD_SEQ(x) x= (++x) % SEQ_NB_MODULO; if (x == 0) x++; 

/* redefine of asn contant in UPPERCASE for SHD and API */

#define  INPUTFLOW  0      /* 0 message from casmf to CBT */
#define  OUTPUTFLOW 1      /* 1 message from CBT to CASmf */ 
#define  BOTHFLOW   2      /* 2 send/receive  data */ 

#endif 
