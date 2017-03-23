/*
================================================================================
=                                                                              =
=  MODULE     :  CUSAPI2              SERVICE API  for CAS USER SYSTEM         =
=                                                                              =
=  DESCRIPTION:  definition of struct for api_lvl 2 API_V20                    =
=                                                                              =
=  FILE       :  CUSAPI2                                                       =
=                                                                              =
=  AUTHOR     :  P. HUYBENS    MAR 1996                                        =
=                                                                              =
=  UPDATES    : 27 Feb 2001 A. Lockwood                                        =
=                 casmf_stop was defined correctly for ISO C standard so       =
=                 redefined as short casmf_stop (void)                         =
=                                                                              =
=                                                                              =
================================================================================
*/

#ifndef __CUSAPI2_H__
#define __CUSAPI2_H__

#include <time.h>           /* used by status struct  cas_sts_t */


/* max size definition cas gen struct is used to exchange info between  */
/* user process and api. run time error will occur if the size MAX_API_SIZ */
/* is less than needed */

#define CAS_API_SIZ 820 

/* define for CASmf the user constants */
/* ----------------------------------- */

/* definition of the CASmf API version */


#define API_MIN 1    /* version 1 user control data and sender_ref */
#define API_V20 2    /* version 2 NIF and status are implemented   */
                     /*    with  multi-session in one user process */

#define API_GSE 3    /* version 2 for GSE only */

/* who opens the cas session, used in ****_open  API field: open_typ */

#define API_OUTOPEN  1     /* request CASmf to open session with CBT */
#define API_INOPEN   2     /* wait for the CBT to open the session */


/* flow definition */
/* =============== */

#define FLOW_TO_CBT     0                            /* send data to CBT */
#define FLOW_FROM_CBT   1                       /* receive data from CBT */
#define FLOW_BOTH       2                            /* gues the meaning */

#define API_NO_VALUE  -1    /* field value when request to default value */

/* CASmf AUTHENTICATION  definition */
/* ================================ */

enum 
{
AUTH_NONE,               /* no authentication */
AUTH_ACCESS,             /* access authentication at SHD OPRQ OPCF */
AUTH_DATA,               /* data authentication */
AUTH_BOTH,               /* DATA and ACCESS authentication */
NBR_AUTH_TYP 
};

/* CASmf AUTHENTICATION  result */
/* ============================ */

enum 
{
AUTH_NO_VALUE,               /* no meaning when LREP or OPEN or CLOSE .. */ 
AUTH_NODEF_NORCV,           /* authentication not defined & not received */
AUTH_DEF_NORCV,               /* authentication defined but not received */
AUTH_NODEF_RCV,               /* authentication not defined but received */
AUTH_SUCCESS,                     /* authentication success with message */
AUTH_ERROR,                       /* authentication failure when receive */
NBR_AUTH_RESULT 
};


/* queue id can have the following value and message will be put in queue */
/* ====================================================================== */

#define CBT_QUE_NONE      0                    /* CBT will choose the queue */
#define CBT_QUE_CANCEL    1               /* message is put in cancel queue */
#define CBT_QUE_FIX       2                  /* message is put in fix queue */
#define CBT_QUE_VERIFY    3               /* message is put in verify queue */
#define CBT_QUE_AUTHORI   6            /* message is put in authorize queue */
#define CBT_QUE_READY     9                /* message is put in ready queue */


/* routing type for a message is a optional field with allowed value */
/* ================================================================= */


#define CBT_ROUT_INTERNAL  0                /* routing by CBT routing rule */
#define CBT_ROUT_CIF       1      /* routing by Correpondant informat file */
#define CBT_ROUT_APPL      2                    /* routing to application  */
#define CBT_ROUT_POINT     3           /* routing by provide routing point */



/* duplicated value result (cbt_dup_result) field */
/* ============================================== */

#define DUP_UNIQUE           0
#define DUP_UNIQUE_FORMAT    1
#define DUP_POSSIBLE         2
#define DUP_REAL             3
#define DUP_NO_CHECK         4   


/* duplicated action (cbt_dup_action) field */
/* ======================================== */

#define DUP_REJECT_ALL       1
#define DUP_REJECT_REAL      2
#define DUP_REJECT_NO        3


/* delivery status for transmission report */
/* ======================================= */

