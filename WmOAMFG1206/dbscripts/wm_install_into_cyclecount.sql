/*  ***************************************************************************
        $Date:   14 Aug 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Installation Script for Cycle Count Transaction Inbound
    * Program Name:         wm_install_into_cyclecount.sql
    * Version #:            1.0
    * Title:                Installation Script for Cycle Count Transaction
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:         This script calls all other scripts used for installing Components
    *				   for Cycle Count Entries inbound Trnsactions.      
    *
    *           
    * Tables usage:     
    *           
    *
    * Procedures and Functions:
    *		
    * 
    * Restart Information:      
    *
    *
    *
    * Flexfields Used:          
    *
    *
    *
    * Value Sets Used:          
    *
    *
    * Input Parameters:     
    *         
    
    *   
    *
    * Menu Responsibilities and path: 
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
     27-SEP-02	 Sudip Chaudhuri          Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

  define apps_user  			= "&&apps_user" -- APPS User Id
  define appspwd    			= "&&appspwd"
  
  define custom_user 			= "&custom_user"
  define custom_password 		= "&&custom_password" 
  
  define custom_tablespace        	= "&&Tablespace" -- Custom User Table tablespace
  define custom_indexspace        	= "&&Indexspace" -- Custom User Index tablespace
  define DBString    			= "&&DBString" -- Database Instance in Oracle Apps 


prompt Installing Sequences...
@@wm_into_cyclecount_seq.sql

prompt Installing Synonyms...
@@wm_into_cyclecount_syn.sql

prompt Installing Packages.....
@@wm_into_cyclecount_pkg.sql

SHOW ERRORS

prompt Install Completed for Cycle Count Transaction Inbound

