SELECT 
T.dbid
,T.code
,T.name
,T.scheme
,cpt.dbid
,cpt.code
,T.level
,cpt.name
,cpt.scheme
FROM
(SELECT [dbid]
      ,[id]
      ,[name]
      ,[scheme]
      ,[code]
	  ,tct.[level]
   	  ,tct.target
  FROM [db_lookup].[im].[concept] c
LEFT JOIN [db_lookup].[im].concept_tct tct ON c.dbid=tct.source
WHERE c.code = '49436004'
) AS T
LEFT JOIN [db_lookup].[im].[concept] cpt ON cpt.dbid=T.target
ORDER BY T.level



