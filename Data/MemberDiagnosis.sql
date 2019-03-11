/*


*/

select * from Member
select * from Diagnosis
select * from MemberDiagnosis
select * from DiagnosisCategoryMap
select * from DiagnosisCategory


select  
m.MemberID, m.FirstName, m.LastName,
d.DiagnosisID, d.DiagnosisDescription,
dc.DiagnosisCategoryID, dc.CategoryDescription, dc.CategoryScore
from Member m
LEFT JOIN MemberDiagnosis md on md.MemberID = m.MemberID
LEFT JOIN Diagnosis d ON d.DiagnosisID = md.DiagnosisID
LEFT JOIN DiagnosisCategoryMap dcm ON d.DiagnosisID = dcm.DiagnosisID
LEFT JOIN DiagnosisCategory dc ON dcm.DiagnosisCategoryID = dc.DiagnosisCategoryID


select  
m.MemberID,dc.DiagnosisCategoryID, d.DiagnosisID
from Member m
LEFT JOIN MemberDiagnosis md on md.MemberID = m.MemberID
LEFT JOIN Diagnosis d ON d.DiagnosisID = md.DiagnosisID
LEFT JOIN DiagnosisCategoryMap dcm ON d.DiagnosisID = dcm.DiagnosisID
LEFT JOIN DiagnosisCategory dc ON dcm.DiagnosisCategoryID = dc.DiagnosisCategoryID
Group BY m.MemberID, dc.DiagnosisCategoryID, d.DiagnosisID
order by m.MemberID



-- b. Most Severe Diagnosis ID and Description should be the diagnosis with the lowest Diagnosis ID for each Member/Category. 
select  
m.MemberID,dc.DiagnosisCategoryID, MIN(d.DiagnosisID )as 'MostSevereDiagnosisID'
from Member m
LEFT JOIN MemberDiagnosis md on md.MemberID = m.MemberID
LEFT JOIN Diagnosis d ON d.DiagnosisID = md.DiagnosisID
LEFT JOIN DiagnosisCategoryMap dcm ON d.DiagnosisID = dcm.DiagnosisID
LEFT JOIN DiagnosisCategory dc ON dcm.DiagnosisCategoryID = dc.DiagnosisCategoryID
Group BY m.MemberID, dc.DiagnosisCategoryID
order by m.MemberID


-- most severe cat 

select  
m.MemberID,min(dc.DiagnosisCategoryID) as 'MostSevereCategoryId'
from Member m
LEFT JOIN MemberDiagnosis md on md.MemberID = m.MemberID
LEFT JOIN Diagnosis d ON d.DiagnosisID = md.DiagnosisID
LEFT JOIN DiagnosisCategoryMap dcm ON d.DiagnosisID = dcm.DiagnosisID
LEFT JOIN DiagnosisCategory dc ON dcm.DiagnosisCategoryID = dc.DiagnosisCategoryID
Group BY m.MemberID
order by m.MemberID

SELECT MemberID, FirstName, LastName FROM Member WHERE ID = 









--work in progress

select 
M.MemberID, M.FirstName, M.LastName,
sd.MostSevereDiagnosisID, sd.DiagnosisDescription,
dc.DiagnosisCategoryID as 'CategoryID', dc.CategoryDescription, dc.CategoryScore

from Member m
LEFT JOIN (
	select  
	m.MemberID,dc.DiagnosisCategoryID, MIN(d.DiagnosisID )as 'MostSevereDiagnosisID', d.DiagnosisDescription
	from Member m
	LEFT JOIN MemberDiagnosis md on md.MemberID = m.MemberID
	LEFT JOIN Diagnosis d ON d.DiagnosisID = md.DiagnosisID
	LEFT JOIN DiagnosisCategoryMap dcm ON d.DiagnosisID = dcm.DiagnosisID
	LEFT JOIN DiagnosisCategory dc ON dcm.DiagnosisCategoryID = dc.DiagnosisCategoryID
	Group BY m.MemberID, dc.DiagnosisCategoryID, d.DiagnosisDescription
	) sd
ON sd.MemberID = m.MemberID
LEFT JOIN DiagnosisCategoryMap dcm ON sd.MostSevereDiagnosisID = dcm.DiagnosisID
LEFT JOIN DiagnosisCategory dc ON dcm.DiagnosisCategoryID = dc.DiagnosisCategoryID

LEFT JOIN (
	select  
	m.MemberID,min(dc.DiagnosisCategoryID) as 'MostSevereCategoryId', 1 as 'Is Most Server Category'
	from Member m
	LEFT JOIN MemberDiagnosis md on md.MemberID = m.MemberID
	LEFT JOIN Diagnosis d ON d.DiagnosisID = md.DiagnosisID
	LEFT JOIN DiagnosisCategoryMap dcm ON d.DiagnosisID = dcm.DiagnosisID
	LEFT JOIN DiagnosisCategory dc ON dcm.DiagnosisCategoryID = dc.DiagnosisCategoryID
	Group BY m.MemberID
	)sc
ON sc.MostSevereCategoryId = dc.DiagnosisCategoryID



--distinct


SELECT 
*
--m.MemberID, m.FirstName, m.LastName
FROM Member m
INNER JOIN (
	select 
		distinct
		m.MemberID,
		dm.DiagnosisCategoryID
	from Member m
	LEFT JOIN MemberDiagnosis md ON md.MemberID = m.MemberID
	LEFT JOIN DiagnosisCategoryMap dm ON dm.DiagnosisID = md.DiagnosisID
	LEFT JOIN DiagnosisCategory dc ON dc.DiagnosisCategoryID = dm.DiagnosisCategoryID
	)dd
ON dd.MemberID = m.MemberID

select 
*
from Member m
 JOIN 
	(
		select 
		m.MemberID, MIN(md.DiagnosisID) As 'MostSevereDiagnosis',  dm.DiagnosisCategoryID
		from Member m
		LEFT JOIN MemberDiagnosis md ON md.MemberID = m.MemberID
		LEFT JOIN DiagnosisCategoryMap dm ON dm.DiagnosisID = md.DiagnosisID
		GROUP BY m.MemberID, dm.DiagnosisCategoryID
	)msd
ON msd.MemberID = m.MemberID



	select 
		distinct
		m.MemberID,
		dm.DiagnosisCategoryID,
		msd.MostSevereDiagnosis
	from Member m
	LEFT JOIN MemberDiagnosis md ON md.MemberID = m.MemberID
	LEFT JOIN DiagnosisCategoryMap dm ON dm.DiagnosisID = md.DiagnosisID
	LEFT JOIN DiagnosisCategory dc ON dc.DiagnosisCategoryID = dm.DiagnosisCategoryID
left JOIN(
	select 
		m.MemberID, MIN(md.DiagnosisID) As 'MostSevereDiagnosis',  dm.DiagnosisCategoryID
		from Member m
		LEFT JOIN MemberDiagnosis md ON md.MemberID = m.MemberID
		LEFT JOIN DiagnosisCategoryMap dm ON dm.DiagnosisID = md.DiagnosisID
		GROUP BY m.MemberID, dm.DiagnosisCategoryID
)msd ON msd.MemberID = m.MemberID


	select 
		m.MemberID, MIN(md.DiagnosisID) As 'MostSevereDiagnosis',  dm.DiagnosisCategoryID
		
		from Member m
		LEFT JOIN MemberDiagnosis md ON md.MemberID = m.MemberID
		LEFT JOIN DiagnosisCategoryMap dm ON dm.DiagnosisID = md.DiagnosisID
		GROUP BY m.MemberID, dm.DiagnosisCategoryID, md.DiagnosisID
