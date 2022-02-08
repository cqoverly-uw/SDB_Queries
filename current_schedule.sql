USE UWSDBDataStore;
GO


SELECT 
	s1.student_no,
	s1.student_name_lowc,
	rc.crs_curric_abbr,
	rc.crs_number,
	rc.grade

FROM sec.registration_courses rc
INNER JOIN sec.student_1 s1
ON rc.system_key = s1.system_key
INNER JOIN sec.student_1_college_major cm
ON rc.system_key = cm.system_key

WHERE rc.request_status IN ('A', 'C', 'R')
AND LEN(rc.crs_section_id) = 1
AND rc.regis_qtr = ? --Enter current quarter here.
AND rc.regis_yr = ?  --Enter current year here.
AND s1.student_no = ?  --Enter student number here.