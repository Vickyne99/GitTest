#include <stdio.h>
#include "custom.h"
#include "usr_typ.h"
#include "cusapi2.h"

/*
static cas_gen_t cas_gen;
static cas_rep_t *cas_rep ;
static cas_lrp_t *cas_lrp ;
static cas_dlv_t *cas_dlv ;
static cas_prc_t *cas_prc ;
static cas_sts_t *cas_sts ;
static cas_sdi_t *cas_sdi ;
static cas_rvo_t *cas_rvo ;
static cas_sdo_t *cas_sdo ;
static cas_rvi_t *cas_rvi ;
static cas_ope_t *cas_ope ;
*/

cas_gen_t cas_gen;
cas_rep_t *cas_rep ;
cas_lrp_t *cas_lrp ;
cas_dlv_t *cas_dlv ;
cas_prc_t *cas_prc ;
cas_sts_t *cas_sts ;
cas_sdi_t *cas_sdi ;
cas_rvo_t *cas_rvo ;
cas_sdo_t *cas_sdo ;
cas_rvi_t *cas_rvi ;
cas_ope_t *cas_ope ;

void initialise() {

// initialise cas_gen struct
if(cas_gen.buffer)
	memset(cas_gen.buffer,'\0',sizeof(cas_gen.buffer));

cas_gen.api_hdr.api_typ = 0;
cas_gen.api_hdr.ctx_id = 0;
cas_gen.api_hdr.apdu_msg = 0;
cas_gen.api_hdr.session_nb = 0;
cas_gen.api_hdr.seq_nb = 0;

if(cas_gen.api_hdr.sender_ref)
memset(cas_gen.api_hdr.sender_ref,'\0',sizeof(cas_gen.api_hdr.sender_ref));

cas_gen.api_hdr.duplicate = 0;
cas_gen.api_hdr.auth_result = 0;
cas_gen.api_hdr.api_reserved = 0;

cas_rep = (cas_rep_t *) &cas_gen;
cas_lrp = (cas_lrp_t *) &cas_gen;
cas_dlv = (cas_dlv_t *) &cas_gen;
cas_prc = (cas_prc_t *) &cas_gen;
cas_sts = (cas_sts_t *) &cas_gen;
cas_sdi = (cas_sdi_t *) &cas_gen;
cas_rvo = (cas_rvo_t *) &cas_gen;
cas_sdo = (cas_sdo_t *) &cas_gen;
cas_rvi = (cas_rvi_t *) &cas_gen;
cas_ope = (cas_ope_t *) &cas_gen;

}

cas_gen_t * getCasGen() {
  return &cas_gen;
}

cas_rep_t * getCasRep() {
  return cas_rep;
}

cas_lrp_t * getCasLrp() {
  return cas_lrp;
}

cas_dlv_t * getCasDlv() {
  return cas_dlv;
}

cas_prc_t * getCasPrc() {
  return cas_prc;
}

cas_sts_t * getCasSts() {
  return cas_sts;
}

cas_sdi_t * getCasSdi() {
  return cas_sdi;
}

cas_rvo_t * getCasRvo() {
  return cas_rvo;
}

cas_sdo_t * getCasSdo() {
  return cas_sdo;
}

cas_rvi_t * getCasRvi() {
  return cas_rvi;
}

cas_ope_t * getCasOpe() {
  return cas_ope;
}

char* getRepText() {
  printf("/**** In fix.c: before getting cas_dlv\n");
  //cas_dlv = getCasDlv();
  printf("/**** In fix.c: report = %s\n",cas_dlv->rep_dlv.rep_text);
  return cas_dlv->rep_dlv.rep_text;
}