#define NETWORK_WAIT_ACK  0
#define NETWORK_TIMEOUT   1
#define NETWORK_ACKED     2
#define NETWORK_NACKED    3
#define NETWORK_ABORTED   5
#define NETWORK_REJECTED  4


/* delivery status for delivery report */
/* =================================== */

#define RCV_UNKNOWN       0   
#define RCV_OVERDUE       1
#define RCV_DELIVERED     2
#define RCV_ABORTED       3
#define RCV_DELAYED_NAK   4
#define RCV_ACKED         5
#define RCV_NACKED        6
#define RCV_TRUNCATED     7

/* delivery status for processing report */
/* ===================================== */

#define LOCAL_CANCELLED 0
#define LOCAL_REJECTED  4

/* intervention categories (in inter_cat_txt and inter_cat_msg) */
/* =========================================================== */

#define CATG_TRANS_REPORT   0
#define CATG_DELIV_REPORT   1
#define CATG_SECURITY       2
#define CATG_MSG_AS_TRANS   3
#define CATG_MSG_AS_RECEI   4
#define CATG_MSG_MODIFIED   5
#define CATG_MSG_SCISSORED  6
#define CATG_ROUTING        7
#define CATG_OTHER          8


/* origine message field value in api_rep.ori_msg */
/* ============================================== */

#define ORIG_MSG_NO_INFO    0
#define ORIG_MSG_MINIMUM    1
#define ORIG_MSG_CONDENSED  2
#define ORIG_MSG_FULL       3
#define ORIG_MSG_EXPENDED   4


/* message subformat can take the following values */
/* =============================================== */

#define API_INPUT_MSG   1  
#define API_OUTPUT_MSG  2   


/* message format can take the following values */
/* ============================================ */

#define API_SWIFT_MSG      1        /* swift nif */
#define API_TELEX_MSG      2        /* Telex nif */
#define API_FAX_MSG        3        /* fax       */
#define API_CREST_MSG      8        /* restricted area          */
#define API_SWIFTNDF_MSG   31       /* swift ndf */
#define API_TELEXNDF_MSG   32       /* not supported officially */
#define API_OTHER_MSG     100       /* Other message (internal format) */


/* mac/pac result value  (from cbt_auhentication) */ 
/* ============================================== */

#define CBT_SUCCESS_CURRENT   0
#define CBT_SUCCESS_FUTURE    1
#define CBT_SUCCESS_OLD       2
#define CBT_BYPASSED         10
#define CBT_NOKEY            11
#define CBT_FAILED           20     


/* define some of the cbt applications */
/* =================================== */

#define CBTAPL_APLINTERF   0
#define CBTAPL_SWIFT       1
#define CBTAPL_TELEX       2
#define CBTAPL_FAX         3
#define CBTAPL_CHIPS       4
#define CBTAPL_CREST       8
#define CBTAPL_OTHER     100

/* each info exchange between apllication and casmf start with api_hdr_t */

typedef struct api_hdr_str
    {
    int api_typ;                        /*  API_MIN, API_v20       */ 
    ctx_id_t ctx_id;                    /*  extension multi-row    */
    int apdu_msg;                       /*  DATA / LREP ....       */ 
    int session_nb;                     /*  cas_session #          */
    int seq_nb;                         /*  cas_sequence #         */
    char sender_ref[SENDREF_LG+1];      /*  cas sender_reference   */          
    int duplicate;                      /*  cas duplicated msg     */
    int auth_result;                    /*  local authentif result */
    int api_reserved;                   /*  reserve for api        */
    } api_hdr_t ;

#define API_HDR_TLG sizeof(api_hdr_t)

/* if apdu_msg is API_MSG_LRP  api_lvl_t is follwed by lrp struct */

typedef struct api_lrp_str
    {
    int success;                                           /* for LREP only */
    int actual_dispo;                           /* for LREP only  cas->user */ 
    int reject_reason;                          /* for LREP only  cas->user */ 
    char reject_text[TXT_256_LG+1];             /* for LREP only  cas->user */ 
    }  api_lrp_t;

#define API_LRP_TLG sizeof(api_lrp_t)


