-- Garantir a unicidade de person_id por tenant e institution
ALTER TABLE enrollment
ADD CONSTRAINT uq_enrollment UNIQUE (tenant_id, institution_id, person_id);
