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











--work in progress

select 
M.MemberID, M.FirstName, M.LastName,
sd.MostSevereDiagnosisID 
from Member m
LEFT JOIN (
	select  
	m.MemberID,dc.DiagnosisCategoryID, MIN(d.DiagnosisID )as 'MostSevereDiagnosisID'
	from Member m
	LEFT JOIN MemberDiagnosis md on md.MemberID = m.MemberID
	LEFT JOIN Diagnosis d ON d.DiagnosisID = md.DiagnosisID
	LEFT JOIN DiagnosisCategoryMap dcm ON d.DiagnosisID = dcm.DiagnosisID
	LEFT JOIN DiagnosisCategory dc ON dcm.DiagnosisCategoryID = dc.DiagnosisCategoryID
	Group BY m.MemberID, dc.DiagnosisCategoryID
	) sd
ON sd.MemberID = m.MemberID


select  
m.MemberID,min(dc.DiagnosisCategoryID) as 'MostSevereCategoryId'
from Member m
LEFT JOIN MemberDiagnosis md on md.MemberID = m.MemberID
LEFT JOIN Diagnosis d ON d.DiagnosisID = md.DiagnosisID
LEFT JOIN DiagnosisCategoryMap dcm ON d.DiagnosisID = dcm.DiagnosisID
LEFT JOIN DiagnosisCategory dc ON dcm.DiagnosisCategoryID = dc.DiagnosisCategoryID
Group BY m.MemberID
order by m.MemberID