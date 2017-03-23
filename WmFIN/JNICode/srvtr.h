/*
================================================================================
=                                                                              =
=  MODULE     :  SRVTR   modules  TR_ for tracing and logging of event         =
=                                                                              =
=  DESCRIPTION:  service routine for tracing and loggin                        =
=                                                                              =
=  FILE       :  SRVTR.H                                                       =
=                                                                              =
=  AUTHOR     :  PHU                    DATE:    FEB-95                        =
=  UPDATES   :                                                                 =
=                                                                              =
================================================================================
*/

#ifndef __SRVTR_H__
#define __SRVTR_H__

#include <time.h>

/* trace/log type of information indication */

#define TYP_OPR    'O'          /* tell it to operator */
#define TYP_FAT    'F'          /* fatal error */
#define TYP_ERR    'E'          /* error for one context */
#define TYP_WAR    'W'          /* warning */
#define TYP_INF    'I'          /* information */
#define TYP_DEB    'D'          /* debug */
#define TYP_NUL    ' '          /* empty */
#define TYP_LST    'L'          /* last of multiple send for dmp or msg */
#define TYP_MSG    'M'          /* log of cas message */
#define TYP_CON    'C'          /* continue of previous info no time */
#define TYP_USR    'U'          /* user trace protected byt LVL_USR */
#define TYP_API    'a'          /* casmf API tracing */
#define TYP_INT    'i'          /* Internal API tracing */
#define TYP_GSE    'G'          /* reserved for GSE trace protected LVL_GSE */

#define PRI_REA    'r'          /* read primitive dump */
#define PRI_SND    's'          /* send primitive dump */

#define TRA_BUF_SIZE 480           /* read is limited to 512 bytes on vax */
#define LOGGER  "CUSLOG"               /* logger file name */

#define TR_LOCK   "TR_LOCK"           /* lock name to write to TR queue */

#define TR_SUCCES   TR_BASE 
#define TR_ERROR    TR_BASE + 1 
#define TR_EMPTY    TR_BASE + 2 

/* setting of trace/information  type for logger in primitive */

#define TR_LOG_I   Ctl_tr.tr_dat->level = TYP_INF
#define TR_LOG_W   Ctl_tr.tr_dat->level = TYP_WAR 
#define TR_LOG_E   Ctl_tr.tr_dat->level = TYP_ERR  
#define TR_LOG_F   Ctl_tr.tr_dat->level = TYP_FAT  
#define TR_LOG_O   Ctl_tr.tr_dat->level = TYP_OPR  
#define TR_LOG_D   Ctl_tr.tr_dat->level = TYP_DEB  
#define TR_LOG__   Ctl_tr.tr_dat->level = TYP_NUL
#define TR_LOG_M   Ctl_tr.tr_dat->level = TYP_MSG 
#define TR_LOG_C   Ctl_tr.tr_dat->level = TYP_CON 
#define TR_LOG_U   Ctl_tr.tr_dat->level = TYP_USR 
#define TR_LOG_API Ctl_tr.tr_dat->level = TYP_API
#define TR_LOG_INT Ctl_tr.tr_dat->level = TYP_INT 
#define TR_LOG_G   Ctl_tr.tr_dat->level = TYP_GSE 

#define TR_SND_PR  Ctl_tr.tr_dat->level = PRI_SND
#define TR_REA_PR  Ctl_tr.tr_dat->level = PRI_REA


/* used of routine char definition for all trace */


#define FUNNAM(p1)   static char *rout = p1

#define FOR_TR  Ctl_tr.tr_dat->destin = MO_TRA_ID   /* final destin id tracer */
#define FOR_LG  Ctl_tr.tr_dat->destin = MO_LOG_ID   /* final destin in logger */
#define FOR_AN  Ctl_tr.tr_dat->destin = MO_ASN_ID   /* ASN tracing */ 

/* tracing could be conditionned by level the first byte is module dependant, */
/* the second is a set of bit used for trace at start or at end of routine    */
/* with macro TR_INROU and TR_OUROU or following user request with LVL_BT2->7 */

#define LVL_INROU   (256 << 0)            /* first bit of 2 byte of trc_lvl */
#define LVL_OUROU   (256 << 1)
#define LVL_BT2     (256 << 2)
#define LVL_BT3     (256 << 3)
#define LVL_BT4     (256 << 4)
#define LVL_USR     (256 << 5)
#define LVL_GSE     (256 << 6)
#define LVL_MOD     255                 /* specific for module */

/*  primitives is exchange only between trace service and tracer process */
/* =-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

#define TR_DAT_HD  1               /* trace/log data header (with format) */
#define TR_DMP_HD  2                                 /* trace dump header */
#define TR_PRM_HD  3                                   /* dump primitive  */
#define TR_CLO_HD  4                       /* close trace/log file header */
#define TR_CLA_HD  5                               /* close ALL trace/log */
#define TR_MES_HD  6                         /* trace a message no format */


