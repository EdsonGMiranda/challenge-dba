Abaixo uma melhoria proposta seria usar a versão 16 do Postgresql ou superior para obter as sequintes melhorias:

1 - Melhorias em Particionamento
A partir do PostgreSQL 16, há suporte melhorado para particionamento, como:

Índices globais em tabelas particionadas.
Otimizações para consultas em tabelas com muitas partições.

Com os índices globais, é possível criar um índice que cubra todas as partições. Isso pode ser útil para consultas que filtram por person_id, por exemplo.

CREATE TABLE enrollment (
    id SERIAL,
    tenant_id INTEGER REFERENCES tenant(id),
    institution_id INTEGER REFERENCES institution(id),
    person_id INTEGER REFERENCES person(id),
    enrollment_date DATE,
    status VARCHAR(20),
    deleted_at TIMESTAMP NULL,
    PRIMARY KEY (id, tenant_id)
) PARTITION BY LIST (tenant_id);

-- Partições específicas
CREATE TABLE enrollment_1 PARTITION OF enrollment FOR VALUES IN (1);
CREATE TABLE enrollment_2 PARTITION OF enrollment FOR VALUES IN (2);

-- Índice global para todas as partições
CREATE INDEX global_idx_person ON enrollment (person_id);


2 - Melhorias em Consultas JSONB

A versão 16 trouxe melhorias de performance em operadores para JSONB, incluindo:

Uso mais eficiente do índice GIN.
Suporte para o operador @> em consultas indexadas, reduzindo tempos de busca.
Consulta Full-Text Search Otimizada em metadata
Podemos usar o operador @> para melhorar a busca em campos JSONB.

-- Índice GIN para otimização
CREATE INDEX idx_person_metadata_gin ON person USING gin (metadata jsonb_path_ops);

-- Consulta com operador @>
SELECT c.id AS course_id, c.name AS course_name, COUNT(e.id) AS enrollment_count
FROM course c
JOIN enrollment e ON e.course_id = c.id
JOIN person p ON p.id = e.person_id
WHERE c.tenant_id = <tenant_id>
  AND c.institution_id = <institution_id>
  AND p.metadata @> '{"search_key": "search_value"}'  -- Busca eficiente no JSONB
  AND (e.deleted_at IS NULL OR e.deleted_at > NOW())
GROUP BY c.id;


3. Consultas Paralelas Melhoradas
O PostgreSQL 16 aprimorou o paralelismo em consultas, permitindo processamento mais rápido em grandes volumes de dados.

SELECT p.id AS student_id, p.name AS student_name
FROM enrollment e
JOIN person p ON p.id = e.person_id
WHERE e.tenant_id = <tenant_id>
  AND e.institution_id = <institution_id>
  AND e.course_id = <course_id>
  AND (e.deleted_at IS NULL OR e.deleted_at > NOW())
ORDER BY p.name
LIMIT 1000;  -- Aplicar limite para controle de paginação

A adição de índices nos campos de filtro (tenant_id, institution_id, course_id) garante que o PostgreSQL use o paralelismo quando possível.



5. Gerenciamento de Dados Não Estruturados
O PostgreSQL 16 melhorou o suporte a consultas em JSONB, permitindo maior flexibilidade e performance. O uso de índices do tipo jsonb_path_ops e operadores otimizados, como @> e jsonpath, facilita consultas avançadas.

SELECT p.id, p.name
FROM person p
WHERE p.metadata @@ '$.search_key == "search_value"';


