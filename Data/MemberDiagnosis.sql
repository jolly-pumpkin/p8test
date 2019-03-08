/*


*/

select * from Member

select  
	d.DiagnosisID, dc.CategoryDescription, dc.CategoryScore, d.DiagnosisDescription
from DiagnosisCategory dc
JOIN DiagnosisCategoryMap dcm ON dc.DiagnosisCategoryID = dcm.DiagnosisCategoryID
JOIN Diagnosis d ON dcm.DiagnosisID = d.DiagnosisID

select * from MemberDiagnosis

select * from Member m
JOIN MemberDiagnosis md on md.MemberID = m.MemberID


select * from Diagnosis
Select * from DiagnosisCategory




Select 
	m.MemberID, m.FirstName, m.LastName,
	d.DiagnosisID, d.DiagnosisDescription,
	dc.DiagnosisCategoryID, dc.CategoryDescription, dc.CategoryScore
FROM Member m
JOIN MemberDiagnosis md ON m.MemberID = md.MemberID
JOIN Diagnosis d ON md.DiagnosisID = d.DiagnosisID
JOIN DiagnosisCategoryMap dcm ON d.DiagnosisID = dcm.DiagnosisID
JOIN DiagnosisCategory dc ON dcm.DiagnosisCategoryID = dc.DiagnosisCategoryID
ORDER BY M.MemberID

select 
* 
FROM Diagnosis d 
JOIN DiagnosisCategoryMap dcm ON d.DiagnosisID = dcm.DiagnosisID
JOIN DiagnosisCategory dc ON dcm.DiagnosisCategoryID = dc.DiagnosisCategoryID






-- b. Most Severe Diagnosis ID and Description should be the diagnosis with the lowest Diagnosis ID for each Member/Category. 
select  
	min(d.DiagnosisID) as 'Most Severe Diagnosis ID',
	dc.DiagnosisCategoryID
	from Diagnosis d
JOIN DiagnosisCategoryMap dcm ON dcm.DiagnosisID = d.DiagnosisID
JOIN DiagnosisCategory dc ON dc.DiagnosisCategoryID = dcm.DiagnosisCategoryID
group by dc.DiagnosisCategoryID




Select 
	m.MemberID, m.FirstName, m.LastName,
	d.DiagnosisID, d.DiagnosisDescription,
	dc.DiagnosisCategoryID, dc.CategoryDescription, dc.CategoryScore
FROM Member m
JOIN MemberDiagnosis md ON m.MemberID = md.MemberID
JOIN Diagnosis d ON md.DiagnosisID = d.DiagnosisID
JOIN DiagnosisCategoryMap dcm ON d.DiagnosisID = dcm.DiagnosisID
JOIN DiagnosisCategory dc ON dcm.DiagnosisCategoryID = dc.DiagnosisCategoryID
ORDER BY M.MemberID


select  
	min(d.DiagnosisID) as 'Most Severe Diagnosis ID',
	dc.DiagnosisCategoryID
	from Diagnosis d
JOIN DiagnosisCategoryMap dcm ON dcm.DiagnosisID = d.DiagnosisID
JOIN DiagnosisCategory dc ON dc.DiagnosisCategoryID = dcm.DiagnosisCategoryID
group by dc.DiagnosisCategoryID