/* set tracing level for module and test tracing level or context_id */

#define SET_INROU  Ctl_tr.tr_lvl = Ctl_tr.tr_lvl | LVL_INROU
#define SET_OUROU  Ctl_tr.tr_lvl = Ctl_tr.tr_lvl | LVL_OUROU
#define SET_BT2    Ctl_tr.tr_lvl = Ctl_tr.tr_lvl | LVL_BT2 
#define SET_BT3    Ctl_tr.tr_lvl = Ctl_tr.tr_lvl | LVL_BT3
#define TR_SETTR(lv) Ctl_tr.tr_lvl = lv

#define TR_LVL(lv)         (Ctl_tr.tr_lvl & LVL_MOD) > lv
#define TR_CTX(ct)        ((Ctl_tr.tr_ctx = ct) || (Ctl_tr.tr_ctx < 0))
#define TR_LVLCT(lv,ct)   (TR_LVL(lv) && TR_CTX(ct) )


/* structure used by trace service and tracer */

typedef struct tr_dat_str
   {
    module_id_t   source;                          /* byte source module ref */
    module_id_t   destin;                     /* byte destination module ref */
    hdr_id_t      header;                         /* primitive identificator */
    char          level;                     /* level of logger info tracer  */
    ctx_id_t      ctx_id;           /* short identification of concerned ctx */
    char	  module[7];                         /* char output file ref */
    time_t	  time ;                           /* date-time of the event */
    short         hundred;                             /* hundred of seconde */ 
    int           offset;         /* when more than one prim buffer for dump */
    int		  data_lg;     /* length of data part after structure if any */
    } tr_dat_t;

#define TR_DAT_TLG sizeof (tr_dat_t)

/* general trace information structure   */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=  */

typedef struct ctl_tr_str
    {
    module_id_t   module_id;               /*  */
    short	    tr_lvl;      /* trace level in module byte 1 user value */
    short	    tr_ctx;                             /* -1 trace all ctx */
    void (*usr_fatal)();              /* called user routine if fatal error */
    int             msg_lg;           /* to store temporary lenght in macro */ 
    tr_dat_t	    *tr_dat;     /* pointer in buffer for direct fld access */
    char	    *tr_buf;                  /* start of message in buffer */
    void    (*fl_data)();                     /* routine pointer for DAT_HD */
    void    (*fl_dump)();                     /* routine pointer for DMP_HD */
    void    (*fl_prim)();                     /* routine pointer for PRM_HD */
    void    (*fl_mess)();                     /* routine pointer for MES_HD */
    char buffer[TRA_BUF_SIZE+ TR_DAT_TLG];  
                            /* tracing and logging informa */
    } ctl_tr_t;



/* global variable used by TRace service  routine  */ 
/* each user must define the char *Module variable */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

extern char *Trs_prod;
extern ctl_tr_t  Ctl_tr;  
extern char Log_buffer[TRA_BUF_SIZE]; 
/* routine prototypes  */
/* -=-=-=-=-=-=-=-=-=- */

void  tr_init(module_id_t module_id, char *trc_file , void (*fun)() );
void tr_stop();

void  pr_data();                              /* print a trace if not init */
void  pr_dump( int lg);                      /* dump a message if not init */
void  pr_prim( int lg);                      /* dump a primitiv if not init */
void  pr_mess( int lg);                      /* print a message if not init */
void  tr_data();                         /* send a trace request to tracer */
void  tr_dump(int lg);                    /* send a dump request to tracer */
void  tr_prim( int lg);                 /* dump a primitiv request to tracer */
void  tr_mess( int lg);                 /* trace a message (no formating) */

void  tr_pdmp(char *msg,int lg);       /* spit a dump of more than max byte */
void  tr_pmsg(char *msg,int lg);       /* spit a msg of more than max byte */
void  tr_pasn(char *msg,int lg);       /* spit a asn of more than max byte */

void  tr_flush ( unsigned char header, int dat_lg);

void srv_rou(short rou, short sts, ...);
void srv_sts( short sts );
char *get_srv_rou ( short rou_id);          /* get a string formating param */

void  set_format( char *fmt, ...);        /* format a string with parameter */
void  set_info( char *fmt, ...);      /* add format a string with parameter */

void  tra_ctl_evt( void *cq_dat);         /* change tracing info request */
void  tr_close (char *module);            /* request tracer to close a file */
void  tr_kill();                                  /* request tracer to stop */

#define TR_INROU      if(Ctl_tr.tr_lvl & LVL_INROU) TR_ROUT
#define TR_OUROU      if(Ctl_tr.tr_lvl & LVL_OUROU) TR_ROUT 

