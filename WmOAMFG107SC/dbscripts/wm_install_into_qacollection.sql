/*  ***************************************************************************
        $Date:   17 Nov 2002 10:56:36  $
        $Revision:   1.0  $
        $Author:
    *   Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Installation Script for Quality Collection Inbound
    * Program Name:         wm_install_into_qacollection.sql
    * Version #:            1.0
    * Title:                Installation Script for Quality Collection Inbound
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:         This script calls all other scripts used for installing Components
    *				   for Quality Collection inbound Trnsactions.      
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
     17-NOV-02	 Sudip Chaudhuri          Created
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
  
  define custom_tablespace      	= "&&Tablespace" -- Custom User Table tablespace
  define custom_indexspace      	= "&&Indexspace" -- Custom User Index tablespace
  define DBString    			= "&&DBString" -- Database Instance in Oracle Apps 



prompt Installing Packages.....
@@wm_into_qacollection_pkg.sql

SHOW ERRORS

prompt Install Completed for Quality Collection Inbound

