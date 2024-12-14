SELECT 
    c.name AS course_name,
    COUNT(e.id) AS total_enrollments
FROM 
    enrollment e
JOIN course c ON e.tenant_id = c.tenant_id AND e.institution_id = c.institution_id AND e.course_id = c.id
JOIN person p ON e.person_id = p.id
WHERE 
    e.tenant_id = :tenant_id
    AND e.institution_id = :institution_id
    AND p.metadata @> :search_metadata
    AND e.is_deleted = FALSE
GROUP BY 
    c.name
ORDER BY 
    total_enrollments DESC;
