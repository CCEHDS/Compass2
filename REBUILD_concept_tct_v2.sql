USE db_lookup;
GO

 DROP TABLE IF EXISTS im.concept_tct;
 GO

 CREATE TABLE im.concept_tct (
   source     INT NOT NULL,
   property   INT NOT NULL,
   level      INT NOT NULL,
   target     INT NOT NULL
 );
GO

ALTER TABLE im.concept_tct ADD PRIMARY KEY (source, property, target);
CREATE INDEX concept_tct_source_property_idx ON im.concept_tct (source, property);
CREATE INDEX concept_tct_property_level_idx ON im.concept_tct (property, level);
CREATE INDEX concept_tct_property_target_idx ON im.concept_tct (property, target);
GO

WITH concept_tct_path AS
 (SELECT 
         cpo.dbid    source,
         cpo.value   target,
         0           level,
         property
  FROM im.concept_property_object cpo
  WHERE cpo.property = 92842
  UNION ALL
  SELECT cp.source,
         o.value     target,
         cp.level+1  level,
         o.property
  FROM im.concept_property_object o
  JOIN concept_tct_path cp ON o.dbid= cp.target AND o.property = cp.property
	WHERE cp.property = 92842
  )
INSERT INTO im.concept_tct 
SELECT  
       source,
       property,
       MAX(level) level,
       target
FROM concept_tct_path c
GROUP BY source, property, target
-- OPTION (MAXRECURSION 0)
;
GO
