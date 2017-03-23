/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:   
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Insert Core Seed Data 
    * Program Name:         wm_core_dml.sql
    * Version #:            1.0
    * Title:                Seed Data DML Statements
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Insert seed data into WM_CONTROL table for 
    *			     		Outbound Transactions			
    *
    *    
    * 
    *		
    *
    *
    * Technical Implementation Notes:
    *
    *
    * Change History:
    *
    *==========================================================================
    * Date       | Name                  | Remarks
    *==========================================================================
     12-AUG-02	   Sudip Kumar Chaudhuri   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

  prompt Program : wm_core_dml.sql

  connect &&apps_user/&&appspwd@&&DBString

REM "Deleting Old Seed Data....."

DELETE FROM wm_control;

DELETE FROM WM_SEND_REFERENCE_T;

REM "Inserting Seed Data....."


INSERT INTO wm_control (transaction_type, status ) Values ('VENDOR', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('CUSTOMER', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('APINVOICE', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('JOURNAL', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('PO', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('ARTRANSACTION', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('SALESORDER', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('APPAYMENT', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('ITEM', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('SUPPLIER', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('MFGBOM', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('PICKDETAIL', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('ASN', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('ENGBOM', 'READY');

INSERT INTO wm_control (transaction_type, status ) Values ('RFQ', 'READY');



insert into WM_SEND_REFERENCE_T values (1000, 'VENDOR', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1001, 'CUSTOMER', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1002, 'APINVOICE', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1003, 'JOURNAL', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1004, 'PO', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1005, 'ARTRANSACTION', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1006, 'SALESORDER', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1007, 'APPAYMENT', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1008, 'ITEM', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1009, 'SUPPLIER', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1010, 'MFGBOM', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1011, 'PICKDETAIL', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1012, 'ASN', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1013, 'ENGBOM', SYSDATE, 0);

insert into WM_SEND_REFERENCE_T values (1014, 'RFQ', SYSDATE, 0);


COMMIT;

SHOW ERRORS