typedef struct api_ope_str 
    {
    char mapid[MAPID_LG+1] ;                     /* mapid name null string */
    int  window;                              /* if -1 used default window */
    int flow;                             /* flow 0 input 1 output 2 both */
    int  dup_msg;                                /* # of recovery message */
    int  key_val;
    char acc_rcv_key[KEY_LG+1];
    char acc_snd_key[KEY_LG+1];
    char loc_rcv_key[KEY_LG+1];
    char loc_snd_key[KEY_LG+1];
    } api_ope_t;

#define API_OPE_TLG sizeof(api_ope_t)


/* if apdu_msg is API_MSG_DAT  api_lvl_t is follwed by data(s) struct */

typedef struct api_dat_str
    {
    int dat_format;            /* swiftNDF = 31 , swifNIF = 1 Crest = 8 ... */ 
    int dat_subformat;                           /* input = 1 , output = 2  */ 
    int dat_lg ;                                  /* lenght of data message */
    int dat_reserved;                             /* map of optional struct */
    } api_dat_t ;

#define API_DAT_TLG sizeof(api_dat_t)

/* if apdu_msg is API_MSG_REP  api_lvl_t is follwed by report struct */

typedef struct api_rep_str
    {
    int rpt_type;                           /* from processing report type */
    int modified;                                       /* from report LPI */
    int ori_msg;                                   /* original msg receive */
    int ori_cbtappl;                                /* from message origin */
    char ori_sender_ref[SENDREF_LG+1];                  /* from report LPI */
    char ori_sender[MAPID_LG+1];                    /* from message origin */
    char ori_receiv[MAPID_LG+1];                    /* from message origin */
    int ori_session_nb;                             /* from message origin */
    int ori_seq_nb;                                 /* from message origin */
    int cbt_dup_result;                                  /* from reportLPI */ 
    } api_rep_t ;

#define API_REP_TLG sizeof(api_rep_t)


typedef struct rep_dlv_str
    {
    int network;
    int dlv_status;                  /* delivery status (netwk or receiv) */
    int net_session_nb;                           /* from delivery report */
    int net_seq_nb;                               /* from delivery report */
    int duplic_trans;                             /* from delivery report */
    int nb_interv;                              /* nb of interv txt 0/1/2 */
    int inter_cat_txt;                    /* intervention type in rep_txt */ 
    int inter_cat_msg;                   /* intervention type in msg area */ 
    char rep_text[ACK_TXT_LG+1];             /* from delivery report text */  
    }  rep_dlv_t ;

/* if apdu_msg is API_MSG_STS  api_lvl_t is follwed by status struct */


typedef struct api_sts_str 
    {
    int msg_waiting; 
    int api_sts;                                         /* to be defined */
    char api_text[API_TXT_LG + 1];                      /* text of status */
    int window;                                         /* current window */
    int flow;                 /*      not int because 0 is used */
    int session_state; 
    time_t net_time;
    int    net_sts;  
    int    net_errno;
    time_t shd_time;
    int    shd_sts; 
    int    shd_abort_reason; 
    int    shd_abort_nb;
    time_t apl_time;
    int    apl_sts;  
    } api_sts_t ;

#define API_STS_TLG sizeof(api_sts_t)


/*  info for CBT to define how route the message destination */

typedef struct cbt_des_str
    {
    int  cbt_appl;                               /*  see define CBT_APP_.... */
    int  cbt_queue_id;                          /*   see define CBT_QUE_.... */
    int  cbt_rout_typ;                         /*   see define CBT_ROUT_.... */
    char cbt_rout_point[TGET_ROUT_LG +1];  /* when routyp ==  CBT_ROUT_POINT */
    int  cbt_modif;                                        /* modify allowed */
    int  cbt_security;                                       /* security y/n */
    int  cbt_validation;                               /* minimun validation */
    int  cbt_priority;                                       /* cbt priority */
    int  cbt_dup_action;                                /* duplicated action */
    char cbt_msg_syntax[MSG_SYN_LG +1];               /* message syntax tbl  */
    char cbt_tlx_nb[TXT_25_LG+1] ;                           /* telex number */
    char cbt_tlx_anb[TXT_25_LG+1] ;                     /* telex answer back */
    char cbt_tlx_ctp[TXT_6_LG+1] ;                     /* telex carrier type */
    } cbt_des_t; 

#define CBT_DES_TLG sizeof(cbt_des_t)


/* info from  CBT to give user information about source of the message */

