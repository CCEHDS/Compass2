USE [db_lookup]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [PK_concept_dbid]    Script Date: 31/10/2019 11:50:46 ******/
ALTER TABLE [im].[concept] ADD  CONSTRAINT [PK_concept_dbid] PRIMARY KEY CLUSTERED 
(
	[dbid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO?

/****** Object:  Index [concept_scheme_code_idx]    Script Date: 31/10/2019 11:48:01 ******/
CREATE NONCLUSTERED INDEX [concept_scheme_code_idx] ON [im].[concept]
(
	[code] ASC,
	[scheme] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [concept_id_uq]    Script Date: 31/10/2019 11:48:33 ******/
CREATE UNIQUE NONCLUSTERED INDEX [concept_id_uq] ON [im].[concept]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [concept_draft]    Script Date: 31/10/2019 11:48:52 ******/
CREATE NONCLUSTERED INDEX [concept_draft] ON [im].[concept]
(
	[draft] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/****** Object:  Index [concept$concept_id_uq]    Script Date: 31/10/2019 11:49:01 ******/
ALTER TABLE [im].[concept] ADD  CONSTRAINT [concept$concept_id_uq] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



