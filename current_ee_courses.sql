USE UWSDBDataStore;
GO

SELECT * 

FROM sec.sr_course_titles ct

WHERE ct.department_abbrev = 'E E'
AND ct.last_eff_yr = 9999