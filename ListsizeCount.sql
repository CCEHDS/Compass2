DECLARE @RelRunDate AS DATE	
SET @RelRunDate = '2020-08-01'    -- GETDATE()	
	
IF OBJECT_ID('tempdb..#ListSize', 'U') IS NOT NULL 	
       DROP TABLE #ListSize;	
	
CREATE TABLE #ListSize	
(	
	 relrun_date date
	,person_id  bigint
	,patient_id bigint
	,organization_id bigint
	,date_of_birth date
	,gender_concept_id int
	,ethnic_code_concept_id int
	,episode_of_care_id  bigint
	,date_registered date
	,date_registered_end date
	,ods_code nvarchar(8)
	,report_name nvarchar(100)
	,ccg_ods nvarchar(3)
);	
	
INSERT INTO #ListSize	
EXEC db_lookup.[gpdraft].[spGetListsize] @RelRunDate, 'ALL';	
	
SELECT 	
	CURRENT_TIMESTAMP AS run_datetime
	,relrun_date
	,ccg_ods
	,ods_code
	,report_name
	,COUNT(patient_id) AS patient_count
FROM #ListSize
GROUP BY relrun_date, ccg_ods, ods_code, report_name