typedef struct cbt_rcv_str
    {                                        
    int  cbt_appl;                           /*  see define CBT_APP_.... */
    char cbt_sender[MAPID_LG+1];                                      /* */
    char cbt_receiv[MAPID_LG+1];                                      /* */
    int  cbt_session_nb;                               /* message origin */
    int  cbt_seq_nb;                              /* from message origin */
    int  mac_result;                                       /* mac result */
    int  chk_result;                                  /* checksum result */
    int  pac_result;                                       /* pac result */
    int  cbt_dup_result;                                  /*             */
    int  net_retrieved;                                   /*             */
    } cbt_rcv_t ; 

#define CBT_RCV_TLG sizeof(cbt_rcv_t)


typedef struct msg_lvl_str
    {
    char sender[ADR_FULL_LG+1];                       /* SENDER     BIC 11 */
    char sender_lt;                                      /* char sender LT */
    char receiv[ADR_FULL_LG+1];                      /* RECEIVER    BIC 11 */
    char receiv_lt;                                     /* char receiv LT  */
    char nickname[NICKNAM_LG+1];                        /* RECEIVER nicknam*/
    char msg_typ[MSG_TYP_LG+1];                        /*  message Type MT */ 
    int  msg_nature;                           /* FINANCIAL(1) TEXT (2) .. */
    int  original_msg;                         /* original (X) or copy (0) */
    int  live_msg;                     /* real message (X) or training (0) */
    char institution[TXT_50_LG+1];              /* financial institution */  
    char branchinfo[TXT_50_LG+1];              /* branch */  
    char city[TXT_35_LG+1];                     /* city */  
    char location[TXT_50_LG+1];                 /* location */ 
    char country[TXT_2_LG+1];                   /* country code */  
    } msg_lvl_t;

#define MSG_LVL_TLG sizeof(msg_lvl_t)

/* destination  of next information is network level  */

typedef struct net_des_str
    {
    char net_appl[NET_APL_LG +1];             /*   FIN or APC  */
    int network;
    int net_priority;                          /*   see define NET_PR.... */
    int net_delivery;                         /* request delivery notif   */
    int net_nondelivery;                    /* request non delivery notif */
    int net_obsolesc;                   /* obsolescence periode in minute */
    char net_service_id[NET_SRV_LG + 1];            /* network service id */
    char net_validation[NET_VAL_LG + 1];           /* network validation  */
    } net_des_t; 

#define NET_DES_TLG sizeof(net_des_t)

typedef struct net_rcv_str
    {
    char net_appl[NET_APL_LG +1];                         /*   FIN or APC  */
    int network;                                  /*   see define NET_.... */
    int net_priority;                           /*   see define NET_PR.... */
    int net_session_nb;                                /*    net session # */
    int net_seq_nb;                                    /*    net sequen  # */
    int net_duplicate;                  /* PDM or transmission PDE trailer */
    char net_inputtime[CASTIME_LG + 1];
    char net_outputtime[CASTIME_LG + 1];
    char net_mir[MIR_LG + 1];                   /* request delivery notif  */
    char net_delayed[DELAY_LG +1];            /* if message is late  {DLM} */
    char pac_value[AUTH_LG +1];                       /* pac value (MT096) */
    char net_service_id[NET_SRV_LG + 1];             /* network service id */
    char net_validation[NET_VAL_LG + 1];            /* network validation  */
    char net_release_info[NET_REL_LG + 1];         /* network release info */

    } net_rcv_t; 

#define NET_RCV_TLG sizeof(net_rcv_t)

typedef struct usr_lvl_str
    {
    char usr_priority[USR_PRI_LG + 1];
    char usr_reference[USR_REF_LG + 1];
    char mac_value[AUTH_LG + 1];
    char chk_value[CKSUM_LG + 1];
    int  usr_pde; 
    } usr_lvl_t; 

#define USR_LVL_TLG sizeof(usr_lvl_t)


typedef struct cas_rep_str 
    {
    api_hdr_t api_hdr;
    api_rep_t api_rep;
    } cas_rep_t;

#define CAS_REP_TLG sizeof(cas_rep_t)

typedef struct cas_lrp_str 
    {
    api_hdr_t api_hdr;
    api_lrp_t api_lrp;
    } cas_lrp_t;

