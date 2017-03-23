/*  ***************************************************************************
    *    $Date:   14 Oct 2001 10:56:36  $
    *    $Revision:   1.0  $
    *    $Author:   TCS  $
    *    Copyright (c) 2002, webMethods Inc. All Rights Reserved
    *
    *************************************************************************** 
    ***************************************************************************
    * Application:          webMethods
    * Process Name:         Create Custom Views for Bom Routings outbound in Application Schema  
    * Program Name:         wm_from_bomrouting_vw.sql
    * Version #:            1.0
    * Title:                View Installation Script for webMethods Oracle Apps Adapter 3.0
    * Utility:              SQL*Plus
    * Created by:           
    * Creation   Date:      
    *
    * Description:              
    *
    *           Create Views in APPS schema for Bom Routings Outbound
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
    *           Param1: &SpoolFile     
    *           Param2: &Apps User Password
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
     14-OCT-02	   Rajib Naha		   Created
    ***************************************************************************
*/

  set feedback  on
  set verify            off
  set newpage   0
  set pause             off
  set termout   on

 prompt Program : wm_from_bomrouting_vw.sql

  
connect &&apps_user/&&appspwd@&&DBString 

REM "Creating Views....."

/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_BOM_OP_ROUTING_QRY_VW
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_BOM_OP_ROUTING_QRY_VW
(
 	WEB_TRANSACTION_ID,
	DOCUMENT_TYPE,
	DOCUMENT_STATUS,
	ROUTING_SEQUENCE_ID, 
	ORGANIZATION_NAME,
	ASSEMBLY_ITEM_NUMBER,
	ALTERNATE_ROUTING_DESIGNATOR,
	ROUTING_TYPE,
	COMMOM_ITEM_NUMBER,
	COMMON_ORG_NAME,
	ROUTING_COMMENT ,
	COMPLETION_SUBINVENTORY ,
	DEMAND_SOURCE_LINE,
	SET_ID,
	DEMAND_SOURCE_TYPE,
	DEMAND_SOURCE_HEADER_ID,
	LOCATION_NAME,
	TRANSACTION_TYPE,
	LINE_CODE,
	MIXED_MODEL_MAP_FLAG,
	PRIORITY,
	CFM_ROUTING_FLAG,
	TOTAL_PRODUCT_CYCLE_TIME,
	CTP_FLAG
)AS
SELECT 
	NULL,
	'BOM_ROUTING',
	'QUERY',
	BOR.ROUTING_SEQUENCE_ID ROUTING_SEQUENCE_ID, 
	HOU.NAME ORGANIZATION_NAME,
	MSIK.CONCATENATED_SEGMENTS ASSEMBLY_ITEM_NUMBER,
	BOR.ALTERNATE_ROUTING_DESIGNATOR ALTERNATE_ROUTING_DESIGNATOR,
	BOR.ROUTING_TYPE ROUTING_TYPE,
	MSIK1.CONCATENATED_SEGMENTS COMMOM_ITEM_NUMBER,
	HOU1.NAME COMMON_ORG_NAME,
	BOR.ROUTING_COMMENT ,
	BOR.COMPLETION_SUBINVENTORY ,
	NULL DEMAND_SOURCE_LINE,
	NULL SET_ID,
	NULL DEMAND_SOURCE_TYPE,
	NULL DEMAND_SOURCE_HEADER_ID,
	MIL.DESCRIPTION LOCATION_NAME,
	NULL TRANSACTION_TYPE,
	WL.LINE_CODE LINE_CODE,
	NVL(BOR.MIXED_MODEL_MAP_FLAG, 2) MIXED_MODEL_MAP_FLAG,
	BOR.PRIORITY PRIORITY,
	BOR.CFM_ROUTING_FLAG CFM_ROUTING_FLAG,
	BOR.TOTAL_PRODUCT_CYCLE_TIME TOTAL_PRODUCT_CYCLE_TIME,
	NVL( BOR.CTP_FLAG, 2) CTP_FLAG
FROM 
	WIP_LINES WL , 
	BOM_OPERATIONAL_ROUTINGS BOR , 
	MTL_SECONDARY_INVENTORIES MSI ,
	HR_ALL_ORGANIZATION_UNITS HOU,
	MTL_SYSTEM_ITEMS_B_KFV MSIK,
	MTL_ITEM_LOCATIONS MIL,
	HR_ALL_ORGANIZATION_UNITS HOU1,
	MTL_SYSTEM_ITEMS_B_KFV MSIK1
