SELECT 
    p.id AS person_id,
    p.name AS person_name,
    p.metadata
FROM 
    enrollment e
JOIN person p ON e.person_id = p.id
WHERE 
    e.tenant_id = :tenant_id
    AND e.institution_id = :institution_id
    AND e.course_id = :course_id
    AND e.is_deleted = FALSE
ORDER BY 
    p.name ASC;