#define CAS_LRP_TLG sizeof(cas_lrp_t)

typedef struct cas_dlv_str 
    {
    api_hdr_t api_hdr;
    api_rep_t api_rep;
    rep_dlv_t rep_dlv;
    } cas_dlv_t;

#define CAS_DLV_TLG sizeof(cas_dlv_t)

typedef struct cas_prc_str 
    {
    api_hdr_t api_hdr;
    api_rep_t api_rep;
    } cas_prc_t;

#define CAS_PRC_TLG sizeof(cas_prc_t)

typedef struct cas_sts_str 
    {
    api_hdr_t api_hdr;
    api_sts_t api_sts;
    } cas_sts_t;

#define CAS_STS_TLG sizeof(cas_sts_t)

/* send an NIF/NDF input message, this is a normal situation */

typedef struct cas_sdi_str 
    {
    api_hdr_t api_hdr;
    api_dat_t api_dat; 
    msg_lvl_t msg_lvl;
    usr_lvl_t usr_lvl;
    cbt_des_t cbt_des;
    net_des_t net_des;
    } cas_sdi_t;

#define CAS_SDI_TLG sizeof(cas_sdi_t)

/* receive a NIF/NDF output message, this is a normal situation  */

typedef struct cas_rvo_str 
    {
    api_hdr_t api_hdr;
    api_dat_t api_dat; 
    msg_lvl_t msg_lvl;
    usr_lvl_t usr_lvl;
    cbt_rcv_t cbt_rcv;
    net_rcv_t net_rcv;
    } cas_rvo_t;

#define CAS_RVO_TLG sizeof(cas_rvo_t)

/* send an NIF output message, special situation */

typedef struct cas_sdo_str 
    {
    api_hdr_t api_hdr;
    api_dat_t api_dat; 
    msg_lvl_t msg_lvl;
    usr_lvl_t usr_lvl;
    cbt_des_t cbt_des;
    net_rcv_t net_rcv;
    } cas_sdo_t;

#define CAS_SDO_TLG sizeof(cas_sdo_t)

/* receive an NIF input message, special situation */

typedef struct cas_rvi_str 
    {
    api_hdr_t api_hdr;
    api_dat_t api_dat; 
    msg_lvl_t msg_lvl;
    usr_lvl_t usr_lvl;
    cbt_rcv_t cbt_rcv;
    net_des_t net_des;
    } cas_rvi_t;

#define CAS_RVI_TLG sizeof(cas_rvi_t)


typedef struct cas_gen_str 
    {
    api_hdr_t api_hdr;
    char buffer[CAS_API_SIZ];
    } cas_gen_t;


typedef struct cas_ope_str 
    {
    api_hdr_t api_hdr;
    api_ope_t api_ope;
    } cas_ope_t;

#define CAS_OPE_TLG sizeof(cas_ope_t)

#define CAS_GEN_TLG sizeof(cas_gen_t)
#define SND_INP_TLG sizeof(snd_inp_t)
#define RCV_OUT_TLG sizeof(rcv_out_t)
#define RCV_INP_TLG sizeof(rcv_inp_t)
#define SND_OUT_TLG sizeof(snd_out_t)

/* routines prototyp */
/* ----------------- */

short casmf_init (int api_lvl, char *trc_file);
short casmf_sts  (cas_sts_t *cas_sts);
short casmf_evt  (int *nbr_evt);
short casmf_defval( cas_gen_t *cas_gen);
short casmf_open (cas_ope_t *cas_open, int open_typ, int timeout);
short casmf_snd  (cas_gen_t *cas_gen, char *dat_msg);
short casmf_rcv  (cas_gen_t *cas_gen, char *dat_msg, int timeout);
short casmf_close(cas_gen_t *cas_gen);
short casmf_break(cas_gen_t *cas_gen);
short casmf_abort(cas_gen_t *cas_gen);
short casmf_stop(void);
short casmf_timer(cas_gen_t *cas_gen , int timeout);

/* provide routines to dump api_v20 structures */
/* ------------------------------------------- */

#define API_FROM_USR  1      /* direction dump api struct receive from usr */
#define API_TO_USR    2                  /* dump api struct  sent  to user */
void dmp_apiv20  (cas_gen_t *cas_gen, int direct);       /* dump all block */
#endif 