WHERE 
	BOR.COMPLETION_SUBINVENTORY = MSI.SECONDARY_INVENTORY_NAME (+) 
	AND BOR.ORGANIZATION_ID = MSI.ORGANIZATION_ID (+) 
	AND BOR.ORGANIZATION_ID = MSIK.ORGANIZATION_ID (+)
	AND BOR.ASSEMBLY_ITEM_ID = MSIK.INVENTORY_ITEM_ID (+)
	AND BOR.ORGANIZATION_ID = HOU.ORGANIZATION_ID (+)
	AND BOR.ORGANIZATION_ID = MSIK1.ORGANIZATION_ID(+)
	AND BOR.ASSEMBLY_ITEM_ID = MSIK1.INVENTORY_ITEM_ID(+)
	AND BOR.ORGANIZATION_ID = HOU1.ORGANIZATION_ID(+)
	AND BOR.LINE_ID = WL.LINE_ID (+) 
	AND BOR.COMPLETION_LOCATOR_ID = MIL.INVENTORY_LOCATION_ID(+)
 
/


/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_MTL_RTG_ITEM_REVS_QRY_VW
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_MTL_RTG_ITEM_REVS_QRY_VW
(
	ROUTING_SEQUENCE_ID,
	PROCESS_REVISION,
	CHANGE_NOTICE,
	ECN_INITIATION_DATE,
	IMPLEMENTATION_DATE,
	EFFECTIVITY_DATE,
	INVENTORY_ITEM_NUMBER,
	ORGANIZATION_NAME,
	TRANSACTION_TYPE
)AS
SELECT 
	BOR.ROUTING_SEQUENCE_ID ROUTING_SEQUENCE_ID,
	MRIR.PROCESS_REVISION PROCESS_REVISION,
	MRIR.CHANGE_NOTICE CHANGE_NOTICE,
	MRIR.ECN_INITIATION_DATE ECN_INITIATION_DATE,
	MRIR.IMPLEMENTATION_DATE IMPLEMENTATION_DATE,
	MRIR.EFFECTIVITY_DATE EFFECTIVITY_DATE,
	MSIK.CONCATENATED_SEGMENTS INVENTORY_ITEM_NUMBER,
	HOU.NAME ORGANIZATION_NAME,
	NULL TRANSACTION_TYPE
FROM
	MTL_RTG_ITEM_REVISIONS MRIR,
	BOM_OPERATIONAL_ROUTINGS BOR , 
	MTL_SYSTEM_ITEMS_B_KFV MSIK,
	HR_ALL_ORGANIZATION_UNITS HOU
WHERE
	BOR.ASSEMBLY_ITEM_ID (+)= MRIR.INVENTORY_ITEM_ID
	AND BOR.ORGANIZATION_ID (+) = MRIR.ORGANIZATION_ID
	AND BOR.ORGANIZATION_ID = HOU.ORGANIZATION_ID (+)
	AND MRIR.INVENTORY_ITEM_ID = MSIK.INVENTORY_ITEM_ID (+)
	AND MRIR.ORGANIZATION_ID = MSIK.ORGANIZATION_ID (+)

/

/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_BOM_OP_SEQUENCES_QRY_VW
/*----------------------------------------------------------------------*/

