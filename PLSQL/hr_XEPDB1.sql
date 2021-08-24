-- Resumão
BEGIN
    CASE vdepartment_id
    WHEN 80
    THEN
        vpercentual := 10;
    WHEN 60
    THEN
        vpercentual := 5;
    WHEN 10
    THEN
        vpercentual := 50;
    ELSE
        vpercentual := 1;
    END CASE;
    
BEGIN
    CASE
    WHEN vdepartment_id = 80
    THEN
        vpercentual := 10;
    WHEN vdepartment_id = 60
    THEN
        vpercentual := 5;
    WHEN vdepartment_id = 10
    THEN
        vpercentual := 5;
    ELSE
        vpercentual := 50;
    END CASE;
    
-- LOOPs

-- Tipo 1
LOOP
dbms_output.put_line (vnumero);
EXIT WHEN vnumero = vlimite;
vnumero := vnumero + 1;
END LOOP;

-- Tipo 2
FOR i IN vinicio..vfim LOOP
dmbs_output.put_line (i);
END LOOP;

-- Tipo 3
WHILE vnumero <= vlimite LOOP
dbms_output.put_line (vnumero);
vnumero := vnumero + 1;
END LOOP;

-- Loop aninhado
<<LOOP 1>>
FOR i IN 1..8 LOOP
    dbms_output.put_line (i);
    <<LOOP 2>>
    FOR j IN 1..9 LOOP
    dbms_output.put_line (j);
    dbms_output.put_line (vtotal);
    vtotal := vtotal + 1;
    END LOOP;
END LOOP;

-- Tipos compostos
DECLARE -- id, first_name, last_name, email, phone_number
TYPE employee_record_type IS RECORD
    (employee_id    employees.employee_id%TYPE,
    first_name      employees.first_name%TYPE,
    last_name       employees.last_name%TYPE,
    email       employees.email%TYPE,
    phone_number    employees.phone_number%TYPE);
    employee_record employee_record_type;
BEGIN
    select employee_id, first_name, last_name, email, phone_number
    INTO employee_record
    from employees
    where employee_id = vemployee_id
    
DECLARE
    employee_record employees%ROWTYPE;

select *
into employee_record
from employees
where employee_id = vemployee_id;

-- Collections (vetores) - associative array
DECLARE
    TYPE number_table_type IS TABLE OF NUMBER(2)
    INDEX BY BINARY_INTEGER; -- index numérico = binary_integer, index de caracteres = varchar2.
    number_table    number_table_type;
BEGIN
    For i IN 1..10 LOOP
    number_table(i) := i + 1;
    dbms_output.put_line (i, number_table(i));
    END LOOP;

-- Bulk Collection
DECLARE
    TYPE employee_table_type IS TABLE OF employees%ROWTYPE
    INDEX BY BINARY_INTEGER;
    employee_table  employee_table_type;
BEGIN
    SELECT *
    BULK COLLECT INTO employee_table
    FROM employees;
    
    FOR i IN employee_table.first..employee_table.last LOOP
    DBMS_OUTPUT.PUT_LINE (employee_table(i).first_name || employee_table(i).last_name);
    END loop;
    
-- Nested Table
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
TYPE number_nested_table_type IS TABLE OF INTEGER(2);
number_table    number_nested_table_type := number_nested_table_type();
BEGIN
    FOR i IN 1..10 LOOP
    number_table.extend;
    number_table(i) := i + 1;
    END LOOP;
    
    FOR i IN 1..10 LOOP
    DBMS_OUTPUT.PUT_LINE ('Índice: ' || i || ' Valor: ' || number_table(i));
    END LOOP;
END;

-- VARYING ARRAY ou VARRAY apenas para números positivos, precisa ser inicializado e possui um tamanho fixo (igual o char)
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    TYPE number_table_type IS VARYING ARRAY (10) OF INTEGER(2);
    number_table    number_table_type := number_table_type();
BEGIN
    FOR i IN 1..10 LOOP
        number_table.extend;
        number_table(i) := i + 1;
    END LOOP;
    
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE ('Índice = ' || i || ' Valor = ' || TO_CHAR(number_table(i)));
    END LOOP;
END;

-- BULK COLLECTION
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    TYPE employees_table_type IS VARYING ARRAY (500) OF employees%ROWTYPE;
    employees_table employees_table_type := employees_table_type();
