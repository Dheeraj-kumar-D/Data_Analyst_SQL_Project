-- Create parent tables first
CREATE TABLE company (
    company_id NUMBER PRIMARY KEY,
    name VARCHAR2(4000),
    link VARCHAR2(4000),
    link_google VARCHAR2(4000),
    thumbnail VARCHAR2(4000)
);

CREATE TABLE skills (
    skill_id NUMBER PRIMARY KEY,
    skills VARCHAR2(4000),
    type VARCHAR2(100)
);

CREATE TABLE job_postings (
    job_id NUMBER PRIMARY KEY,
    company_id NUMBER,
    job_title_short VARCHAR2(255),
    job_title VARCHAR2(1000),
    job_location VARCHAR2(255),
    job_via VARCHAR2(255),
    job_schedule_type VARCHAR2(255),
    job_work_from_home CHAR(5),  -- Changed to CHAR(5)
    search_location VARCHAR2(255),
    job_posted_date DATE,
    job_no_degree_mention CHAR(5), -- Changed to CHAR(5)
    job_health_insurance CHAR(5), -- Changed to CHAR(5)
    job_country VARCHAR2(100),
    salary_rate VARCHAR2(100),    -- Keep as VARCHAR2, but use CHECK
    salary_year_avg DECIMAL(15, 2),
    salary_hour_avg NUMBER,
    CONSTRAINT fk_company FOREIGN KEY (company_id) REFERENCES company (company_id),
    CONSTRAINT chk_salary_rate CHECK (salary_rate IN ('hour', 'year', 'month', NULL)) -- Added CHECK constraint for salary_rate
);

CREATE TABLE skills_job (
    job_id NUMBER,
    skill_id NUMBER,
    PRIMARY KEY (job_id, skill_id),
    CONSTRAINT fk_job FOREIGN KEY (job_id) REFERENCES job_postings (job_id),
    CONSTRAINT fk_skill FOREIGN KEY (skill_id) REFERENCES skills (skill_id)
);