CREATE OR REPLACE VIEW WM_BOM_OP_SEQUENCES_QRY_VW
(
	OPERATION_SEQUENCE_ID,
	ROUTING_SEQUENCE_ID,
	OPERATION_SEQ_NUM , 
	OPERATION_LEAD_TIME_PERCENT , 
	MINIMUM_TRANSFER_QUANTITY , 
	COUNT_POINT_TYPE ,
	OPERATION_DESCRIPTION ,
	EFFECTIVITY_DATE ,
	DISABLE_DATE , 
	BACKFLUSH_FLAG , 
	OPTION_DEPENDENT_FLAG , 
	ALTERNATE_ROUTING_DESIGNATOR,
	ORGANIZATION_NAME,
	ASSEMBLY_ITEM_NUMBER,
	DEPARTMENT_CODE,
	OPERATION_CODE ,
	TRANSACTION_TYPE,
	NEW_OPERATION_SEQ_NUM,
	NEW_EFFECTIVITY_DATE,
	ASSEMBLY_TYPE,
	OPERATION_TYPE,
	REFERENCE_FLAG, 
	PROCESS_OP_SEQ_ID ,
	LINE_OP_SEQ_ID ,
	YIELD , 
	REVERSE_CUMULATIVE_YIELD ,
	LABOR_TIME_CALC ,
	MACHINE_TIME_CALC , 
	TOTAL_TIME_CALC , 
	LABOR_TIME_USER , 
	MACHINE_TIME_USER , 
	TOTAL_TIME_USER , 
	NET_PLANNING_PERCENT ,
	INCLUDE_IN_ROLLUP , 
	OPERATION_YIELD_ENABLED,
	RESOURCE_CODE1,
	RESOURCE_CODE2,
	RESOURCE_CODE3,
	INSTRUCTION_CODE1,
	INSTRUCTION_CODE2,
	INSTRUCTION_CODE3
) AS
SELECT
	BOS.OPERATION_SEQUENCE_ID, 
	BOS.ROUTING_SEQUENCE_ID,
	BOS.OPERATION_SEQ_NUM , 
	BOS.OPERATION_LEAD_TIME_PERCENT , 
	BOS.MINIMUM_TRANSFER_QUANTITY , 
	BOS.COUNT_POINT_TYPE ,
	BOS.OPERATION_DESCRIPTION ,
	BOS.EFFECTIVITY_DATE ,
	BOS.DISABLE_DATE , 
	BOS.BACKFLUSH_FLAG , 
	BOS.OPTION_DEPENDENT_FLAG , 
	BOR.ALTERNATE_ROUTING_DESIGNATOR,
	HOU.NAME ORGANIZATION_NAME,
	MSIK.CONCATENATED_SEGMENTS ASSEMBLY_ITEM_NUMBER,
	BD.DEPARTMENT_CODE,
	BSO.OPERATION_CODE OPERATION_CODE ,
	NULL TRANSACTION_TYPE,
	NULL NEW_OPERATION_SEQ_NUM,
	NULL NEW_EFFECTIVITY_DATE,
	NULL ASSEMBLY_TYPE,
	NVL(BOS.OPERATION_TYPE, 1) OPERATION_TYPE,
	NVL(BOS.REFERENCE_FLAG, 2) REFERENCE_FLAG, 
	BOS.PROCESS_OP_SEQ_ID ,
	BOS.LINE_OP_SEQ_ID ,
	BOS.YIELD , 
	BOS.REVERSE_CUMULATIVE_YIELD ,
	BOS.LABOR_TIME_CALC ,
	BOS.MACHINE_TIME_CALC , 
	BOS.TOTAL_TIME_CALC , 
	BOS.LABOR_TIME_USER , 
	BOS.MACHINE_TIME_USER , 
	BOS.TOTAL_TIME_USER , 
	BOS.NET_PLANNING_PERCENT ,
	BOS.INCLUDE_IN_ROLLUP , 
	BOS.OPERATION_YIELD_ENABLED,
	NULL RESOURCE_CODE1,
	NULL RESOURCE_CODE2,
	NULL RESOURCE_CODE3,
	NULL INSTRUCTION_CODE1,
	NULL INSTRUCTION_CODE2,
	NULL INSTRUCTION_CODE3
FROM 
	BOM_OPERATION_SEQUENCES BOS , 
	BOM_DEPARTMENTS BD , 
	BOM_OPERATIONAL_ROUTINGS BOR,
	BOM_STANDARD_OPERATIONS BSO ,
	MTL_SYSTEM_ITEMS_B_KFV MSIK,
	HR_ALL_ORGANIZATION_UNITS HOU
WHERE 
	BOS.DEPARTMENT_ID = BD.DEPARTMENT_ID (+) 
	AND BOS.STANDARD_OPERATION_ID = BSO.STANDARD_OPERATION_ID (+) 
	AND BOS.ROUTING_SEQUENCE_ID = BOR.ROUTING_SEQUENCE_ID (+)
	AND BOR.ORGANIZATION_ID = HOU.ORGANIZATION_ID (+)
	AND BOR.ASSEMBLY_ITEM_ID = MSIK.INVENTORY_ITEM_ID (+)
	AND BOR.ORGANIZATION_ID = MSIK.ORGANIZATION_ID (+)
	AND NVL(BOS.ECO_FOR_PRODUCTION,2) = 2