BEGIN
    SELECT *
    BULK COLLECT INTO employees_table
    FROM employees;
    
    FOR i IN employees_table.first..employees_table.last LOOP
        DBMS_OUTPUT.PUT_LINE (  'Nome: ' || employees_table(i).first_name ||
                                ' ' || employees_table(i).last_name ||
                                ' Celular: ' || employees_table(i).phone_number);
    END LOOP;
END;
                                
-- Cursor Explícito

-- Loop Básico
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor IS
    SELECT *
    FROM employees;
    
    employee_record employees%ROWTYPE;
BEGIN
    OPEN employee_cursor;
   
    LOOP
        FETCH employee_cursor
        INTO employee_record;
        
        EXIT WHEN employee_cursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE ('Nome: ' || employee_record.first_name ||
                                ' Sobrenome: ' || employee_record.last_name ||
                                ' Salário: ' || LTRIM(TO_CHAR(employee_record.salary, '999G999D99')));
        END LOOP;
    CLOSE employee_cursor;
END;
                                
-- Loop Com While
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor IS
    SELECT *
    FROM employees;
    employee_record employees%ROWTYPE;
BEGIN
    OPEN employee_cursor;
    FETCH employee_cursor
        INTO employee_record;
    WHILE employee_cursor%found LOOP
        DBMS_OUTPUT.PUT_LINE ('Nome: ' || employee_record.first_name ||
                            ', Sobrenome: ' || employee_record.last_name ||
                            ', Salário: ' || LTRIM(TO_CHAR(employee_record.salary, 'L99G999G999D99')));
    FETCH employee_cursor
        INTO employee_record;
    END LOOP;
    CLOSE employee_cursor;
END;

-- Loop com FOR
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor IS
    SELECT *
    FROM employees;

BEGIN
    FOR employee_record IN employee_cursor LOOP
        DBMS_OUTPUT.PUT_LINE ('Nome: ' || employee_record.first_name ||
                            ', Sobrenome: ' || employee_record.last_name ||
                            ', Salário: ' || LTRIM(TO_CHAR(employee_record.salary, 'L99G999G999D99')));
    END LOOP;
END;

-- Uma maneira com sub-consulta, mais sucinta ainda
SET SERVEROUTPUT ON
SET VERIFY OFF
BEGIN
    FOR employee_record IN (SELECT * FROM employees) LOOP
        DBMS_OUTPUT.PUT_LINE ('Nome: ' || employee_record.first_name ||
                            ', Sobrenome: ' || employee_record.last_name ||
                            ', Salário: ' || LTRIM(TO_CHAR(employee_record.salary, 'L99G999G999D99')));
    END LOOP;
END;

-- Cursor com parâmetros LOOP FOR
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor (pdepartment_id  employees.department_id%TYPE,
                            pjob_id         employees.job_id%TYPE) 
    IS
    SELECT *
    FROM employees
    WHERE department_id = pdepartment_id AND job_id = pjob_id;
BEGIN
    FOR employee_record IN employee_cursor (60, 'IT_PROG')
    LOOP
        DBMS_OUTPUT.PUT_LINE    (employee_record.employee_id || ' - ' ||
                                employee_record.first_name || ' - ' ||
                                employee_record.last_name || ' - ' ||
                                employee_record.department_id || ' - ' ||
                                employee_record.job_id || ' - ' ||
                                employee_record.phone_number || ' - ' ||
                                LTRIM(TO_CHAR(employee_record.salary, 'L99G999G999G999D99')));
    END LOOP;
END;

-- Cursor com parâmetros LOOP WHILE
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor (pdepartment_id NUMBER, pjob_id VARCHAR2) IS
    SELECT *
    FROM employees;
    employee_record employees%ROWTYPE;
BEGIN
    OPEN employee_cursor (60, 'IT_PROG'); -- Passar os parâmetros
    FETCH employee_cursor
        INTO employee_record;
    WHILE employee_cursor%found LOOP
        DBMS_OUTPUT.PUT_LINE    (employee_record.employee_id || ' - ' ||
                                employee_record.first_name || ' - ' ||
                                employee_record.last_name || ' - ' ||
                                employee_record.department_id || ' - ' ||
                                employee_record.job_id || ' - ' ||
                                employee_record.phone_number || ' - ' ||
                                LTRIM(TO_CHAR(employee_record.salary, 'L99G999G999G999D99')));
        FETCH employee_cursor
        INTO employee_record;
    END LOOP;
    CLOSE employee_cursor;
