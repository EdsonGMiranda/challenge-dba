-- Índice para buscas no campo JSONB em 'person'
CREATE INDEX idx_person_metadata ON person USING gin (metadata);

-- Índice para buscas no campo JSONB em 'institution'
CREATE INDEX idx_institution_details ON institution USING gin (details);

-- Índice para buscas no campo JSONB em 'course'
CREATE INDEX idx_course_details ON course USING gin (details);

-- Índice composto para consultas frequentes em 'enrollment'

CREATE INDEX idx_enrollment_person ON enrollment (tenant_id, person_id);


-- Índice para melhorar a busca por tenant_id e institution_id em enrollment
CREATE INDEX idx_enrollment_tenant_institution ON enrollment (tenant_id, institution_id);


-- Índice para melhorar consultas em institution e tenant
CREATE INDEX idx_institution_tenant ON institution (tenant_id);
