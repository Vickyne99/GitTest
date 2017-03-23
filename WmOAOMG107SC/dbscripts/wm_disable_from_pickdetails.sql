/*  ***************************************************************************
        $Date:   26 Nov 2002 10:56:36  $
        $Revision:   1.0  $
        $Author: 
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Disable Triggers for Pick Details outbound in APPS schema
    * Program Name:         wm_disable_from_pickdetails.sql
    * Version #:            1.0
    * Title:                Disable Triggers in APPS schema used for Pick Details Outbound 			
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:           Disable Triggers in Apps schema used for              
    *			     	    Pick Details Outbound 			
    *
    *    
    * 
    *		
    * Triggers to disable: 		wm_so_picking_headers_u_trg
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
     26-NOV-02	  Gautam Naha   	Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on
  
  define apps_user  = '&apps_user' -- APPS User Id
  define appspwd	    = '&appspwd'  -- APPS Password
  define DB_Name    = "&DBString" -- Database Instance in Oracle Apps 
  

  prompt Program : wm_disable_from_pickdetails.sql

  connect &&apps_user/&&appspwd@&&DB_Name

REM "Disabling Triggers....."

ALTER TRIGGER wm_so_picking_headers_u_trg DISABLE;

SHOW ERRORS

exit;