END;

-- Cursor com parâmetros com LOOP básico
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor (pdepartment_id employees.department_id%TYPE, pjob_id employees.job_id%TYPE) IS
    SELECT *
    FROM employees
    WHERE department_id = pdepartment_id AND job_id = pjob_id;
    employee_record employees%ROWTYPE;
BEGIN
    OPEN employee_cursor (60, 'IT_PROG');
    
    LOOP
        FETCH employee_cursor
        INTO employee_record;
        EXIT WHEN employee_cursor%notfound;
        DBMS_OUTPUT.PUT_LINE    (employee_record.employee_id || ' - ' ||
                                    employee_record.first_name || ' - ' ||
                                    employee_record.last_name || ' - ' ||
                                    employee_record.department_id || ' - ' ||
                                    employee_record.job_id || ' - ' ||
                                    employee_record.phone_number || ' - ' ||
                                    LTRIM(TO_CHAR(employee_record.salary, 'L99G999G999G999D99')));
    END LOOP;
    CLOSE employee_cursor;
END;

-- Cursor Explícito com FOR UPDATE
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor (pjob_id VARCHAR2) IS
    SELECT *
    FROM employees
    WHERE job_id = pjob_id
    FOR UPDATE;
BEGIN
    FOR employee_record IN employee_cursor ('AD_VP')
    LOOP
        UPDATE employees
        SET salary = salary + 0
        WHERE CURRENT OF employee_cursor;
    END LOOP;
END;

-- Tratamento de Exceções EXCEPTION
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'ID não encontrado');
    WHEN OTHERS
    THEN
        RAISE_APPLICATION_ERROR (-20002, 'Erro Oracle: ' || SQLCODE || SQLERRM);
END;

-- Variável do tipo EXCEPTION
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT pemployee_id PROMPT 'Digite o ID'
DECLARE
    vfirst_name employees.first_name%TYPE;
    vlast_name  employees.last_name%TYPE;
    vemployee_id    employees.employee_id%TYPE := &pemployee_id;
    vjob_id employees.job_id%TYPE;
    ePresident EXCEPTION;
BEGIN
    SELECT first_name, last_name, employee_id, job_id
    INTO vfirst_name, vlast_name, vemployee_id, vjob_id
    FROM employees
    WHERE employee_id = vemployee_id;
    
    IF vjob_id = 'AD_PRES'
    THEN
        RAISE ePresident;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR (-20001, 'ID não existe');
    WHEN ePresident THEN
        UPDATE employees
        SET salary = salary * 1
        WHERE vemployee_id = employee_id;
    WHEN OTHERS
    THEN
        RAISE_APPLICATION_ERROR (-20003, 'Erro Oracle: ' || SQLCODE || SQLERRM);
END;

-- PRAGMA EXCEPTION_INIT  
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    vfirst_name         employees.first_name%TYPE := 'Robert';
    vlast_name          employees.last_name%TYPE := 'Ford';
    vjob_id             employees.job_id%TYPE := 'XX_YYYY';
    vphone_number       employees.phone_number%TYPE := '650.511.9844';
    vemail              employees.email%TYPE := 'RFORD';
    eFk_inexistente     EXCEPTION;
    PRAGMA EXCEPTION_INIT   (eFk_inexistente, -2291);
BEGIN
    INSERT INTO employees (employee_id, first_name, last_name, job_id, phone_number, hire_date, email)
    VALUES (employees_seq.nextval, vfirst_name, vlast_name, vjob_id, vphone_number, sysdate, vemail);
EXCEPTION
    WHEN eFk_inexistente THEN
        RAISE_APPLICATION_ERROR (-20003, 'Job inexistente');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20004, SQLCODE || SQLERRM);
END;

-- Procedures
SET SERVEROUTPUT ON
SET VERIFY OFF
CREATE OR REPLACE PROCEDURE PRC_INSERE_EMPREGADO (
    pfirst_name IN VARCHAR2,
    plast_name IN VARCHAR2,
    phire_date IN DEFAULT SYSDATE,
    pphone_number IN VARCHAR2)
AS -- ou IS