/

/*----------------------------------------------------------------------*/
--      CREATE VIEW WM_BOM_OP_RESOURCES_QRY_VW
/*----------------------------------------------------------------------*/


CREATE OR REPLACE VIEW WM_BOM_OP_RESOURCES_QRY_VW
(
	OPERATION_SEQUENCE_ID,
	RESOURCE_SEQ_NUM ,
	ACD_TYPE, 
	ROUTING_SEQUENCE_ID,
	STANDARD_RATE_FLAG , 
	ASSIGNED_UNITS , 
	USAGE_RATE_OR_AMOUNT , 
	USAGE_RATE_OR_AMOUNT_INVERSE , 
	BASIS_TYPE , 
	SCHEDULE_FLAG , 
	RESOURCE_OFFSET_PERCENT ,
	AUTOCHARGE_TYPE , 
	ALTERNATE_ROUTING_DESIGNATOR,
	OPERATION_SEQ_NUM,
	EFFECTIVITY_DATE,
	ORGANIZATION_NAME,
	ASSEMBLY_ITEM_NUMBER,
	RESOURCE_CODE , 
	ACTIVITY , 
	TRANSACTION_TYPE,
	NEW_RESOURCE_SEQUENCE_NUM
) AS
SELECT
	BOR.OPERATION_SEQUENCE_ID,
	BOR.RESOURCE_SEQ_NUM,
	BOR.ACD_TYPE, 
	BOS.ROUTING_SEQUENCE_ID,
	BOR.STANDARD_RATE_FLAG , 
	BOR.ASSIGNED_UNITS , 
	BOR.USAGE_RATE_OR_AMOUNT , 
	BOR.USAGE_RATE_OR_AMOUNT_INVERSE , 
	BOR.BASIS_TYPE , 
	BOR.SCHEDULE_FLAG , 
	BOR.RESOURCE_OFFSET_PERCENT ,
	BOR.AUTOCHARGE_TYPE , 
	BOROU.ALTERNATE_ROUTING_DESIGNATOR,
	BOS.OPERATION_SEQ_NUM,
	BOS.EFFECTIVITY_DATE,
	HOU.NAME ORGANIZATION_NAME,
	MSIK.CONCATENATED_SEGMENTS ASSEMBLY_ITEM_NUMBER,
	BR.RESOURCE_CODE , 
	CA.ACTIVITY , 
	NULL TRANSACTION_TYPE,
	NULL NEW_RESOURCE_SEQUENCE_NUM
FROM 
	BOM_OPERATION_RESOURCES BOR , 
	BOM_OPERATIONAL_ROUTINGS BOROU,
	BOM_OPERATION_SEQUENCES BOS , 
	BOM_RESOURCES BR , 
	BOM_DEPARTMENT_RESOURCES BDR , 
	CST_ACTIVITIES CA ,
	HR_ALL_ORGANIZATION_UNITS HOU,
	MTL_SYSTEM_ITEMS_B_KFV MSIK
WHERE 
	BR.RESOURCE_ID = BOR.RESOURCE_ID 
	AND BDR.DEPARTMENT_ID = BOS.DEPARTMENT_ID 
	AND BDR.RESOURCE_ID  = BOR.RESOURCE_ID  
	AND BOR.OPERATION_SEQUENCE_ID = BOS.OPERATION_SEQUENCE_ID 
	AND NVL(BOS.OPERATION_TYPE, 1) = 1 
	AND BOR.ACTIVITY_ID = CA.ACTIVITY_ID (+)
	AND BOS.ROUTING_SEQUENCE_ID = BOROU.ROUTING_SEQUENCE_ID 
	AND BOROU.ORGANIZATION_ID = MSIK.ORGANIZATION_ID (+)
	AND BOROU.ASSEMBLY_ITEM_ID = MSIK.INVENTORY_ITEM_ID (+)
	AND BOROU.ORGANIZATION_ID = HOU.ORGANIZATION_ID (+)
 
/

SHOW ERRORS

