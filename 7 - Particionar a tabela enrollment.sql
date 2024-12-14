-- A tabela enrollment pode ser particionada por tenant_id, dado que é o critério de segmentação mais lógico em um sistema multi-tenant

-- Recriar a tabela enrollment como particionada
DROP TABLE IF EXISTS enrollment CASCADE;

CREATE TABLE enrollment (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER NOT NULL,
    institution_id INTEGER,
    person_id INTEGER NOT NULL,
    enrollment_date DATE,
    status VARCHAR(20),
    is_deleted BOOLEAN DEFAULT FALSE
) PARTITION BY LIST (tenant_id);

-- Criar partições por tenant_id.

CREATE TABLE enrollment_tenant_1 PARTITION OF enrollment FOR VALUES IN (1);
CREATE TABLE enrollment_tenant_2 PARTITION OF enrollment FOR VALUES IN (2);

-- Continuar para outros tenants conforme necessário