BEGIN
    INSERT INTO employees (employee_id, first_name, last_name, phone_number, hire_date) -- fiz de maneira resumida, existe mais parâmetros
    VALUES (employees_seq.nextval, pfirst_name, plast_name, pphone_number, phire_date);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20001, SQLCODE || SQLERRM);
END;

-- Executar a Procedure
BEGIN
    PRC_INSERE_EMPREGADO ('Ashton', 'Kutcher', '999.998.9-45', SYSDATE);
END;

-- Ou um comando do SQLPLUS
    EXEC PRC_INSERE_EMPREGADO ('Ashton', 'Kutcher', '999.998.9-45', SYSDATE);
    
-- Procedures método posicional e nominal. Chamando as procedures
-- Método Posicional
DECLARE
    employee_record employees%ROWTYPE;
BEGIN    
    PRC_CONSULTA_EMPREGADO (100, employee_record.first_name, employee_record.last_name, employee_record.email, employee_record.phone_number,
    employee_record.hire_date, employee_record.job_id, employee_record.salary, employee_record.commission_pct, employee_record.manager_id, employee_record.department_id);
    DBMS_OUTPUT.PUT_LINE ('Nome: ' || employee_record.first_name); -- deveria colocar todos os parâmetros...
END;

-- Método Nominal
DECLARE
    vemployee_id  NUMBER := 100;
    vfirst_name  VARCHAR(100);
    vlast_name  VARCHAR(100);
    vemail  VARCHAR(100);
    vphone_number  VARCHAR(100);
    vhire_date  DATE;
    vjob_id  VARCHAR(100);
    vsalary  VARCHAR(100);
    vcommission_pct  NUMBER;
    vmanager_id  NUMBER;
    vdepartment_id  NUMBER;
BEGIN
    PRC_CONSULTA_EMPREGADO (pemployee_id => vemployee_id,
                            pfirst_name => vfirst_name,
                            plast_name => vlast_name,
                            pemail => vemail,
                            pphone_number => vphone_number,
                            phire_date => vhire_date,
                            pjob_id => vjob_id,
                            psalary => vsalary,
                            pcommission_pct => vcommission_pct,
                            pmanager_id => vmanager_id,
                            pdepartment_id => vdepartment_id);
    DBMS_OUTPUT.PUT_LINE    (vfirst_name || ' ' ||
                            vlast_name || ' - ' ||
                            vdepartment_id || ' - ' ||
                            vjob_id || ' - ' ||
                            vphone_number || ' - ' ||
                            LTRIM(TO_CHAR(vsalary, '99G999G999D99')));
END;

-- Funções
CREATE OR REPLACE FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO
    (pemployee_id IN NUMBER)
    RETURN NUMBER
AS
    vsalary employees.salary%TYPE;
BEGIN
    SELECT salary
    INTO vsalary
    FROM employees
    WHERE employee_id = pemployee_id;
    
    RETURN (vsalary);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR (-20002, 'ID não existe');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20001, SQLCODE || SQLERRM);
END;

-- Executando a Função
ACCEPT pemployee_id PROMPT 'Digite o ID'
DECLARE
    vemployee_id    employees.employee_id%TYPE := &pemployee_id;
    vsalary         employees.salary%TYPE;
BEGIN
    vsalary := FNC_CONSULTA_SALARIO_EMPREGADO (vemployee_id);
    DBMS_OUTPUT.PUT_LINE ('Salário: ' || LTRIM(TO_CHAR(vsalary, 'L99G999G999D99')));
END;

CREATE OR REPLACE FUNCTION FNC_CONSULTA_TITULO_CARGO_EMPREGADO
    (pjob_id IN VARCHAR2)
    RETURN VARCHAR2
AS
    vjob_title  jobs.job_title%TYPE;
BEGIN
    SELECT job_title
    INTO vjob_title
    FROM JOBS
    WHERE job_id = pjob_id;
    
    RETURN (vjob_title);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR (-20001, 'Job ID não existe');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20002, SQLCODE || SQLERRM);
END;

-- Executando a Function
DECLARE
  --  vjob_id jobs.job_id%TYPE := 'IT_PROG';
    vjob_title  jobs.job_title%TYPE;
BEGIN
    vjob_title := FNC_CONSULTA_TITULO_CARGO_EMPREGADO ('IT_PROG');
    DBMS_OUTPUT.PUT_LINE ('CARGO: ' || vjob_title);
END;

