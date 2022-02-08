USE UWSDBDataStore;
GO

DECLARE @DEPT CHAR(6);
DECLARE @CRS_NO SMALLINT;
SET @DEPT = 'E E'
SET @CRS_NO = 548;

SELECT 
	ct.department_abbrev,
	ct.course_number,
	ct.min_qtr_credits,
	ct.max_credits,
	CASE ct.credit_control
		WHEN 0 THEN 'Zero Cr'
		WHEN 1 THEN 'Fixed Cr'
		WHEN 2 THEN 'Var. Cr.'
		ELSE 'Open Cr.'
	END credit_control,
	CASE ct.grading_system
		WHEN 0 THEN 'Std. or CR/NC'
		WHEN 5 THEN 'CR/NC'
	END grading_system,
	ct.course_title short_title,
	ct.long_course_title long_title,
	CASE ct.resp_course_no
		WHEN 0 THEN 'NA'
		ELSE CONCAT(ct.resp_curric_abbr, resp_course_no)
	END resp_course,
	ct.diversity_crs,
	ct.indiv_society,
	ct.vis_lit_perf_arts,
	ct.english_comp,
	ct.writing_crs


FROM sec.sr_course_titles ct




WHERE ct.last_eff_yr = 9999  -- '9999' represents a course that is still active. 
AND ct.department_abbrev = @DEPT
AND ct.course_number = @CRS_NO
AND ct.course_branch = 0 -- '0' represents the Seattle campus

;