/* API and API Int Tracing macros */
#define TR_API		(FOR_TR, PUT_ROUT, TR_LOG_API, set_format)
#define TR_INAPI	if(Ctl_tr.tr_lvl & LVL_INROU) (FOR_TR, PUT_ROUT, TR_LOG_API, set_format)
#define TR_OUAPI	if(Ctl_tr.tr_lvl & LVL_OUROU) (FOR_TR, PUT_ROUT, TR_LOG_API, set_format)

#define TR_APII		(FOR_TR, TR_LOG_INT, set_format)
#define TR_INAPII	if(Ctl_tr.tr_lvl & LVL_INROU) (FOR_TR, PUT_ROUT, TR_LOG_INT, set_format)
#define TR_OUAPII	if(Ctl_tr.tr_lvl & LVL_OUROU) (FOR_TR, PUT_ROUT, TR_LOG_INT, set_format)

#define TR_BIT2       (Ctl_tr.tr_lvl & LVL_BT2)  
#define TR_BIT3       (Ctl_tr.tr_lvl & LVL_BT3)  
#define TR_BIT4       (Ctl_tr.tr_lvl & LVL_BT4)  
#define TR_BUSR       (Ctl_tr.tr_lvl & LVL_USR)  
#define TR_BGSE       (Ctl_tr.tr_lvl & LVL_GSE)


#define TR_PUT(p1)     strcat(Ctl_tr.tr_buf, p1) 

#define TR_PRIM(p1) { FOR_TR;                                       \
     Ctl_tr.msg_lg = MIN(CQ_DAT_TLG+p1->data_lg,TRA_BUF_SIZE);      \
     memmove( Ctl_tr.tr_buf, (char*)p1, Ctl_tr.msg_lg);              \
     Ctl_tr.fl_prim(Ctl_tr.msg_lg);}                                 \

#define TR_PRIM_S(p1) { TR_SND_PR; TR_PRIM(p1)}
#define TR_PRIM_R(p1) { TR_REA_PR; TR_PRIM(p1)}

#define TR_DUMP(hdr,msg,lg)   { TR_DATA(hdr);FOR_TR; tr_pdmp(msg,lg);}
#define TR_DUMP_E(hdr,msg,lg) { TR_DATA_E(hdr);FOR_TR; tr_pdmp(msg,lg);}
#define TR_DUMP_I(hdr,msg,lg) { TR_DATA_I(hdr);FOR_TR; tr_pdmp(msg,lg);}
#define TR_DUMP_F(hdr,msg,lg) { TR_DATA_F(hdr);FOR_TR; tr_pdmp(msg,lg);}
#define TR_DUMP_D(hdr,msg,lg) { TR_DATA_D(hdr);FOR_TR; tr_pdmp(msg,lg);}
#define TR_DUMP_U(hdr,msg,lg) { TR_DATA_U(hdr);FOR_TR; tr_pdmp(msg,lg);}

#define LG_ASN_OU(msg,lg) {FOR_AN; tr_pasn(msg,lg);} 
#define LG_ASN_IN(msg,lg) {FOR_AN; tr_pasn(msg,lg);} 


#define TR_MESS(hdr,msg,lg) { TR_DATA(hdr);FOR_TR; tr_pmsg(msg,lg);}
#define TR_MESS_U(hdr,msg,lg) { TR_DATA_U(hdr);FOR_TR; tr_pmsg(msg,lg);}

                 /* formated string  primitive tracing */


#define PUT_ROUT     sprintf(Ctl_tr.tr_buf,"%13.13s ",rout)
#define TR_ERRNO(s1)   {FOR_TR;TR_PUT(s1); set_format(" %d",XX_errno);}
#define TR_ERRNO_F(s1) {FOR_TR;TR_LOG_F,TR_PUT(s1);set_format(" %d",XX_errno);}

#define TR_DATA     (FOR_TR, set_format)
#define TR_DATA_E   (FOR_TR, TR_LOG_E, set_format)
#define TR_DATA_I   (FOR_TR, TR_LOG_I, set_format)
#define TR_DATA_F   (FOR_TR, TR_LOG_F, set_format)
#define TR_DATA_D   (FOR_TR, TR_LOG_D, set_format)
#define TR_DATA_W   (FOR_TR, TR_LOG_W, set_format)
#define TR_DATA_U   (FOR_TR, TR_LOG_U, set_format)
#define TR_DATA_G   (FOR_TR, TR_LOG_G, set_format)

#define TR_DATA_S   (FOR_TR, TR_SND_PR, set_format)
#define TR_DATA_R   (FOR_TR, TR_REA_PR, set_format)

#define TR_ROUT       (FOR_TR, PUT_ROUT, set_format) 
#define TR_ROUT_E     (FOR_TR, TR_LOG_E, PUT_ROUT, set_format) 
#define TR_ROUT_I     (FOR_TR, TR_LOG_I, PUT_ROUT, set_format) 
#define TR_ROUT_F     (FOR_TR, TR_LOG_F, PUT_ROUT, set_format) 
#define TR_ROUT_D     (FOR_TR, TR_LOG_D, PUT_ROUT, set_format) 

