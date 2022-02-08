USE UWSDBDataStore;
GO

SELECT 
	s1.student_no,
	s1.student_name_lowc,
	tcm.tran_yr,
	CASE tcm.tran_qtr
		WHEN 1 THEN 'Win'
		WHEN 2 THEN 'Spr'
		WHEN 3 THEN 'Sum'
		WHEN 4 THEN 'Aut'
	END tran_qtr,
	tcm.tran_major_abbr,
	t.num_courses,
	t.qtr_nongrd_earned,
	t.qtr_graded_attmp,
	t.qtr_grade_points,
	CASE 
		WHEN t.qtr_graded_attmp = 0 THEN 0
		ELSE CAST(t.qtr_grade_points/t.qtr_graded_attmp as DECIMAL(4,2))
	END qtr_gpa


FROM sec.student_1 s1 
INNER JOIN sec.transcript_tran_col_major tcm
ON s1.system_key = tcm.system_key
INNER JOIN sec.transcript t
ON (s1.system_key = t.system_key
	AND t.tran_yr = tcm.tran_yr
	AND t.tran_qtr = tcm.tran_qtr
)

WHERE s1.student_no = 1862069

ORDER BY tcm.tran_yr, tcm.tran_qtr;