-- Gerenciamento de Procedures e Functions (user_objects, all_objects e user_source)

-- Packages
CREATE OR REPLACE PACKAGE PCK_EMPREGADOS IS
    gminSalary employees.salary%TYPE;
    
    PROCEDURE PRC_INSERE_EMPREGADO (
        pfirst_name     IN VARCHAR2,
        plast_name      IN VARCHAR2,
        pemail          IN VARCHAR2,
        pphone_number   IN VARCHAR2,
        phire_date      IN DATE,
        pjob_id         IN VARCHAR2,
        psalary         IN NUMBER,
        pcommission_pct IN NUMBER,
        pmanager_id     IN NUMBER,
        pdepartment_id  IN NUMBER);
        
    PROCEDURE PRC_AUMENTA_SALARIO_EMPREGADO (
        pemployee_id IN NUMBER,
        ppercentual IN NUMBER);
        
    FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO (  
        pemployee_id IN NUMBER)
        RETURN NUMBER;
END;

-- Agora coloca o corpo das procedures e functions
CREATE OR REPLACE PACKAGE BODY PCK_EMPREGADOS IS
    PROCEDURE PRC_INSERE_EMPREGADO (
        pfirst_name     IN VARCHAR2,
        plast_name      IN VARCHAR2,
        pemail          IN VARCHAR2,
        pphone_number   IN VARCHAR2,
        phire_date      IN DATE,
        pjob_id         IN VARCHAR2,
        psalary         IN NUMBER,
        pcommission_pct IN NUMBER,
        pmanager_id     IN NUMBER,
        pdepartment_id  IN NUMBER)
IS
BEGIN
    INSERT INTO employees   (employee_id, first_name, last_name, email, phone_number, hire_date,
                                 job_id, salary, commission_pct, manager_id, department_id)
        VALUES (employees_seq.nextval, pfirst_name, plast_name, pemail, pphone_number, phire_date,
                pjob_id, psalary, pcommission_pct, pmanager_id, pdepartment_id);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20001, 'Erro Oracle: ' || SQLCODE || SQLERRM);
    END;
    
    PROCEDURE PRC_AUMENTA_SALARIO_EMPREGADO (
        pemployee_id IN NUMBER, 
        ppercentual IN NUMBER)
        
IS
BEGIN
    UPDATE employees
        SET salary = salary * (1 + ppercentual/100)
        WHERE employee_id = pemployee_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20001, 'Erro Oracle: ' || SQLCODE || SQLERRM);
    END;
    
    FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO (
        pemployee_id IN NUMBER)
        RETURN NUMBER
IS
    vsalary employees.salary%TYPE;
BEGIN
       SELECT vsalary
       INTO vsalary
       FROM employees
       WHERE pemployee_id = employee_id;
        
       RETURN (vsalary);
EXCEPTION
       WHEN NO_DATA_FOUND THEN
           RAISE_APPLICATION_ERROR (-20001, 'ID não existe');
       WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20002, 'Erro Oracle: ' || SQLCODE || SQLERRM);
       END;
END PCK_EMPREGADOS;

-- TRIGGERS
CREATE OR REPLACE TRIGGER B_I_EMPLOYEES_S_TRG (
BEFORE INSERT
ON EMPLOYEES
BEGIN
    IF (TO_CHAR(SYSDATE, 'DAY') IN ('SABADO', 'DOMINGO') OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) NOT BETWEEN 8 AND 18)
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'Fora do horário comercial de cadastramento');
    END IF;
END;

-- Trigger com vários eventos
CREATE OR REPLACE TRIGGER B_IUD_EMPLOYEES_S_TRG (
BEFORE INSERT OR UPDATE OR DELETE
ON EMPLOYEES
BEGIN
    IF (TO_CHAR(SYSDATE, 'DAY') IN ('SABADO', 'DOMINGO') OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) NOT BETWEEN 8 and 18)
    THEN
        CASE
            WHEN INSERTING THEN
                RAISE_APPLICATION_ERROR (-20001, 'Não pode cadastrar pessoas fora do horário comercial');
            WHEN UPDATING THEN
                RAISE_APPLICATION_ERROR (-20002, 'Não pode atualizar dados de pessoas fora do horário comercial');
            ELSE
                RAISE_APPLICATION_ERROR (-20003, 'A deleção dos empregados só é permitida no horário comercial');
        END CASE;
    END IF;
END;