#define TR_STORE      set_info 
#define TR_FLUSH      FOR_TR; Ctl_tr.fl_data(); 


/* MACRO to send information to trace at user level */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

/*The expand of LVL_USR in UTR_MESS & UTR_DUMP does not work correctly on HP!!*/
#define UTR_DATA  if(Ctl_tr.tr_lvl & LVL_USR) TR_DATA_U
#define UTR_DUMP  if(Ctl_tr.tr_lvl & (256 << 5)) TR_DUMP_U
#define UTR_MESS  if(Ctl_tr.tr_lvl & (256 << 5)) TR_MESS_U

/* MACRO to send information to trace at GSE level */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

#define GTR_ROUT  if(Ctl_tr.tr_lvl & LVL_GSE) TR_ROUT
#define GTR_DATA  if(Ctl_tr.tr_lvl & LVL_GSE) (FOR_TR, TR_LOG_G, set_format)
#define GTR_DUMP  if(Ctl_tr.tr_lvl & LVL_GSE) { TR_DATA_G(hdr);FOR_TR; tr_pdmp(msg,lg);}
#define GTR_MESS  if(Ctl_tr.tr_lvl & LVL_GSE) { TR_DATA_G(hdr);FOR_TR; tr_pmsg(msg,lg);}


/* MACRO to send information to logger */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

#define LG_DATA      (FOR_LG, TR_LOG__, set_format)
#define LG_DATA_O    (FOR_LG, TR_LOG_O, set_format)
#define LG_DATA_C    (FOR_LG, TR_LOG_C, set_format)
#define LG_DATA_W    (FOR_LG, TR_LOG_W, set_format)
#define LG_DATA_I    (FOR_LG, TR_LOG_I, set_format)
#define LG_DATA_F    (FOR_LG, TR_LOG_F, set_format)
#define LG_DATA_E    (FOR_LG, TR_LOG_E, set_format)
#define LG_DATA_M    (FOR_LG, TR_LOG_M, set_format)
#define LG_DATA_U    (FOR_LG, TR_LOG_U, set_format)
#define LG_MESS(hdr,msg,lg) { LG_DATA_M(hdr);FOR_LG; tr_pmsg(msg,lg);}
#define LG_STORE      log_info 
#define LG_FLUSH      {FOR_LG; strcpy(Ctl_tr.tr_buf,Log_buffer);Ctl_tr.fl_data();Log_buffer[0]=0;} 
#define LG_FLUSH_M    {TR_LOG_M; FOR_LG; strcpy(Ctl_tr.tr_buf,Log_buffer); Ctl_tr.fl_data();Log_buffer[0]=0;} 
#define LG_ERRNO(s1)  {FOR_LG; TR_PUT(s1); set_format(" %d %s",errno,\
                            strerror(errno) );}


/* services, modules status string translation for log or trace */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

#define TR_SRV_ROU    (FOR_TR, PUT_ROUT, srv_rou) 
#define TR_SRV_ROU_F  (FOR_TR, PUT_ROUT, TR_LOG_F, srv_rou) 
#define TR_SRV_STS    (FOR_TR, srv_sts) 
#define TR_SRV_STS_F  (FOR_TR, TR_LOG_F, srv_sts) 
#define TR_MOD_MSG    (FOR_TR, mod_msg)

#define LG_SRV_STS_E  (FOR_LG, TR_LOG_E, PUT_ROUT, srv_sts) 
#define LG_SRV_STS_I  (FOR_LG, TR_LOG_I, PUT_ROUT, srv_sts) 
#define LG_SRV_STS_F  (FOR_LG, TR_LOG_F, PUT_ROUT, srv_sts) 


#define LG_MOD_MSG    (FOR_LG, mod_msg)
#define LG_MOD_MSG_U  (FOR_LG, mod_msg_unf)
#define LG_MOD_MSG_O  (FOR_LG, TR_LOG_O, mod_msg)
#define LG_MOD_MSG_W  (FOR_LG, TR_LOG_W, mod_msg)
#define LG_MOD_MSG_I  (FOR_LG, TR_LOG_I, mod_msg)
#define LG_MOD_MSG_E  (FOR_LG, TR_LOG_E, mod_msg)
#define LG_MOD_MSG_F  (FOR_LG, TR_LOG_F, mod_msg)
#define LG_MOD_MSG_C  (FOR_LG, TR_LOG_C, mod_msg)
#define LG_MOD_MSG_M  (FOR_LG, TR_LOG_M, mod_msg)
#define LG_STORE_MSG  (FOR_LG,    mod_msg_cnt )

#endif
