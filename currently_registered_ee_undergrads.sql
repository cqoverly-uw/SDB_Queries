USE UWSDBDataStore;
GO

DECLARE @CURRENT_REG_YEAR SMALLINT;
DECLARE @CURRENT_REG_QTR TINYINT;
SET @CURRENT_REG_YEAR = (
	SELECT gl_regis_year
	FROM sec.sdbdb01
);
SET @CURRENT_REG_QTR = (
	SELECT gl_regis_qtr
	FROM sec.sdbdb01
);

SELECT DISTINCT
	s1.student_no,
	s1.student_name_lowc,
	a.e_mail_ucs,
	s1.s1_gender,
	s1.system_key,
	s1.spcl_program,
	s1.spp_qtrs_used,
	CASE
		WHEN s1.tot_graded_attmp = 0
		THEN 0
		ELSE s1.tot_grade_points/s1.tot_graded_attmp
	END AS 'CumGPA',
	CONCAT(
		CAST(di.deg_earned_yr AS CHAR(4)),
		'-',
		CAST(di.deg_earned_qtr AS CHAR(1))
	) AS 'grad_app',
	s1.ncr_code




FROM sec.student_1 s1
INNER JOIN sec.student_1_college_major cm
ON s1.system_key = cm.system_key
INNER JOIN .sec.student_2 s2
ON s1.system_key = s2.system_key
LEFT JOIN sec.addresses a
ON s1.system_key = a.system_key
LEFT JOIN sec.student_2_uw_degree_info di
ON s1.system_key = di.system_key


WHERE cm.major_abbr = 'E E'
AND s1.last_yr_enrolled = @CURRENT_REG_YEAR
AND s1.last_qtr_enrolled = @CURRENT_REG_QTR
AND (s1.class BETWEEN 1 AND 6)
AND cm.deg_level = 1 -- Level 1 is undergad
AND cm.deg_type = 6 -- Currently, all undergrad EE degrees end in 6. The new ECE degree may have a different number.

ORDER BY s1.student_name_lowc
;