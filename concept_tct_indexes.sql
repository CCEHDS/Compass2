/*
NOTE : Commands take up to 1min to run.  Best to run seperately
*/

USE [db_lookup]
GO

/****** Object:  Index [PK_concept_tct_source]    Script Date: 31/10/2019 12:00:18 ******/
ALTER TABLE [im].[concept_tct] ADD  CONSTRAINT [PK_concept_tct_source] PRIMARY KEY CLUSTERED 
(
	[source] ASC,
	[property] ASC,
	[target] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [concept_tct_property_level_idx]    Script Date: 31/10/2019 12:00:39 ******/
CREATE NONCLUSTERED INDEX [concept_tct_property_level_idx] ON [im].[concept_tct]
(
	[property] ASC,
	[level] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [concept_tct_property_target_idx]    Script Date: 31/10/2019 12:00:47 ******/
CREATE NONCLUSTERED INDEX [concept_tct_property_target_idx] ON [im].[concept_tct]
(
	[property] ASC,
	[target] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [concept_tct_source_property_idx]    Script Date: 31/10/2019 12:00:56 ******/
CREATE NONCLUSTERED INDEX [concept_tct_source_property_idx] ON [im].[concept_tct]
(
	[source] ASC,
	[property] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO





