-- implementando exclusão lógica, adicionando uma coluna is_deleted e alterando as consultas para considerar apenas registros válidos

ALTER TABLE enrollment
ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;

-- Índice para exclusão lógica
CREATE INDEX idx_enrollment_is_deleted ON enrollment (is_deleted);
