USE [db_lookup]
GO
/****** Object:  StoredProcedure [gpdraft].[spGetListsize]    Script Date: 19/08/2020 16:01:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [gpdraft].[spGetListsize] 

 @RelRunDate date
,@CCG varchar(15)

AS
BEGIN


	if TRIM(@CCG) = 'ALL'			-- OR TRIM(@CCG) = ''
		SET @CCG = '07T,08M,08V,08W'


SELECT
@RelRunDate relrun_date
,person_id  
,patient_id
,organization_id
,date_of_birth
,gender_concept_id
,ethnic_code_concept_id
,episode_of_care_id   
,regstatus_description   
,date_registered
,date_registered_end
,ods_code
,report_name   
,ccg_ods   
 
  FROM
  (
   SELECT 
      e.id AS episode_of_care_id
     ,e.organization_id
     ,e.patient_id
     ,e.person_id   
	 ,p.date_of_birth
	 ,p.gender_concept_id
	 ,p.ethnic_code_concept_id
     ,regs.description regstatus_description   
     ,e.date_registered
     ,e.date_registered_end	 
     ,ceg.ods_code
     ,ceg.report_name
	 ,ceg.ccg_ods
	 ,ROW_NUMBER() OVER (PARTITION BY p.person_id ORDER BY date_registered DESC) as rownum
    -- ,ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY date_registered DESC) as rownum


   FROM compass_gp.dbo.patient p
    INNER JOIN compass_gp.dbo.[episode_of_care] e ON e.patient_id = p.id -- 
    INNER JOIN [db_lookup].[gp].[regstatus] regs ON e.registration_status_concept_id = regs.dbid
    INNER JOIN [db_lookup].[gp].[regtype] regt ON e.registration_type_concept_id = regt.dbid
    INNER JOIN [db_lookup].[gp].[ceg_gppractices] ceg ON e.organization_id = ceg.organization_id
	INNER JOIN STRING_SPLIT(@CCG,',') ccg ON TRIM(ccg.value) = ceg.ccg_ods
    
   WHERE
     (
       e.date_registered <= @RelRunDate  -- registrations up to midnight on @RelRunDate
      AND 
      (
       e.date_registered_end IS NULL  -- registration has not ended
       OR 
       e.date_registered_end > @RelRunDate -- registration ended after @RelRunDate
      ) 
     )
    AND ceg.status = 'A'      -- Active organisations
    AND regt.code = 'R'       -- Reg Type = Regular
    AND 
		regs.active_reg = 1   -- Reg Status = a registered GP Links Status
		-- e.registration_status_concept_id between 1335286 and 1335290 -- alt lookup direct from episode of care
			/*Registered (1335286),
			Medical Record sent by FHSA (1335287),
			Record Received (1335288),
			Left Practice. Still Registered (1335289)
			Correctly Registered (1335290)*/
	AND (             
      p.date_of_death IS NULL -- patient registration has no record of patient having died 
      OR 
      p.date_of_death > @RelRunDate -- patient died after @RelRunDate (EMIS is, we believe more absolute and does not include this filter)
     )
)AS CurReg

  WHERE
   rownum = 1 -- latest registration



END
