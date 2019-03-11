select 
m.MemberID, 
m.FirstName, 
m.LastName, 
msd.MostSevereDiagnosis, 
d.DiagnosisDescription,
c.DiagnosisCategoryID as 'CategoryID',
c.CategoryDescription,
c.CategoryScore,
coalesce(msc.MostSevereCategory,1) as 'IsMostSevereCategory'
From Member m
LEFT JOIN 
	(
		select
		md.MemberID, MIN(md.DiagnosisID) As 'MostSevereDiagnosis',  dcm.DiagnosisCategoryID
		from MemberDiagnosis md
		LEFT JOIN DiagnosisCategoryMap dcm ON dcm.DiagnosisID = md.DiagnosisID
		GROUP BY md.MemberID, dcm.DiagnosisCategoryID
	)msd
ON msd.MemberID = m.MemberID
LEFT JOIN
	(
		Select
		md.MemberID, dm.DiagnosisID, dm.DiagnosisCategoryID, coalesce(msc.MostSevereCategory, 0) as 'MostSevereCategory'
		from MemberDiagnosis md
		LEFT JOIN DiagnosisCategoryMap dm ON dm.DiagnosisID = md.DiagnosisID
		LEFT JOIN (
			select 
			md.MemberID, min(dm.DiagnosisCategoryID) as 'MostSevereCategoryId', 1 as 'MostSevereCategory'
			From MemberDiagnosis md 
			LEFT JOIN DiagnosisCategoryMap dm ON dm.DiagnosisID = md.DiagnosisID
			GROUP BY md.MemberID
			)msc
		ON msc.MemberID = md.MemberID and dm.DiagnosisCategoryID = msc.MostSevereCategoryId
	)msc
ON msc.MemberID = m.MemberID and msc.DiagnosisID = msd.MostSevereDiagnosis	
LEFT JOIN Diagnosis d ON msd.MostSevereDiagnosis = d.DiagnosisID
LEFT JOIN DiagnosisCategory c ON c.DiagnosisCategoryID = msc.DiagnosisCategoryID