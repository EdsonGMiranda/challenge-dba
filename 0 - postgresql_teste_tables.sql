CREATE TABLE tenant (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    description VARCHAR(255)
);

CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    birth_date DATE,
    metadata JSONB
);

CREATE TABLE institution (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER REFERENCES tenant(id),
    name VARCHAR(100),
    location VARCHAR(100),
    details JSONB
);

CREATE TABLE course (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER REFERENCES tenant(id),
    institution_id INTEGER REFERENCES institution(id),
    name VARCHAR(100),
    duration INTEGER,
    details JSONB
);

CREATE TABLE enrollment (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER REFERENCES tenant(id),
    institution_id INTEGER REFERENCES institution(id),
    person_id INTEGER REFERENCES person(id),
    enrollment_date DATE,
    status VARCHAR(20),
    CONSTRAINT unique_enrollment UNIQUE (tenant_id, institution_id, person_id)  -- Garantindo que uma matrícula por pessoa por curso/tenant
);