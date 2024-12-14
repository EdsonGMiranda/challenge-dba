-- Tabela tenant
ALTER TABLE tenant
ADD CONSTRAINT pk_tenant PRIMARY KEY (id);

-- Tabela person
ALTER TABLE person
ADD CONSTRAINT pk_person PRIMARY KEY (id);

-- Tabela institution
ALTER TABLE institution
ADD CONSTRAINT pk_institution PRIMARY KEY (id),
ADD CONSTRAINT fk_institution_tenant FOREIGN KEY (tenant_id) REFERENCES tenant(id);

-- Tabela course
ALTER TABLE course
ADD CONSTRAINT pk_course PRIMARY KEY (id),
ADD CONSTRAINT fk_course_tenant FOREIGN KEY (tenant_id) REFERENCES tenant(id),
ADD CONSTRAINT fk_course_institution FOREIGN KEY (institution_id) REFERENCES institution(id);

-- Tabela enrollment
ALTER TABLE enrollment
ADD CONSTRAINT pk_enrollment PRIMARY KEY (id),
ADD CONSTRAINT fk_enrollment_tenant FOREIGN KEY (tenant_id) REFERENCES tenant(id),
ADD CONSTRAINT fk_enrollment_institution FOREIGN KEY (institution_id) REFERENCES institution(id),
ADD CONSTRAINT fk_enrollment_person FOREIGN KEY (person_id) REFERENCES person(id);
