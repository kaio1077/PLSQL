--
-- Seção 4 - Visão Geral do Oracle PL/SQL
--
-- Aula 1 - Visão Geral do Oracle PL/SQL
-- 

-- Bloco Anônimo - Exemplo

--
-- Seção 4 - Visão Geral do Oracle PL/SQL
--
-- Aula 1 - Visão Geral do Oracle PL/SQL
-- 

-- Bloco Anônimo - Exemplo

-- Coment�rios do Kaio - Vis�o geral do Oracle Se��o 4.7
SET SERVEROUTPUT ON
DECLARE
  vTexto  VARCHAR2(100) := 'Seja bem vindo ao PL/SQL';
BEGIN
  DBMS_OUTPUT.PUT_LINE(vTexto);
EXCEPTION
  WHEN OTHERS 
  THEN 
    DBMS_OUTPUT.PUT_LINE('Erro Oracle: ' || SQLCODE || SQLERRM);
END;

-- Se��o 5.8 - Bloco An�nimo
SET SERVEROUTPUT ON
DECLARE
    vNumero1 NUMBER(11,2) := 500;
    vNumero2 NUMBER(11,2) := 400;
    vMedia NUMBER(11,2);
BEGIN
    vMedia := (vNumero1 + vNumero2)/2;
    DBMS_OUTPUT.PUT_LINE ('Media = ' || vMedia);
END;

-- Se��o 6.9 - Definindo identificadores
SET SERVEROUTPUT ON
DECLARE
    vNumero NUMBER(11,2) := 1200.50;
BEGIN
    DBMS_OUTPUT.PUT_LINE ('N�mero = ' || vNumero);
END;

-- Se��o 6.9 - Declara��o de v�ri�vel char e varchar
DECLARE
    vCaracterTamFixo char(2):= 'RS';
    vCaracterTamVariavel varchar2(100) := 'Porto Alegre - RS';
BEGIN
    DBMS_OUTPUT.PUT_LINE ('String Tamanho Fixo: ' || vCaracterTamFixo);
    DBMS_OUTPUT.PUT_LINE ('String Tamanho Vari�vel: ' || vCaracterTamVariavel);
END;

-- Se��o 6.9 - Declara��o de v�ri�vel tipo DATE
-- N�O � NECESS�RIO O SET SERVEROUTPUT ON, POIS J� FOI INICIALIZADO EM CIMA
DECLARE
    vData1 DATE := '28/10/20';
    vData2 DATE := '28/10/2020';
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Data1: ' || vData1);
    DBMS_OUTPUT.PUT_LINE ('Data2: ' || vData2); -- O formato default da Oracle � DD/MM/YY, teria que converter por TO_CHAR para 4 d�gitos no ano
    DBMS_OUTPUT.PUT_LINE ('Data3: ' || to_char(vData2, 'DD/MM/YYYY')); -- ter� uma explica��o melhor adiante
END;

-- Se��o 6.10 - Declara��o de CONSTANTES
-- Tipo NUMBER
DECLARE
    vPi CONSTANT NUMBER (38,15) := 3.141592653589793;
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Pi = ' || vPi);
/*    vPi := 3.1415;
    DBMS_OUTPUT.PUT_LINE ('Pi = ' || vPi); */ -- Haver� um erro pois constante n�o pode ser alterada
END;

-- Tipo CHAR e VARCHAR2
DECLARE
    vCaracterTamFixo CONSTANT CHAR(2) := 'RS';
    vCaracterTamVariavel CONSTANT VARCHAR2(100) := 'Porto Alegre - RS';
BEGIN
    DBMS_OUTPUT.PUT_LINE ('String Caracter Tamanho Fixo: ' || vCaracterTamFixo); -- Aqui pode aplicar o mesmo teste de cima que haver� um erro caso tente modificar o valor na se��o "Begin"
    DBMS_OUTPUT.PUT_LINE ('String Caracter Tamanho Var�avel ' || vCaracterTamVariavel);
END;

-- Se��o 6.11 - Tipos de dados - DataTypes
SET SERVEROUTPUT ON
DECLARE
    vNumero NUMBER(11,2) := 1200.50;
    vCaracterTamFixo CHAR(100) := 'Texto de Tamanho Fixo de at� 32767 bytes';
    vCaracterTamVariavel VARCHAR2(100) := 'Texto de Tamanho V�ri�vel de at� 32767 bytes';
    vBooleano BOOLEAN := TRUE;
    vData DATE := sysdate;
    vLong LONG := 'Texto de tamanho vari�vel de at� 32760 bytes';
    vRowid ROWID;
    vTimestamp TIMESTAMP := systimestamp;
    vTimestampz TIMESTAMP WITH TIME ZONE := systimestamp;
    vCaracterTamFixoUniversal NCHAR(100) := 'Texto de Tamanho Fixo Universal de at� 32767 bytes'; -- NCHAR e NVARCHAR podem armazenar caracteres Unicode
    vCaracterTamVariavelUniversal NVARCHAR2(100) := 'Texto de Tamanho Vari�vel Universal de at� 32767 bytes'; -- HAR e VARCHAR n�o conseguem armazenar caracteres Unicode. 
    vNumeroInteiro BINARY_INTEGER := 1200;
    vNumeroFloat BINARY_FLOAT := 15000000;
    vNumeroDouble BINARY_DOUBLE := 15000000;
BEGIN
    DBMS_OUTPUT.PUT_LINE ('N�mero = ' || vNumero);
    DBMS_OUTPUT.PUT_LINE ('String de Caracteres Tam Fixo = ' || vCaracterTamFixo);
    DBMS_OUTPUT.PUT_LINE ('String de Caracteres Tam Variavel = ' || vCaracterTamVariavel);
    IF vBooleano = TRUE
    THEN
        DBMS_OUTPUT.PUT_LINE('Booleano = ' || 'TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Booleano = ' || 'FALSE OR NULL');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Data = ' || vData);
    DBMS_OUTPUT.PUT_LINE('LONG = ' || vLong);
    SELECT rowid
    INTO vRowid
    FROM employees 
    WHERE first_name = 'Steven' AND last_name = 'King'; 
    DBMS_OUTPUT.PUT_LINE('Rowid = ' || vRowid);
    DBMS_OUTPUT.PUT_LINE('Timestamp = ' || vTimestamp);
    DBMS_OUTPUT.PUT_LINE('Timestamp with time zone = ' || vTimestampz);
    DBMS_OUTPUT.PUT_LINE('String Caracteres Tam Fixo = ' || vCaracterTamFixoUniversal);
    DBMS_OUTPUT.PUT_LINE('String Caracteres Tam Variavel = ' ||  vCaracterTamVariavelUniversal);
    DBMS_OUTPUT.PUT_LINE('Numero Inteiro = ' || vNumeroInteiro);
    DBMS_OUTPUT.PUT_LINE('Numero Float = ' || vNumeroFloat);
    DBMS_OUTPUT.PUT_LINE('N�mero Double = ' || vNumeroDouble);
END;

-- Se��o 6.12 - Vari�vel BIND
SET SERVEROUTPUT ON
VARIABLE gmedia NUMBER -- O que for declarado fora do escopo vem de outra linguagem que n�o � PL/SQL
DECLARE
    vNumero1 NUMBER(11,2) := 2000;
    vNumero2 NUMBER(11,2) := 5000;
BEGIN
    :gmedia := (vNumero1 + vNumero2) / 2;
    DBMS_OUTPUT.PUT_LINE ('M�dia = ' || TO_CHAR(:gmedia)); -- TO_CHAR VAI CONVERTER PARA CARACTER
EXCEPTION
    WHEN OTHERS
    THEN
    DBMS_OUTPUT.PUT_LINE ('Erro ORACLE' || SQLCODE || SQLERRM);
END;

-- Se��o 7.13 - Sintaxe e Diretrizes de um Bloco PL/SQL
SET SERVEROUTPUT ON
DECLARE
    vNumero1 NUMBER(13,2); -- Declara��o de Vari�vel para o primeiro n�mero
    vNumero2 NUMBER(13,2); -- Declara��o de Vari�vel para o segundo n�mero
    vMedia NUMBER(13,2); -- Declara��o de Vari�vel para receber a m�dia calculada
BEGIN
    /* C�culo do 
    Valor da M�dia */ -- Exemplo para uso em mais de uma linha de coment�rio /* */
    vNumero1 := 5000;
    vNumero2 := 5E3;
    vMedia := (vNumero1 + vNumero2) / 2; -- C�lculo da m�dia entre os dois n�meros.
    DBMS_OUTPUT.PUT_LINE ('N�mero 1 = ' || vNumero1); -- Impress�o do primeiro n�mero
    DBMS_OUTPUT.PUT_LINE ('N�mero 2 = ' || vNumero2); -- Impress�o do segundo n�mero
    DBMS_OUTPUT.PUT_LINE ('M�dia = ' || vMedia); -- Impress�o da m�dia calculada
END;

-- Se��o 7.14 - Utilizando fun��es no Bloco PL/SQL
/* Fun��es SQL que podem ser utilizadas no PL/SQL entre elas:
Fun��es de Convers�o: toChar, toDate, toNumber.

Fun��es SQL que N�O podem ser utilizadas no PL/SQL:
Decode e,
Fun��es de grupo: AVG, MAX, MIN, COUNT, SUM, STDDEV, VARIANCE
*/
SET SERVEROUTPUT ON
DECLARE
    vNumero1 NUMBER(13,2);
    vNumero2 NUMBER(13,2);
    vMedia NUMBER(13,3);
BEGIN
    vNumero1 := 80000.8888;
    vNumero2 := 30000.4444;
    vMedia := ROUND((vNumero1 + vNumero2)/2, 2); -- ROUND = arrendondar e no final completando o valor, no caso para 2 casas decimais
    DBMS_OUTPUT.PUT_LINE ('N�mero 1 = ' || vNumero1);
    DBMS_OUTPUT.PUT_LINE ('N�mero 2 = ' || vNumero2);
    DBMS_OUTPUT.PUT_LINE ('M�dia = ' || vMedia);
    DBMS_OUTPUT.PUT_LINE ('M�dia com TO_CHAR = ' || TO_CHAR(vMedia)); -- sem a defini��o de pontua��o sa�ria igual o comando sem o TO_CHAR
    DBMS_OUTPUT.PUT_LINE ('M�dia = ' || TO_CHAR(vMedia,'99G999D9999')); -- O comando to_char permite a coloca��o de caracteres (G = ponto (.) e D = decimal (,) al�m dos n�meros.
END;

-- Se��o 7.15 - Blocos Aninhados e Escopo de Identificadores (vari�veis e constantes)
-- Blocos aninhados
SET SERVEROUTPUT ON
DECLARE
    vBloco1 VARCHAR2(20) := 'Bloco 1';
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Referenciando vari�vel do Bloco 1: ' || vBloco1);
    -- Se referenciar vBloco2 ocorrer� um erro, pois ainda n�o foi declarado e o primeiro bloco n�o 'enxerga' seus sub-blocos.
    DECLARE
        vBloco2 VARCHAR2(20) := 'Bloco 2';
    BEGIN
        DBMS_OUTPUT.PUT_LINE ('Referenciando vari�vel do Bloco 1: ' || vBloco1); -- A declara��o do bloco pai pode ser referenciado dentro de sub-blocos, o contr�rio ocorrer� um erro igual no coment�rio acima.
        DBMS_OUTPUT.PUT_LINE ('Referenciando vari�vel do Bloco 2: ' || vBloco2);  
    END;
    
    DBMS_OUTPUT.PUT_LINE ('Referenciando vari�vel do Bloco 1: ' || vBloco1);
        -- Se referencia vBloco2 ocorrer� um erro, pois quando finalizei (END) o sub-bloco deixa de existir e nunca � feito a busca em sub-blocos.
END;

-- Escopo de identificadores
<<Bloco1>>
DECLARE
    vBloco1 VARCHAR(20) := 'Bloco 1';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Referenciando vari�vel do Bloco 1: ' || vBloco1);
    
    <<BLOCO2>>
    DECLARE
        vBloco2 VARCHAR2(20) := 'Bloco 2';
    BEGIN
        DBMS_OUTPUT.PUT_LINE ('Referenciando vari�vel no Bloco 1: ' || vBloco1);
        DBMS_OUTPUT.PUT_LINE ('Referenciando vari�vel no Bloco 2: ' || vBloco2);
    END;
    DBMS_OUTPUT.PUT_LINE ('Referenciando vari�vel no Bloco 1: ' || vBloco1);
END;

-- Se��o 7.16 - Padr�es de Codifica��o sugerido pelo Oracle
/* 
Conven��es de Codifica��o
Palavras-chave: letras mai�sculas. Ex: BEGIN, DECLARE, END, DBMS_OUTPUT.PUT_LINE (Procedure da Package).
Comandos SQL: letras mai�sculas. Ex: SELECT, UPDATE.
Tipos de Dados: letras mai�sculas. Ex: NUMBER, VARCHAR2.
Nomes de identificadores e par�metros: letras min�sculas. Ex: vbloco1.
Nomes de tabelas e colunas: letras min�sculas.

Conven��es de Nomenclatura
Vari�veis: prefixo v. Ex: vbloco1.
Constante: prefixo c. Ex: cnumero1.
Cursor: sufixo _cursor.
Exce��o: Prefixo e. 
Tipo Record: sufixo record_type.
Vari�vel Record: sufixo _record.
Par�metro: prefixo p.
Vari�vel Global. Prefixo g.

Obs: A empresa pode ter suas pr�prias conven��es.
*/

-- Se��o 8.18 - Utilizando o comando SELECT no PL/SQL
-- Obs: A partir daqui seria um bom lugar para dividir as aulas. Parte 2

SET SERVEROUTPUT ON
DECLARE
    -- desc employees;
    vFirst_name  employees.first_name%type; -- significa que o identificador(vFirst_name) tem o mesmo tipo de dado do first_name = VARCHAR2(20). Ver desc employees para descobrir o tipo de dado;
    vLast_name   employees.last_name%type;
    vSalary      employees.salary%type;
    vEmployee_id employees.employee_id%type := 121; -- Alterar para id = 50 para exemplificar o ERRO ORA-1403 - No Data Found, pois n�o existe este valor na coluna employee_id. Futuramente trataremos com exce��es
BEGIN
    SELECT  first_name, last_name, salary
    INTO    vFirst_name, vLast_name, vSalary
    FROM    employees;
    WHERE   employee_id = vEmployee_id; -- Para garantir que retornar� apenas uma linha e a correta. O Oracle retorna o erro 01422 pois s� pode retornar uma linha
    DBMS_OUTPUT.PUT_LINE ('Employee Id: ' || vEmployee_id);
    DBMS_OUTPUT.PUT_LINE ('First Name: ' || vFirst_name);
    DBMS_OUTPUT.PUT_LINE ('Last Name: ' || vLast_name);
    DBMS_OUTPUT.PUT_LINE ('Salary: ' || vSalary);
END;

-- Utilizando fun��es de grupo (SUM, AVG...)
DECLARE
    vJob_id     employees.job_id%type := 'IT_PROG';
    vAvg_Salary employees.salary%type;
    vSum_Salary employees.salary%type;
BEGIN
    SELECT ROUND(AVG(salary),2), ROUND(SUM(salary),2)
    INTO vAvg_Salary, vSum_Salary -- Pelo que notei n�o � case sensitive dentro do select
    FROM employees
    WHERE job_id = vJob_id;
    DBMS_OUTPUT.PUT_LINE ('Cargo: ' || vJob_id);
    DBMS_OUTPUT.PUT_LINE ('M�dia de sal�rios: ' || vAvg_Salary); -- E Fora do SELECT tamb�m n�o � case sensitive
    DBMS_OUTPUT.PUT_LINE ('Somat�rio de sal�rios: ' || vSum_Salary);
END;

-- ERRO ORA-01422 - TOO MANY ROWS (Por fazer mais de uma mudan�a repeti o c�digo abaixo diferente do exemplo acima com a mudan�a da atribui��o do employee_id
DECLARE
    vJob_id     employees.job_id%type;
    vAvg_Salary employees.salary%type;
    vSum_Salary employees.salary%type;
BEGIN
    SELECT job_id, ROUND(AVG(salary),2), ROUND(SUM(salary),2)
    INTO vJob_id, vAvg_Salary, vSum_Salary -- Pelo que notei n�o � case sensitive dentro do select
    FROM employees
    GROUP BY job_id;
    DBMS_OUTPUT.PUT_LINE ('Cargo: ' || vJob_id);
    DBMS_OUTPUT.PUT_LINE ('M�dia de sal�rios: ' || vAvg_Salary); -- E Fora do SELECT tamb�m n�o � case sensitive
    DBMS_OUTPUT.PUT_LINE ('Somat�rio de sal�rios: ' || vSum_Salary);
END;

-- Se��o 8.19 - Utilizando o comando INSERT no PL/SQL
DECLARE
    vfirst_name employees.first_name%type;
    vlast_name employees.last_name%type;
    vsalary employees.salary%type;
BEGIN
    INSERT INTO employees
    (employee_id, first_name, last_name, email, phone_number, hire_date, 
    job_id, salary, commission_pct, manager_id, department_id)
    VALUES
    (employees_seq.nextval, 'Kobe', 'Bryant', 'KBRYANT', '515.123.45568', sysdate,
    'IT_PROG', 15000, 0.4, 103, 60);
    COMMIT;
END;

-- Se��o 8.20 - Utilizando o comando UPDATE no PL/SQL
DECLARE
    vEmployee_id    employees.employee_id%type := 207;
    vPercentual     NUMBER(3) := 10;
BEGIN
    UPDATE  employees
    SET     salary = salary * (1 + vPercentual / 100)
    WHERE   employee_id = vEmployee_id;
    COMMIT;
END;

-- Se��o 8.21 - Utilizando o comando DELETE no PL/SQL
DECLARE
    vEmployee_id employees_employee_id := 207;
BEGIN
    DELETE FROM employees
    WHERE employee_id = vEmployee_id;
    COMMIT;
END;

-- Se��o 8.22 - Controlando Transa��es de banco de dados do PL/SQL
/* Uma transa��o � executada depois de um DML(INSERT, UPDATE, DELETE) principais exemplos.
Obs: (DML = INSERT, UPDATE, DELETE, MERGE, CALL, EXPLAIN PLAN, LOCK TABLE)
Comando DDL ou DCL fazem um COMMIT autom�tico
*/

-- Exemplo de COMMIT, ou seja, uma confirma��o de uma transa��o
SET SERVEROUTPUT ON
DECLARE
    vEmployee_id employees.employee_id%type := 150;
BEGIN
    UPDATE employees
    SET salary = 15000
    WHERE employee_id = vEmployee_id;
    COMMIT;
END;

-- Exemplo de ROLLBACK, ou seja, desfaz a transa��o.
SET SERVEROUTPUT ON
DECLARE
    vEmployee_id employees.employee_id%type := 150;
BEGIN
    UPDATE employees
    SET salary = 20000
    WHERE employee_id = vEmployee_id;
    ROLLBACK;
END;

-- Exemplo de SAVEPOINT no sql, ou seja, criar um ponto de retorno.

INSERT INTO employees
(employee_id, first_name, last_name, email, phone_number, hire_date,
job_id, salary, commission_pct, manager_id, department_id)
VALUES
(employees_seq.nextval, 'Kobe', 'Bryant', 'KBRYANT', '515.123.45568', SYSDATE,
'IT_PROG', 15000, 0.4, 103, 60);

SAVEPOINT UPDATEOK;

UPDATE employees
SET salary = 30000
WHERE job_id = 'IT_PROG';

ROLLBACK TO UPDATEOK;

COMMIT;

-- Exemplo de SAVEPOINT no PL/SQL, ou seja, criar um ponto de retorno.
BEGIN
    INSERT INTO employees
    (employee_id, first_name, last_name, email, phone_number, hire_date,
    job_id, salary, commission_pct, manager_id, department_id)
    VALUES
    (employees_seq.nextval, 'Kobe', 'Bryant', 'KBRYANT', '515.123.45568', SYSDATE,
    'IT_PROG', 15000, 0.4, 103, 60);
    
    SAVEPOINT INSERTOK;
    
    UPDATE employees
    SET salary = 30000
    WHERE job_id = 'IT_PROG';
    
    ROLLBACK TO INSERTOK;
    COMMIT;
END;

-- Se��o 8.23 - Cursor Impl�cito do PL/SQL
-- Obs: um bom ponto para dividir a 3� parte da aula
/* O cursor � uma �rea da mem�ria criada pelo Servidor Oracle para o comando ser analisado e executado.
Quando a parte execut�vel (se��o BEGIN) de um bloco emite um comando SQL, o PL/SQL cria um cursor impl�cito na qual � administrado automaticamente. 

SQL%ROWCOUNT = N�mero de linhas afetadas pelo cursor
SQL%FOUND = Retorna TRUE se o cursor afetou uma ou mais linhas
SQL%NOTFOUND = Retorna TRUE se o cursor N�O afetou nenhuma linha.
SQL%ISOPEN = Retorna FALSE, porque o Oracle controla o cursor impl�cito automaticamente, fechando o cursor
*/

SET SERVEROUTPUT ON
DECLARE
    vdepartment_id  employees.department_id%type := 60;
    vpercentual     NUMBER(3) := 10;
BEGIN
    UPDATE employees
    SET salary = salary * (1 + vpercentual/100)
    WHERE department_id = vdepartment_id;
    DBMS_OUTPUT.PUT_LINE ('N�mero de empregados atualizados: ' || SQL%ROWCOUNT);
    -- COMMIT; N�o executei para n�o alterar a tabela original de employees
END;

ROLLBACK; -- Para retornar aos valores anteriores e o teste ser apenas para exemplo

-- Se��o 9.24 (Estruturas de Controle) - Operadores PLSQL e Regras de Preced�ncia 
-- ver imagem na pasta C:\Users\kaio_\OneDrive\Documentos\Kaio\Treinamento\Udemy\5 - Oracle PLSQL Especialista do B�sico ao Avan�ado - Completo
SET SERVEROUTPUT ON
DECLARE
    vNota1 NUMBER(11,2) := 7.0;
    vNota2 NUMBER(11,2) := 6.0;
    vNota3 NUMBER(11,2) := 9.0;
    vNota4 NUMBER(11,2) := 6.0;
    vMedia NUMBER(11,2);
BEGIN
    vMedia := (vNota1 + vNota2 + vNota3 + vNota4)/4;
    DBMS_OUTPUT.PUT_LINE ('M�dia = ' || vMedia);
END;

-- Se��o 9.25 (Estruturas de Controle) - Comando IF
-- IF e ELSE
SET SERVEROUTPUT ON
ACCEPT pdepartment_id PROMPT 'Digite seu ID do Departamento'
DECLARE
    vpercentual NUMBER(3);
    vdepartment_id employees.department_id%type := &pdepartment_id;
BEGIN 
    IF vdepartment_id = 80 -- Sales (Vendas)
    THEN
        vpercentual := 10;
    ELSE
        IF vdepartment_id = 20 -- Marketing
        THEN
            vpercentual := 15;
        ELSE
            IF vdepartment_id = 60 -- I.T (T.I)
            THEN
                vpercentual := 20;
            ELSE
                vpercentual := 5;
            END IF;
        END IF;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE ('ID do Departamento: ' || vdepartment_id);
    DBMS_OUTPUT.PUT_LINE ('Percentual aplicado: ' || vpercentual);
    
    UPDATE employees
    SET SALARY = salary * (1 + vpercentual / 100)
    WHERE department_id = &pdepartment_id;
    -- COMMIT;
END;

-- IF e ELSIF
SET SERVEROUTPUT ON
ACCEPT pdepartment_id PROMPT 'Digite o ID do seu departamento'
DECLARE
    vpercentual NUMBER(3);
    vdepartment_id employees.department_id%type := &pdepartment_id;
BEGIN -- id = 80, perc = 10. id = 20, perc = 15. id = 60, perc 20, outros = 5
    IF vdepartment_id = 80 -- Sales (Vendas)
    THEN
        vpercentual := 10;
    ELSIF vdepartment_id = 20 -- Marketing
    THEN
        vpercentual := 15;
    ELSIF vdepartment_id = 60 -- I.T (T.I)
    THEN
        vpercentual := 20;
    ELSE
        vpercentual := 5;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE ('ID do seu departamento: ' || &pdepartment_id);
    DBMS_OUTPUT.PUT_LINE ('Percentual aplicado: ' || vpercentual);
    
    UPDATE employees
    SET salary = salary * (1 + vpercentual / 100)
    WHERE department_id = &pdepartment_id;
    COMMIT;
END;
    
-- Se��o 9.26 (Estruturas de Controle) - Comando CASE
-- 1� FORMA do uso do CASE (condi��o na cl�usula CASE)
SET SERVEROUTPUT ON
ACCEPT pdepartment_id PROMPT 'Digite o ID do seu Departamento'
DECLARE
    vpercentual NUMBER(3);
    vdepartment_id  employees.department_id%type := &pdepartment_id;
BEGIN -- id = 80, perc = 10. id = 20, perc = 15. id = 60, perc 20, outros = 5
    CASE vdepartment_id
    WHEN 80 -- SALES
    THEN
        vpercentual := 10; 
    WHEN 20 -- MARKETING
    THEN
        vpercentual := 15; 
    WHEN 60 -- I.T
    THEN
        vpercentual := 20;
    ELSE
        vpercentual := 5;
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE ('Seu ID do departmento: ' || vdepartment_id);
    DBMS_OUTPUT.PUT_LINE ('Percentual aplicado: ' || vpercentual);
    
    UPDATE employees
    SET salary = salary * (1 + vpercentual/100)
    WHERE department_id = vdepartment_id;
    -- COMMIT;
END;

-- 2� Forma do uso do CASE (condi��o na cl�usula WHEN)
SET SERVEROUTPUT ON
ACCEPT pdepartment_id PROMPT 'Digite o seu Departmento ID'
DECLARE
    vpercentual     NUMBER(3);
    vdepartment_id  employees.department_id%type := &pdepartment_id;
BEGIN -- id = 80, perc = 10. id = 20, perc = 15. id = 60, perc 20, outros = 5
    CASE
    WHEN vdepartment_id = 80 -- SALES
    THEN
        vpercentual := 10;
    WHEN vdepartment_id = 20 -- Marketing
    THEN
        vpercentual := 15;
    WHEN vdepartment_id = 60 -- I.T
    THEN
        vpercentual := 20;
    ELSE
        vpercentual := 5;
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE ('ID do seu departamento: ' || &pdepartment_id);
    DBMS_OUTPUT.PUT_LINE ('Percentual aplicado: ' || vpercentual);
        
    UPDATE employees
    SET salary = salary * (1 + vpercentual/100)
    WHERE department_id = &pdepartment_id;
    -- COMMIT;
END;
    
-- Se��o 9.27 (Estruturas de Controle) - Loop b�sico

ACCEPT pLimite PROMPT 'Digite o valor m�ximo'
DECLARE
    vNumero NUMBER(30) := 1;
    vLimite NUMBER(30) := &pLimite;
BEGIN
-- Imprimindo os n�meros de 1 at� o limite
LOOP
    DBMS_OUTPUT.PUT_LINE ('N�mero: ' || to_char(vNumero));
    EXIT WHEN vNumero = vLimite; -- o LOOP para quando a expres�o se tornar verdadeira
    vNumero := vNumero + 1;
END LOOP;
END;

-- Se��o 9.28 (Estruturas de Controle) - FOR LOOP
SET SERVEROUTPUT ON
ACCEPT plimite PROMPT 'Digite o valor limite'
DECLARE
    vinicio INTEGER(3) := 1;
    vfim NUMBER(10) := &plimite;
BEGIN -- Aqui o LOOP para quando se tornar verdadeiro
    FOR i IN vinicio..vfim  LOOP -- i � definido automaticamente como BYNARY_INTEGER e o escopo ser� apenas dentro do FOR LOOP
    DBMS_OUTPUT.PUT_LINE ('N�mero: ' || TO_CHAR(i));
    END LOOP;
END;

-- Se��o 9.29 (Estruturas de Controle) - WHILE LOOP
SET SERVEROUTPUT ON
ACCEPT plimite PROMPT 'Digite o N�mero'
DECLARE
    vNumero NUMBER(3) := 1;
    vLimite NUMBER(3) := &plimite;
BEGIN
    WHILE vNumero <= vLimite LOOP -- Funciona enquanto ser verdadeiro
        DBMS_OUTPUT.PUT_LINE ('N�mero: ' || to_char(vNumero));
        vNumero := vNumero + 1;
    END LOOP;
END;

-- Se��o 9.30 (Estruturas de Controle) - LOOPs Aninhados
SET SERVEROUTPUT ON
DECLARE
    vTotal NUMBER(30) := 1;
BEGIN
<<LOOP1>>
FOR i IN 1..8 LOOP
    DBMS_OUTPUT.PUT_LINE ('N�mero(i): ' || TO_CHAR(i));
    <<LOOP2>>
    FOR j IN 1..8 LOOP
        DBMS_OUTPUT.PUT_LINE ('N�mero(j): ' || TO_CHAR(j));
--        DBMS_OUTPUT.PUT_LINE ('Total: ' || TO_CHAR(vTotal));
        vtotal := vtotal * 2;
--        EXIT LOOP1 WHEN vtotal > 1000000000000000; --Teste para fazer, chega at� o 1 = 7 e j = 2
    END LOOP;
END LOOP;
    DBMS_OUTPUT.PUT_LINE ('Total final: ' || TO_CHAR(vTotal, '99G999G999G999G999G999G999D99'));
--    DBMS_OUTPUT.PUT_LINE ('Total final: ' || TO_CHAR(vTotal));  
--    DBMS_OUTPUT.PUT_LINE ('Total final: ' || vTotal);
END;

-- Se��o 10.31 (Tipos Compostos) - Vari�veis Tipo PL/SQL Record
SET SERVEROUTPUT ON
SET VERIFY OFF -- N�o imprime o c�digo do bloco na sa�da do script quando eu executar
ACCEPT pemployee_id PROMPT 'Digite o ID do empregado'
DECLARE -- id, first_name, last_name, email, phone_number
TYPE employee_record_type IS RECORD
    (employee_id        employees.employee_id%type,
    first_name          employees.first_name%type,
    last_name           employees.last_name%type,
    email               employees.email%type,
    phone_number        employees.phone_number%type);
employee_record     employee_record_type;

BEGIN
SELECT employee_id, first_name, last_name, email, phone_number -- Ex: retirar o email para ver o erro ORA-00913
INTO employee_record -- SE colocar a vari�vel do tipo record, � necess�rio colocar no SELECT todas as vari�veis que est�o dentro do record_type para evitar o erro ORA-00913: valores demais
FROM employees
WHERE employee_id = &pemployee_id;
DBMS_OUTPUT.PUT_LINE    (employee_record.employee_id || ' - ' ||
                        employee_record.first_name || ' - ' ||
                        employee_record.last_name || ' - ' ||
                        employee_record.phone_number);
END;

-- Se��o 10.32 (Tipos Compostos) - Atributo %ROWTYPE
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT pemployee_id PROMPT 'Digite o ID'
DECLARE
    employee_record employees%ROWTYPE;
--    vemployee_id    employees.employee_id%type := &pemployee_id; (Boa pr�tica)
BEGIN -- id, first_name, last_name, phone_number)
SELECT *
INTO employee_record
FROM employees
WHERE employee_id = &pemployee_id; -- employee_id = vemployee_id (Este modo em coment�rio equivale a boas pr�ticas e liberar a vari�vel acima)
DBMS_OUTPUT.PUT_LINE    (employee_record.employee_id || ' - ' ||
                        employee_record.first_name || ' - ' ||
                        employee_record.last_name || ' - ' ||
                        employee_record.phone_number || ' - ' ||
                        employee_record.job_id);
END;

-- Se��o 11.33 (Tipos Compostos) - Collections - Associative Array
-- COLLECTIONS s�o estruturas para gerenciamento de m�ltiplas linhas de dados (vetores)
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
   TYPE numero_table_type IS TABLE OF NUMBER(2)
   INDEX BY BINARY_INTEGER;
   numero_table numero_table_type;
BEGIN
    -- Armazena n�meros de 1 a 10 em um associative array
    FOR i IN 1..10 LOOP
        numero_table(i) := i + 2;
    END LOOP;
    -- L� o associative array e imprime os n�meros armazenados
    FOR I IN 1..10
    LOOP
        DBMS_OUTPUT.PUT_LINE ('Associative Array: Indice = ' || TO_CHAR(I) || ', Valor = ' || TO_CHAR(numero_table(i)));
    END LOOP;
END;

-- Se��o 11.34 (Tipos Compostos) - Collections - Associative Array - Bulk Collect
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    TYPE employee_table_type IS TABLE OF employees%ROWTYPE
    INDEX BY BINARY_INTEGER; -- Associative ARRAY obrigat�rio a cl�usula BINARY_INTEGER
    employee_table  employee_table_type;
BEGIN
    SELECT * 
    BULK COLLECT INTO employee_table -- Bulk Collection de todos (order_id) para a Collection (vorder_id)
    FROM employees;
/* A cl�usula BULK COLLECT transfere todas as  informa��es adquiridas no select pelo employees para a vari�vel employee_table. Um problema � que consome muita mem�ria, por isso n�o � recomendado para tabelas muito grandes.
A melhor maneira seria utilizar um cursor para tabelas grandes */
    FOR i IN employee_table.first..employee_table.last
    LOOP
        DBMS_OUTPUT.PUT_LINE    (employee_table(i).employee_id || ' - ' ||
                                employee_table(i).first_name || ' - ' ||
                                employee_table(i).last_name || ' - ' ||
                                employee_table(i).phone_number || ' - ' ||
                                employee_table(i).job_id || ' - ' ||
                                TO_CHAR(employee_table(i).salary, '99G999D99'));
    END LOOP;
END;

-- Se��o 11.35 (Tipos Compostos) - Collections - Nested Table
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    TYPE numero_table_type IS TABLE OF INTEGER(2); -- N�o possui Index By por isso se difere de um associative array sintaxicamente.
    numero_table    numero_table_type := numero_table_type(); -- � obrigat�rio inicializar o Nested Table, mesmo que seja vazio.
BEGIN
    -- Armazena n�meros de 1 a 10
    FOR i IN 1..10
    LOOP
        numero_table.extend; -- Extend (seria uma troca em rela��o ao INDEX BY do associative array) para alocar uma ocorr�ncia e depois disso pode ser alocados valores e os �ndices(i) somente positivo.
        numero_table(i) := i;
    END LOOP;
    -- L� o Nested Table e imprime os n�meros armazenados
    FOR i IN 1..10
    LOOP
        DBMS_OUTPUT.PUT_LINE ('Nested Table: Indice = ' || TO_CHAR(i) || ', Valor = ' || TO_CHAR(numero_table(i)));
    END LOOP;
END;

-- Se��o 11.36 (Tipos Compostos) - Collections - Nested Table of Records - Bulk Collect
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    TYPE employee_table_type IS TABLE OF employees%ROWTYPE;
    employee_table  employee_table_type := employee_table_type();
BEGIN
    SELECT *
    BULK COLLECT INTO employee_table
    FROM employees;
/* A cl�usula BULK COLLECT transfere todas as  informa��es adquiridas no select pelo employees para a vari�vel employee_table. Um problema � que consome muita mem�ria, por isso n�o � recomendado para tabelas muito grandes.
A melhor maneira seria utilizar um cursor para tabelas grandes */    
    FOR i IN employee_table.first..employee_table.last
    LOOP -- id, first_name, last_name, phone_number, job_id, salary
        DBMS_OUTPUT.PUT_LINE    (employee_table(i).first_name || ' - ' ||
                                employee_table(i).last_name || ' - ' ||
                                employee_table(i).phone_number || ' - ' ||
                                employee_table(i).job_id || ' - ' ||
                                TO_CHAR(employee_table(i).salary, '99G999D99'));
    END LOOP;
END;

-- Se��o 11.37 (Tipos Compostos) - Collections - VARRAY
/* Muito parecido com Nested Table, precisa ser inicializado, �ndices positivos e a diferen�a est� que o tamanho m�ximo do vetor deve ser especificado na declara��o (Nested Table � alocado dinamicamente).
Dessa forma tem uma prote��o para erros como loop infinito n�o estrapole a sua mem�ria */
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    TYPE numero_table_type IS VARRAY (10) OF INTEGER(2); -- Ou ... IS VARYING ARRAY (10) OF INTEGER(2);
    numero_table    numero_table_type := numero_table_type();
BEGIN
    FOR i IN 1..10 LOOP
        numero_table.extend;
        numero_table(i) := i;
    END LOOP;
-- L� o VARRAY e imprime os n�meros armazenados    
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE ('VARRAY: �ndice = ' || TO_CHAR(i) || ', Valor = ' || TO_CHAR(numero_table(i)));
    END LOOP;
END;

-- Se��o 11.38 (Tipos Compostos) - Collections - VARRAY of Records - Bulk Collect
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    TYPE employee_table_type IS VARRAY (200) OF employees%ROWTYPE;
    employee_table  employee_table_type := employee_table_type();
-- Para ter certeza de quantas linhas(�ndices) ter� para colocar no limite do VARRAY exatamente = 108
/* SELECT COUNT(*)
FROM employees */
BEGIN
    SELECT *
    BULK COLLECT INTO employee_table
    FROM employees;
    
    FOR i IN employee_table.first..employee_table.last
    LOOP
        DBMS_OUTPUT.PUT_LINE    (employee_table(i).employee_id || ' - ' ||
                                employee_table(i).first_name || ' - ' ||
                                employee_table(i).last_name || ' - ' ||
                                employee_table(i).phone_number || ' - ' ||
                                employee_table(i).job_id || ' - ' ||
                                TO_CHAR(employee_table(i).salary, '99G999D99'));
    END LOOP;
END;

-- Se��o 11.39 (Tipos Compostos) - Collections - Utilizando m�todos para controlar Collections
-- Exemplo de um exerc�cio anterior j� feito Nested Table. Imagens com o nome M�todos de Collections para saber de outros m�todos.
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    TYPE employee_table_type IS TABLE OF employees%ROWTYPE;
    employee_table  employee_table_type := employee_table_type();
BEGIN
    SELECT *
    BULK COLLECT INTO employee_table
    FROM employees;
    
    FOR i IN employee_table.first..employee_table.last 
    LOOP
        DBMS_OUTPUT.PUT_LINE    (employee_table(i).employee_id || ' - ' ||
                                employee_table(i).first_name || ' - ' ||
                                employee_table(i).last_name || ' - ' ||
                                employee_table(i).phone_number || ' - ' ||
                                employee_table(i).job_id || ' - ' ||
                                employee_table.first || ' - ' ||
                                TO_CHAR(employee_table(i).salary, '99G999D99'));
    END LOOP;
END;
/* Obs: m�todos poss�veis para cada Collection
Associative Array: EXISTS(n), COUNT(n), FIRST, LAST, PRIOR(n), NEXT(n), DELETE
Nested Table: EXISTS(n), COUNT(n), FIRST, LAST, PRIOR(n), NEXT(n), EXTEND(n), TRIM, DELETE
Varray: EXISTS(n), COUNT(n), FIRST, LAST, LIMIT, PRIOR(n), NEXT(n), EXTEND(n), DELETE 

-- Se��o 12.40 (Tipos Compostos) - Cursor Expl�cito
/* Como funciona o Cursor Expl�cito?
Na sess�o DECLARE ser� declarado o Cursor (dar o nome da vari�vel e associar a um select)
Na sess�o BEGIN dar� um OPEN do Cursor (o Oracle executa o select do cursor e traz todas as linhas recuperadas para a mem�ria do Oracle). As linhas s�o chamadas de RESULT SET ou ACTIVE SET
Neste momento haver� um ponteiro para a primeira linha, o pr�ximo passo � criar um LOOP para carregar as linhas por meio da vari�vel ORACLE FETCH(buscar) do cursor at� que chegue numa linha vazia para sair do loop.
Depois disso � necess�rio liberar o Conjunto Ativo(Result SET) fechando o cursor CLOSE_nome_do_cursor. */
-- Imagens do Cursor Expl�cito 

-- Controlando um Cursor Expl�cito com Loop B�sico
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor IS
    SELECT *
    FROM employees; -- Declara��o do Cursor
    
    employee_record employee_cursor%ROWTYPE;
BEGIN
    OPEN employee_cursor; -- Abrindo o Cursor
    
    LOOP
        FETCH employee_cursor -- Recupera uma linha do cursor
        INTO employee_record;
        
        EXIT WHEN employee_cursor%notfound;
        
        DBMS_OUTPUT.PUT_LINE    (employee_record.employee_id || ' - ' ||
                                employee_record.first_name || ' - ' ||
                                employee_record.last_name || ' - ' ||
                                employee_record.department_id || ' - ' ||
                                employee_record.job_id || ' - ' ||
                                employee_record.phone_number || ' - ' ||
                                LTRIM(TO_CHAR(employee_record.salary, 'L99G999D99')));  -- LTRIM remove os espa�os em branco
                                -- L = moeda local, G(ponto) = s�mbolo de milhar, D(v�rgula) = decimal
    END LOOP;
    CLOSE employee_cursor; -- Close do Cursor
END;

-- Controlando Cursor com WHILE Loop
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor IS
    SELECT * 
    FROM employees;
    employee_record employee_cursor%rowtype;
BEGIN
    OPEN employee_cursor;
    FETCH employee_cursor -- Fetch do cursor para inicializar, por n�o estar vazio pode entrar no loop while
        INTO employee_record;    
    WHILE employee_cursor%found LOOP -- Enquanto Encontrar(%FOUND) as linhas
        DBMS_OUTPUT.PUT_LINE    (employee_record.employee_id || ' - ' ||
                                employee_record.first_name || ' - ' ||
                                employee_record.last_name || ' - ' ||
                                employee_record.department_id || ' - ' ||
                                employee_record.job_id || ' - ' ||
                                employee_record.phone_number || ' - ' ||
                                LTRIM(TO_CHAR(employee_record.salary, 'L99G999D99')));  -- LTRIM remove os espa�os em branco
                                -- L = moeda local, G(ponto) = s�mbolo de milhar, D(v�rgula) = decimal
        FETCH employee_cursor -- Para continuar as buscar
        INTO employee_record;
           
    END LOOP;
    CLOSE employee_cursor;
END;

-- Se��o 12.41 (Tipos Compostos) - Cursor Expl�cito com FOR LOOP
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor IS
    SELECT *
    FROM employees;
-- N�o precisou abrir uma vari�vel, pois ser� feito dentro do FOR
BEGIN
    FOR employee_record IN employee_cursor -- a vari�vel_record ser� utilizada apenas dentro do FOR e o loop com o employee_cursor j� fica impl�cito o OPEN, FETCH e o CLOSE, sendo feito tudo automaticamente
    LOOP
    -- N�o teve a necessidade de OPEN cursor e tamb�m o FETCH(cursor) e INTO (record), pois � feito tudo autom�tico pelo FOR
        DBMS_OUTPUT.PUT_LINE    (employee_record.employee_id || ' - ' ||
                                employee_record.first_name || ' - ' ||
                                employee_record.last_name || ' - ' ||
                                employee_record.department_id || ' - ' ||
                                employee_record.job_id || ' - ' ||
                                employee_record.phone_number || ' - ' ||
                                LTRIM(TO_CHAR(employee_record.salary, 'L99G999G999G999D99')));
    -- Assim que n�o encontrar mais linhas (%NOTFOUND) sair� automaticamente do LOOP
    END LOOP;
-- Da mesma maneira que n�o precisou abrir (OPEN_cursor), pois foi aberta de maneira autom�tica, tamb�m n�o ser� fechada (CLOSE_cursor)
END;

-- Cursor FOR LOOP como SUB-CONSULTA
SET SERVEROUTPUT ON
SET VERIFY OFF
-- N�o declara o CURSOR para p�-lo dentro do FOR LOOP
BEGIN
    FOR employee_record IN  (SELECT *
                             FROM employees)
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
-- Obs: � prefer�vel declarar o CURSOR, pois � mais claro para futuras manuten��es por pessoas diferentes

-- Se��o 12.42 (Tipos Compostos) - Cursor Expl�cito com Par�metros
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor (pdepartment_id employees.department_id%type, pjob_id employees.job_id%type) IS
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

-- Com Loop While
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor (pdepartment_id NUMBER, pjob_id VARCHAR2)
    IS
    SELECT *
    FROM employees
    WHERE department_id = pdepartment_id AND job_id = pjob_id;
    employee_record employee_cursor%rowtype;
BEGIN
    OPEN employee_cursor(60, 'IT_PROG');
    
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

-- Loop B�sico
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor (pdepartment_id NUMBER, pjob_id VARCHAR2) 
    IS
    SELECT *
    FROM employees
    WHERE department_id = pdepartment_id AND job_id = pjob_id;
    employee_record employees%rowtype;
BEGIN
    OPEN employee_cursor(60, 'IT_PROG');
    
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

-- Se��o 12.43 (Tipos Compostos) - Cursor Expl�cito com SELECT FOR UPDATE e a cl�usula WHERE CURRENT OF

-- Com oo COMANDO FOR UPDATE as linhas do SELECT estar�o travadas(Locked). Se uma outra pessoa tentar fazer uma DML (update, insert, delete) ou at� outro FOR UPDATE ap�s voc� executar antes, ela estar� em espera (WAIT).
-- Recomendado para recuperar poucas linhas, para n�o atrapalhar a programa��o de outros usu�rios e em poucos casos.
-- WHERE CURRENT OF nome_do_cursor s� pode ser usado dentro do FOR UPDATE OF...
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    CURSOR employee_cursor (pjob_id VARCHAR2) IS
    SELECT *
    FROM employees
    WHERE job_id = pjob_id
    FOR UPDATE;
-- Depois dessa etapa � feito o "LOCK" nas linhas recuperadas.
BEGIN
    FOR employee_record IN employee_cursor ('AD_VP')
    LOOP
        UPDATE employees
        SET salary = salary * (1 + 10/100)
        WHERE CURRENT OF employee_cursor;
    END LOOP;
    COMMIT;
END;
-- OBS: demonstra��o do cursor com FOR UPDATE poderia nem entrar no LOOP se colocasse o UPDATE, SET e WHERE job_id = 'AD_VP'

-- Se��o 13.44 - Tratamento de Exce��es
-- � reservado pela ORACLE c�digos de erros do -20000 ao -20999 e � necess�rio o uso do RAISE_APPLICATION_ERROR
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT pemployee_id PROMPT 'Digite o c�digo ID'
DECLARE
    vfirst_name     employees.first_name%TYPE;
    vlast_name      employees.last_name%TYPE;
    vemployee_id    employees.employee_id%TYPE := &pemployee_id;
BEGIN
    SELECT first_name, last_name
    INTO vfirst_name, vlast_name
    FROM employees
    WHERE employee_id = vemployee_id; -- OBS: S� pode retornar uma linha dentro de um SELECT, pois n�o est� dentro de um cursor. Por isso n�o ser� tratado nesse programa TOO_MANY_ROWS

    DBMS_OUTPUT.PUT_LINE ('Nome do empregado: ' || vfirst_name || ' ' || vlast_name);
EXCEPTION
    WHEN NO_DATA_FOUND -- NO_DATA_FOUND significa que n�o retorna nenhuma linha
    THEN
    -- ROLLBACK; � uma op��o caso necessite desfazer algum DML (INSERT, UPDATE, DELETE) no programa. N�o � o caso acima.
        RAISE_APPLICATION_ERROR (-20001, 'ID do empregado n�o cadastrado: ' || TO_CHAR(vemployee_id));
    WHEN OTHERS
    THEN
        RAISE_APPLICATION_ERROR (-20002, 'Erro ORACLE: ' || SQLCODE || SQLERRM); -- SQLCODE = mostra o c�digo do ERRO (ORA-00000). SQLERRM = mostra a mensagem do erro
END;

-- Se��o 13.45 - (Tratamento de Exce��es) - Exce��es definidas pelo desenvolvedor
-- Utilizado para interceptar um ERRO ORACLE na qual n�o tem uma exce��o(EXCEPTION) pr�-definida
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT pemployee_id PROMPT 'Digite o ID do empregado'
DECLARE
    vfirst_name     employees.first_name%TYPE;
    vlast_name      employees.last_name%TYPE;
    vjob_id         employees.job_id%TYPE;
    vemployee_id    employees.employee_id%TYPE := &pemployee_id;
    ePresident      EXCEPTION; 
BEGIN
    SELECT first_name, last_name, job_id
    INTO vfirst_name, vlast_name, vjob_id
    FROM employees
    WHERE employee_id = vemployee_id;
    
    IF vjob_id = 'AD_PRES'
    THEN
        RAISE ePresident; -- RAISE lembra muito a funcionalidade GO TO e � pouco recomend�vel utiliz�-lo para programa��es
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'C�digo n�o cadastrado: ' || TO_CHAR(vemployee_id));
    WHEN ePresident
    THEN
        UPDATE employees
        SET salary = salary * 1.5
        WHERE employee_id = vemployee_id;
        -- COMMIT;
    WHEN OTHERS
    THEN
        RAISE_APPLICATION_ERROR (-20002, 'Erro ORACLE: ' || SQLCODE || SQLERRM);
END;

SELECT *
FROM EMPLOYEES
WHERE job_id = 'AD_PRES';

-- Se��o 13.46 - (Tratamento de Exce��es) - PRAGMA EXCEPTION INIT
-- Uma das op��es para saber o c�digo do ERRO �: 1 - procurar na documenta��o Oracle. 2 - For�ar o erro para o sistema te mostrar o erro ORA-XXXX
DECLARE
    vfirst_name         employees.first_name%TYPE := 'Robert';
    vlast_name          employees.last_name%TYPE := 'Ford';
    vjob_id             employees.job_id%TYPE := 'XX_YYYY';
    vphone_number       employees.phone_number%TYPE := '650.511.9844';
    vemail              employees.email%TYPE := 'RFORD';
    eFk_inexistente     EXCEPTION;
    PRAGMA EXCEPTION_INIT (efk_inexistente, -2291); -- ERRO ORA-2291: Viola��o de Constraint de Foreign Key, ou seja, passar uma informa��o pra chave estrangeira que n�o tem corresponde na Primary Key(chave prim�ria)... 
BEGIN                                                -- ... este erro n�o tem um nome de exce��o pr�-definida.
    INSERT INTO employees (employee_id, first_name, last_name, phone_number, email, hire_date, job_id) -- JOB_id � uma chave prim�ria da tabela JOBS, logo JOB_ID da tabela EMPLOYEES � uma chave estrangeira.
    VALUES (employees_seq.nextval, vfirst_name, vlast_name, vphone_number, vemail, sysdate, vjob_id); -- Se eu inventar um valor para o JOB_ID ser� uma viola��o da chave estrangeira
    COMMIT;
EXCEPTION
    WHEN eFk_inexistente
    THEN
        RAISE_APPLICATION_ERROR (-20003, 'Job inexistente');
    WHEN OTHERS
    THEN
        RAISE_APPLICATION_ERROR (-20002, 'Erro Oracle ' || SQLCODE || SQLERRM);
END;

-- Exemplo para for�ar o ERRO de job_id inexistente. Verificar o relat�rio de erros.
    INSERT INTO employees (employee_id, first_name, last_name, phone_number, email, hire_date, job_id) 
    VALUES (employees_seq.nextval, 'Joseph', 'Smith', '3333333', 'JSMITH', sysdate, 'ZZZZ_XX');
    
-- Se��o 14.47 - (Procedures de Banco de Dados) - Cria��o
CREATE OR REPLACE PROCEDURE PRC_INSERE_EMPREGADO
-- Ver os tipos das vari�veis com desc employees;
-- Neste caso foi declarado uma lista de par�metros
-- Existe na lista de par�metros os tipos IN (entrada), OUT (sa�da) e IN OUT (entrada e sa�da). Se colocar o tipo, nunca complementar com o tamanho. Ex: VARCHAR2(10).
    (pfirst_name IN VARCHAR2,           -- (pfirst_name IN employees.first_name%TYPE,
    plast_name IN VARCHAR2,             -- plast_name IN employees.last_name%TYPE,
    pemail IN VARCHAR2,                 -- pemail IN employees.email%TYPE,
    pphone_number IN VARCHAR2,          -- pphone_number IN employees.phone_number%TYPE,
    phire_date IN DATE DEFAULT SYSDATE, -- phire_date IN employees.hire_date%TYPE DEFAULT SYSDATE,
    pjob_id IN VARCHAR2,                -- pjob_id IN employees.job_id%TYPE,
    psalary IN NUMBER,                  -- psalary IN employees.salary%TYPE,
    pcommission_pct IN NUMBER,          -- pcommission_pct IN employees.commission_pct%TYPE,
    pmanager_id IN NUMBER,              -- pmanager_id IN employees.manager_id%TYPE,
    pdepartment_id IN NUMBER)           -- pdepartment_id IN employees.department_id%TYPE)
AS -- OU IS 
/* (DECLARE) Aqui se declarararia as vari�veis. 
        Nenhuma vari�vel a declarar*/
BEGIN
    INSERT INTO employees
    (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
    VALUES
    (employees_seq.nextval, pfirst_name, plast_name, pemail, pphone_number, phire_date, pjob_id, psalary, pcommission_pct, pmanager_id, pdepartment_id);
    -- Aqui n�o � feito o COMMIT ou o ROLLBACK pois fica a cargo da fun��o chamadora, por�m pode ser posto aqui.
EXCEPTION
    WHEN OTHERS
    THEN
        RAISE_APPLICATION_ERROR (-20002, 'Erro Oracle: ' || SQLCODE || SQLERRM);
END PRC_INSERE_EMPREGADO; -- ou apenas END;
-- Quando � c�digo foi compilado � chamado de P-CODE, pois utiliza o gerenciamento de mem�ria da Oracle ganhando performance.

--  Executando a Procedure pelo Bloco PLSQL (Poderia executar outra procedure ou criar um bloco an�nimo)

BEGIN
    PRC_INSERE_EMPREGADO ('David', 'Bowie', 'DBOWIE', '515.127.4861', SYSDATE, 'IT_PROG', 15000, NULL, 103, 60);
    COMMIT;
END;

-- Consultado o empregado inserido
SELECT *
FROM employees
WHERE first_name = 'David' AND last_name = 'Bowie';

-- Executando a Procudure com o comando EXECUTE do SQL PLUS (na pr�tica n�o � muito utilizado, mas � importante conhecer, por�m � mais r�pido que o bloco an�nimo)
EXEC PRC_INSERE_EMPREGADO ('Greg', 'Lake', 'GLAKE', '515.127.4961', SYSDATE, 'IT_PROG', 15000, NULL, 103, 60);
COMMIT;
-- Por o EXEC ser um comando do SQL PLUS n�o pode estar dentro de um bloco.

-- Consultado o empregado inserido
SELECT *
FROM employees
WHERE first_name = 'Greg' AND last_name = 'Lake';

-- Se��o 14.48 - (Procedures de Banco de Dados) - Utilizando par�metros tipo IN
-- Tipos de par�metros: IN [Default Expression]. OUT [NoCOPY]. IN-OUT [NoCOPY]

-- Tipo IN
CREATE OR REPLACE PROCEDURE PRC_AUMENTA_SALARIO_EMPREGADO
    (pemployee_id IN NUMBER,
    ppercentual IN NUMBER)
AS -- ou IS
-- Nenhuma vari�vel a declarar
BEGIN
    UPDATE employees
    SET salary = salary * (1 + ppercentual/100)
    WHERE employee_id = pemployee_id;
EXCEPTION
    WHEN OTHERS
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'Erro Oracle: ' || SQLCODE || SQLERRM);
END;

-- Executando a Procedure do Bloco PL/SQL
BEGIN
    PRC_AUMENTA_SALARIO_EMPREGADO(109,10);
    COMMIT;
END;

-- Se��o 14.49 - (Procedures de Banco de Dados) - Utilizando par�metros tipo OUT e IN OUT -- Link para diferen�as IN e OUT https://riptutorial.com/plsql/example/17760/in-out-parameters
-- TIPO OUT - Copiar� o valor para uma outra �rea de mem�ria da procedure (consumindo um pouco mais de mem�ria) 
CREATE OR REPLACE PROCEDURE PRC_CONSULTA_EMPREGADO
    (pemployee_id   IN NUMBER,
    pfirst_name     OUT VARCHAR2,
    plast_name      OUT VARCHAR2,
    pemail          OUT VARCHAR2,
    pphone_number   OUT VARCHAR2,
    phire_date      OUT DATE,
    pjob_id         OUT VARCHAR2,
    psalary         OUT NUMBER,
    pcommission_pct OUT NUMBER,
    pmanager_id     OUT NUMBER,
    pdepartment_id  OUT NUMBER)
IS
-- Declarar vari�veis. Nenhuma vari�vel
BEGIN
    SELECT first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
    INTO pfirst_name, plast_name, pemail, pphone_number, phire_date, pjob_id, psalary, pcommission_pct, pmanager_id, pdepartment_id
    FROM employees
    WHERE employee_id = pemployee_id;
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'ID n�o existe: ' || TO_CHAR(pemployee_id));
    WHEN OTHERS
    THEN
        RAISE_APPLICATION_ERROR (-20002, 'Erro Oracle: ' || SQLCODE || SQLERRM);
END;

-- Executando par�metro do Tipo OUT no bloco an�nimo
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    employees_record    employees%ROWTYPE;
BEGIN
    PRC_CONSULTA_EMPREGADO (100, employees_record.first_name, employees_record.last_name,employees_record.email,
    employees_record.phone_number, employees_record.hire_date, employees_record.job_id, employees_record.salary, 
    employees_record.commission_pct, employees_record.manager_id, employees_record.department_id);
    DBMS_OUTPUT.PUT_LINE    (employees_record.first_name || ' ' ||
                            employees_record.last_name || ' - ' ||
                            employees_record.department_id || ' - ' ||
                            employees_record.job_id || ' - ' ||
                            employees_record.phone_number || ' - ' ||
                            LTRIM(TO_CHAR(employees_record.salary, '99G999G999D99')));
END;

-- Tipo OUT com NOCOPY - Referenciar� na mesma �rea de mem�ria que o programa chamador, mesmo local do IN por default.
CREATE OR REPLACE PROCEDURE PRC_CONSULTA_EMPREGADO
    (pemployee_id   IN NUMBER,
    pfirst_name     OUT NOCOPY VARCHAR2,
    plast_name      OUT NOCOPY VARCHAR2,
    pemail          OUT NOCOPY VARCHAR2,
    pphone_number   OUT NOCOPY VARCHAR2,
    phire_date      OUT NOCOPY DATE,
    pjob_id         OUT NOCOPY VARCHAR2,
    psalary         OUT NOCOPY NUMBER,
    pcommission_pct OUT NOCOPY NUMBER,
    pmanager_id     OUT NOCOPY NUMBER,
    pdepartment_id  OUT NOCOPY NUMBER)
AS -- ou IS
BEGIN
    SELECT first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
    INTO pfirst_name, plast_name, pemail, pphone_number, phire_date, pjob_id, psalary, pcommission_pct, pmanager_id, pdepartment_id
    FROM employees
    WHERE employee_id = pemployee_id;
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'Id n�o existe: ' || pemployee_id);
    WHEN OTHERS
    THEN
        RAISE_APPLICATION_ERROR (-20002, 'Erro Oracle: ' || SQLCODE || SQLERRM);
END;

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    employee_record     employees%ROWTYPE; -- pega todas as colunas da tabela
BEGIN -- CHAMAR A PROCEDURE
    PRC_CONSULTA_EMPREGADO (100, employee_record.first_name, employee_record.last_name, employee_record.email,
    employee_record.phone_number, employee_record.hire_date, employee_record.job_id, employee_record.salary,
    employee_record.commission_pct, employee_record.manager_id, employee_record.department_id);
--Chamando os seguintes valores no DBMS - first_name, last_name, department_id, job_id, phone_number, salary
    DBMS_OUTPUT.PUT_LINE    (employee_record.first_name || ' ' ||
                            employee_record.last_name || ' - ' ||
                            employee_record.department_id || ' - ' ||
                            employee_record.job_id || ' - ' ||
                            employee_record.phone_number || ' - ' ||
                            LTRIM(TO_CHAR(employee_record.salary, '99G999G999D99')));
END;

-- Se��o 14.50 - (Procedures de Banco de Dados) - M�todos de passagem de par�metros
-- 1 - M�todo Posicional. 2 - M�todo Nomeado. 3 - M�todo Combinado (Mistura dos dois). Obs: n�o � utilizado este �ltimo
/* M�todo Posicionado � quando os valores da Procedure chamadora s�o colocados na ordem que est�o os par�metros. Assim como fizemos no exemplo acima
M�todo Nomeado dentro do bloco em que chama a Procedure voc� dar� o nome do par�metro => 'O valor do par�metro' geralmente uma vari�vel. Ex: pemployee_id => vemployee_id
Dessa forma � poss�vel omitir um valor, apenas se ele tiver um valor default.
*/
-- M�todo Posicional
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    employee_record    employees%ROWTYPE;
BEGIN
    PRC_CONSULTA_EMPREGADO (100, employee_record.first_name, employee_record.last_name, employee_record.email, 
    employee_record.phone_number, employee_record.hire_date, employee_record.job_id, employee_record.salary, 
    employee_record.commission_pct, employee_record.manager_id, employee_record.department_id);
    DBMS_OUTPUT.PUT_LINE    (employee_record.first_name || ' ' ||
                            employee_record.last_name || ' - ' ||
                            employee_record.department_id || ' - ' ||
                            employee_record.job_id || ' - ' ||
                            employee_record.phone_number || ' - ' ||
                            LTRIM(TO_CHAR(employee_record.salary, '99G999G999D99')));
END;

-- M�todo Nomeado
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    vemployee_id NUMBER := 100;
    vfirst_name VARCHAR2(200);
    vlast_name VARCHAR2(200);
    vemail VARCHAR2(200);
    vphone_number VARCHAR2(200);
    vhire_date DATE;
    vjob_id VARCHAR2(200);
    vsalary NUMBER;
    vcommission_pct NUMBER;
    vmanager_id NUMBER;
    vdepartment_id NUMBER;
BEGIN
    PRC_CONSULTA_EMPREGADO  (pemployee_id => vemployee_id,
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

-- Se��o 14.51 - (Procedures de Banco de Dados) - Recompilando Procedures de Banco de Dados
-- Em uma importa��o muitas procedures e functions pode se tornar inv�lidos por causa da depend�ncias, existe um script para DBAs, mas para desenvolvedores essa aula � mais importante
ALTER PROCEDURE PRC_INSERE_EMPREGADO COMPILE;
-- Este comando � utilizado quando sua PROCEDURE est� correta, mas ela demonstra estar INVALID seja l� por qualquer motivo.

-- Se��o 14.52 - (Procedures de Banco de Dados) - Removendo Procedures de Banco de Dados
-- O comando DROP ser� removida definitivamente, �nica maneira de recuperar � por um RESTORE de um backup do banco de dados pelo DBA ou salvar a fonte da Procedure em outro ambiente
DROP PROCEDURE PRC_CONSULTA_EMPREGADO;
-- Ou abrir a aba PROCEDURES seleciona a procedure que queira deletar, bot�o direito do mouse e ELIMINAR
-- Depois da execu��o foi recriado a procedure.

-- Se��o 15.53 - (Fun��es de Banco de Dados) - Criando Fun��es de Banco de Dados
CREATE OR REPLACE FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO
    (pemployee_id IN NUMBER)
    RETURN NUMBER -- Retornar o tipo do valor
AS
    vsalary employees.salary%TYPE;
BEGIN
    SELECT salary
    INTO vsalary
    FROM employees
    WHERE employee_id = pemployee_id;
    
    RETURN (vsalary); -- Dentro do Begin retornar a vari�vel do valor
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'ID n�o existe');
    WHEN OTHERS 
    THEN
        RAISE_APPLICATION_ERROR (-20002, 'Erro Oracle: ' || SQLCODE || SQLERRM);
END;

-- Executando a fun��o no bloco SQL
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT pemployee_id PROMPT 'Digite do ID do empregado'
DECLARE
    vemployee_id    employees.employee_id%TYPE := &pemployee_id;
    vsalary         employees.salary%TYPE;
BEGIN
    vsalary := FNC_CONSULTA_SALARIO_EMPREGADO (vemployee_id); -- Retorno da fun��o ser� a uma vari�vel
    DBMS_OUTPUT.PUT_LINE('Sal�rio: ' || vsalary);
END;

-- Se��o 15.54 - (Fun��es de Banco de Dados) - Utilizando Fun��es em comandos SQL
-- Usando a tabela JOBS agora
CREATE OR REPLACE FUNCTION FNC_CONSULTA_TITULO_CARGO_EMPREGADO
    (pjob_id IN VARCHAR2) 
    RETURN VARCHAR2 -- porque job_id � varchar2
IS
    vjob_title jobs.job_title%TYPE;
BEGIN
    SELECT job_title
    INTO vjob_title
    FROM jobs
    WHERE job_id = pjob_id;
    
    RETURN (vjob_title);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'JOB N�O EXISTE');
    WHEN OTHERS
    THEN
        RAISE_APPLICATION_ERROR (-20002, 'Erro Oracle: ' || SQLCODE || SQLERRM);
END;

-- Utilizando Fun��es em SQL
SELECT employee_id, first_name, last_name, job_id, FNC_CONSULTA_TITULO_CARGO_EMPREGADO(job_id) "JOB TITLE"
FROM employees;
-- Obs: Com Join teria uma maior performance, pois toda vez que fizer do modo acima ele faria um SELECT

-- Executando a Fun��o pelo comando SQL
SELECT FNC_CONSULTA_TITULO_CARGO_EMPREGADO('IT_PROG')
FROM dual; -- � uma tabela existente em qualquer tabela de banco de dados ORacle e s� possui uma linha

-- OU
SELECT FNC_CONSULTA_SALARIO_EMPREGADO(130)
FROM dual;

-- Se��o 15.55 - (Fun��es de Banco de Dados) - Recompilando Fun��es de Bancos de Dados
ALTER FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO COMPILE;

-- Se��o 15.56 - (Fun��es de Banco de Dados) - Removendo Fun��es de Bancos de Dados
DROP FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO;

-- Se��o 16.57 - Gerenciando Procedures e Functions (user_objects, all_objects e user_source)
-- Consultado objetos tipo Procedure e Function do seu Usu�rio
DESC USER_OBJECTS;

SELECT object_name, object_type, last_ddl_time, timestamp, status
FROM user_objects
WHERE object_type IN ('PROCEDURE', 'FUNCTION');

SELECT object_name, object_type, last_ddl_time, timestamp, status
FROM all_objects -- Al�m do meu usu�rio, objetos com privil�gios. Dentre eles do pr�prio Oracle
WHERE object_type IN ('PROCEDURE', 'FUNCTION');

-- Consultar objetos com status INVALID
SELECT object_name, object_type, last_ddl_time, timestamp, status
FROM user_objects
WHERE status = 'INVALID';

-- Consultando o C�digo Fonte de Procedures e Fun��es do seu usu�rio
DESC USER_SOURCE;

-- Selecionar uma Procedure
SELECT line, text
FROM user_source
WHERE   name = 'PRC_INSERE_EMPREGADO' AND 
        type = 'PROCEDURE'
ORDER BY line;

-- Selecionar uma Function
SELECT line, text
FROM user_source
WHERE   name = 'FNC_CONSULTA_SALARIO_EMPREGADO' AND 
        type = 'FUNCTION'
ORDER BY line;

-- Consultar a lista de par�metros de Procedure e Fun��es
DESC PRC_INSERE_EMPREGADO;
DESC FNC_CONSULTA_SALARIO_EMPREGADO;
--Obs: ou no pr�prio c�digo fonte

-- Consultando erros de compila��o (J� � mostrado os erros quando se compila o programa)
-- Existem USER_ERRORS, ALL_ERRORS e DBA_ERRORS - Dicion�rio de Dados
SHOW ERRORS PROCEDURE PRC_INSERE_EMPREGADO;
SHOW ERRORS FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO;
-- SHOW ERRORS PACKAGE nome_da_package;

DESC user_errors;
-- Simulando como aparece os erros na descri��o
COLUMN postion FORMAT a4 -- Column � um comando do SQL PLUS para formatar a sa�da, formato alfanum�rico de 4 dig�tos
COLUMN text FORMAT a60 -- alfanum�rico 60 d�gitos
SELECT line ||'/'|| position position, text -- seleciona a linha, com a posi��o e colocar� um alias position
FROM user_errors
WHERE name = 'FNC_CONSULTA_SALARIO_EMPREGADO'
ORDER BY line;
-- S� ser� necess�rio o Show ERROS caso esteja compilando no SQL PLUS por exemplo, o SQL Developer traz os erros de maneira autom�tica

-- Se��o 17.58 - Gerenciando Depend�ncias de Objetos
-- Tipos de consultas de depend�ncias. USER_DEPENDENCIES, ALL_DEPENDENCIES e DBA_DEPENDENCIES

DESC user_dependencies;

-- Consulta apenas as depend�ncias diretas
SELECT *
FROM user_dependencies
WHERE   referenced_name = 'EMPLOYEES' AND
        referenced_type = 'TABLE';
        
-- Consultar as depend�ncias diretas e indiretas dos objetos do seu schema
SELECT      *
FROM        user_dependencies
START WITH  referenced_name = 'EMPLOYEES' AND
            referenced_type = 'TABLE'
CONNECT BY PRIOR    name = referenced_name AND
                    type = referenced_type;
-- Obs: a cl�usula CONNECT BY PRIOR far� um SQL hier�rquico. No nosso exemplo n�o temos nenhuma depend�ncia direta, por isso mostra a mesma quantidade de itens.

-- Consultar depend�ncias Diretas e Indiretas dos objetos de todos os schemas usando DBA_Dependencies
DESC DBA_DEPENDENCIES; -- feita a consulta na conex�o sys_XEPEDB1, pois aqui n�o existe esta permiss�o

-- Para verificar se existe algum status inv�lido
DESC USER_OBJECTS;
SELECT object_name, object_type, last_ddl_time, timestamp, status
FROM user_objects
WHERE status = 'INVALID';

-- Se��o 17.59 - (Gerenciando Depend�ncias de Objetos) - Utilizando as Vis�es DEPTREE e IDEPTREE

-- Executando o script UTLDTREE
@C:\app\kaio_\product\18.0.0\dbhomeXE\rdbms\admin\utldtree.sql -- Utilizar o caminho da sua instala��o pessoal
-- Obs: sempre para executar um script � preciso do @ e o caminho do script

-- Executando a procedure DEPTREE_FILL
exec DEPTREE_FILL ('TABLE', 'HR', 'EMPLOYEES'); -- Lembrando exec � um comando do SQL PLUS

-- Utilizando as Vis�es DEPTREE (a deptree mostra os n�veis com o n�mero das depend�ncias)
DESC deptree;

SELECT *
FROM deptree
ORDER BY seq#; -- Sempre usar com o ORDER BY seq# para ficar na ordem correta
-- Tudo que for n�vel 1, ou seja, os objetos n�vel 1 tem depend�ncia sobre o NESTED_LEVEL 0 e a n�vel 2 seria depend�ncia indireta neste caso

-- Utilizando as VIS�ES IDEPTREE (mostrar� as depend�ncias por meio da identa��o e tabula��o)
DESC ideptree;

SELECT *
FROM ideptree;
-- Tudo que est� tabulado a direita tem depend�ncia direta da tabela EMPLOYEES, mais ainda a direita seria depend�ncia indireta

-- Se��o 18.60 - (Gerenciando Depend�ncias de Objetos) - Debugando Procedures e Functions
/* 1� passo: editar a fun��o ou procedure desejada para debug, neste caso ser� a fun��o FNC_CONSULTA_SALARIO_EMPREGADO
2� passo: criar um breakpoint - em portugu�s estar� como alternador ponto de interrup��o - e compilar para depura��o (debug)
3� passo: Passar os privil�gios pelo o SYS_XEPDB1 (DEBUG CONNECT SESSION, DEBUG ANY PROCEDURE to hr;) para evitar os seguintes erros ORA-01031 - privi�gios insuficientes. 
4� passo: habilitar o acesso a permiss�o do JDWP atrav�s de uma ACL (acess control list) para conseguir se comunicar entre a sess�o do banco e a minha m�quina sem a ORACLE entender como invas�o.
5� passo: executar o seguinte bloco an�nimo conectado como SYS. Feito na aba sys_XEPDB1
6� passo: abrir a fun��o - editar e clicar na joaninha (depurar) e montar� um bloco an�nimo e no meu caso trocar o valor do ID NULL por um valor existente
*/

-- Se��o 19.61 - (Packages de Banco de Dados) - Conceito
/* Vantagens � a organiza��o para o mesmo tipo de procedures e functions e a outra vantagem � o ganho de performance com a package carregada na mem�ria
Componentes (constru��es) de uma package: vari�vel, constante, cursor, exce��o, procedure e fun��o
Package Specification ser� de informa��es p�blicas e a Package Body ser� de informa��es privadas
*/

-- Se��o 19.62 - (Packages de Banco de Dados) - Criando o Package Specification
-- Obs: todas as procedures e functions feitos pelo Package Specification s�o p�blicas, ent�o poderei referenci�-las fora da Package
CREATE OR REPLACE PACKAGE PCK_EMPREGADOS    
IS
    gMinSalary      employees.salary%TYPE; -- Lembrando que ao criar uma vari�vel na PACKAGE SPECIFICATION ela ser� global
    
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
    
    PROCEDURE PRC_AUMENTA_SALARIO_EMPREGADO(
        pemployee_id IN NUMBER,
        ppercentual IN NUMBER);
    
    FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO (
        pemployee_id IN NUMBER)
        RETURN NUMBER;
END PCK_EMPREGADOS; -- Poderia colocar s� END, mas como foi o primeiro exemplo achei melhor assim
    
-- Se��o 19.63 - (Packages de Banco de Dados) - Criando o Package Body
-- Para criar o Package Body � preciso ter criado antes o Package Specification e cri�-lo com o mesmo nome
/* Todas as declara��es de vari�veis, contantes, cursores, exce��es, procedures e fun��es ser�o privadas dentro dessa package
e o corpo de fun��es e/ou procedures ser�o colocados todo o c�digo tanto da p�blica quanto privada */

CREATE OR REPLACE PACKAGE BODY PCK_EMPREGADOS
-- Nenhum par�metro pois � uma package
IS
-- Nenhuma vari�vel a declarar
    PROCEDURE PRC_INSERE_EMPREGADO ( -- N�o se escreve Create or Replace Procedure, pois est� dentro da Package, apenas o corpo da Procedure
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
-- Obs: tem que ser exatamente igual a assinatura (par�metros) do package specification no package body
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
-- Terminando o corpo dessa PROCEDURE, inicio da outra Procedure que coloquei no PACKAGE SPECIFICATION 
    PROCEDURE PRC_AUMENTA_SALARIO_EMPREGADO (
        pemployee_id IN NUMBER,
        ppercentual IN NUMBER)
    IS
    -- Nenhuma vari�vel a declarar
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
        vsalary     employees.salary%TYPE;
    BEGIN
        SELECT vsalary
        INTO vsalary
        FROM employees
        WHERE pemployee_id = employee_id;
        
        RETURN (vsalary);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR (-20001, 'ID n�o existe');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20002, 'Erro Oracle: ' || SQLCODE || SQLERRM);
        END;
END PCK_EMPREGADOS;

-- Se��o 19.64 - (Packages de Banco de Dados) - Referenciando Componentes de uma Package
-- Bloco an�nimo
BEGIN
    PCK_EMPREGADOS.PRC_INSERE_EMPREGADO ('John', 'Lennon', 'JLENNON', '515.244.4861', SYSDATE, 'IT_PROG', 15000, NULL, 103, 60);
    COMMIT; -- apesar do Commit ser da fun��o do programa chamador
END;
-- Como eu tenho as Procedures dentro da Package agora, o ideal � remover as procedures e functions para n�o ter objetos repetidos e ter� que dar manuten��o em dois, mas ser� mantido apenas por motivos de did�ticas.

-- Se��o 19.65 - (Packages de Banco de Dados) - Procedimento de uma �nica execu��o na Se��o & Debuger
-- Dentro de um package body o que estiver no final entre o Begin e o End Package ser� sua �nica execu��o
CREATE OR REPLACE PACKAGE BODY PCK_EMPREGADOS
-- Nenhum par�metro pois � uma package
IS
-- Nenhuma vari�vel a declarar
    PROCEDURE PRC_INSERE_EMPREGADO ( -- N�o se escreve Create or Replace Procedure, pois est� dentro da Package, apenas o corpo da Procedure
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
-- Obs: tem que ser exatamento igual a assinatura (par�metros) do package specification no package body
    IS
    BEGIN
        IF psalary < PCK_EMPREGADOS.gMinSalary THEN -- Dentro da packagen�o � necess�rio preficar com PCK_EMPREGADOS, mas recomenda-se por boa pr�tica
            RAISE_APPLICATION_ERROR (-20002, 'Sal�rio n�o pode ser inferior ao menor sal�rio dos empregados');
        END IF;
            INSERT INTO employees   (employee_id, first_name, last_name, email, phone_number, hire_date,
                                     job_id, salary, commission_pct, manager_id, department_id)
            VALUES (employees_seq.nextval, pfirst_name, plast_name, pemail, pphone_number, phire_date,
                    pjob_id, psalary, pcommission_pct, pmanager_id, pdepartment_id);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20001, 'Erro Oracle: ' || SQLCODE || SQLERRM);
    END;
-- Terminando o corpo dessa PROCEDURE, inicio da outra Procedure que coloquei no PACKAGE SPECIFICATION 
    PROCEDURE PRC_AUMENTA_SALARIO_EMPREGADO (
        pemployee_id IN NUMBER,
        ppercentual IN NUMBER)
    IS
    -- Nenhuma vari�vel a declarar
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
        vsalary     employees.salary%TYPE;
    BEGIN
        SELECT vsalary
        INTO vsalary
        FROM employees
        WHERE pemployee_id = employee_id;
        
        RETURN (vsalary);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR (-20001, 'ID n�o existe');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20002, 'Erro Oracle: ' || SQLCODE || SQLERRM);
        END;
-- At� aqui tudo igual
-- Neste ponto abaixo ser� criado a execu��o de uma �nica execu��o
BEGIN
    SELECT MIN(salary)
    INTO PCK_EMPREGADOS.gMinSalary
    FROM employees;
END PCK_EMPREGADOS;
-- A Oracle executar� primeiramente esse procedimento de uma �nica execu��o, antes mesmo de qualquer function ou procedure acima
-- Mas lembre-se apenas na primeira vez que a package for referenciada, a partir das pr�ximas n�o far� mais isso. 
-- No exemplo acima veio a calhar, pois j� teria a informa��o de qual o menor valor do sal�rio

-- Se��o 19.66 - (Packages de Banco de Dados) - Recompilando uma Package

-- Recompilando package specification
ALTER PACKAGE PCK_EMPREGADOS COMPILE SPECIFICATION;

-- Recompilando package body
ALTER PACKAGE PCK_EMPREGADOS COMPILE BODY;

-- Se��o 19.67 - (Packages de Banco de Dados) - Removendo uma Package

-- Para remover package body
DROP PACKAGE BODY PCK_EMPREGADOS;

-- Para remover ambos, package body e specification
DROP PACKAGE PCK_EMPREGADOS;

-- Se��o 20.69 - (Database DML Triggers)
/* S�o divididos em tr�s elementos: tempo, evento e tipo.
1 - Tempo: BEFORE (antes), AFTER (depois) e INSTEAD OF (ao inv�s de)
2 - Evento: INSERT, UPDATE, DELETE
3 - Tipo: STATEMENT (n�vel de comando - padr�o) e FOR EACH ROW n�vel de linha
Sendo poss�vel 18 combina��es
*/

-- Se��o 20.70 - (Database DML Triggers) - Triggers a n�vel de comando
-- Primeiro passo: create or replace trigger depois escolher o tempo, ap�s isso o evento
-- Obs: � poss�vel criar mais de um evento para a Trigger utilizando OR

CREATE OR REPLACE TRIGGER B_I_EMPLOYEES_S_TRG -- B de before. I de Insert _nome da tabela. S de Statement. TRG Trigger 
BEFORE INSERT
ON EMPLOYEES
BEGIN
    IF (TO_CHAR(SYSDATE, 'DAY') IN ('SABADO', 'DOMINGO') OR
        TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) NOT BETWEEN 8 AND 18)
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'O cadastramento de empregados s� � permitido dentro do hor�rio comercial');
    END IF;
END;

-- Testando a valida��o da Trigger
BEGIN  
    PCK_EMPREGADOS.PRC_INSERE_EMPREGADO ('George', 'Harrison', 'GHARRISSON', '515.258.5690', SYSDATE, 'IT_PROG', 25000, NULL, 103, 60);
    COMMIT;
END;

-- Criando uma Trigger com v�rios eventos
CREATE OR REPLACE TRIGGER B_IUD_VALIDA_HORARIOS_EMPLOYEES_S_TRG
BEFORE INSERT OR UPDATE OR DELETE
ON employees
BEGIN
    IF (TO_CHAR(SYSDATE, 'DAY') IN ('SABADO', 'DOMINGO') OR
        TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) NOT BETWEEN 8 AND 18)
    THEN
        CASE
            WHEN INSERTING
            THEN
                RAISE_APPLICATION_ERROR (-20001, 'O cadastramento do empregado s� � permitido em dias de semana dentro do hor�rio comercial');
            WHEN DELETING
            THEN
                RAISE_APPLICATION_ERROR (-20002, 'A dele��o do empregado s� � permitido em dias de semana dentro do hor�rio comercial');
            ELSE
                RAISE_APPLICATION_ERROR (-20003, 'A atualiza��o de Empregaods do empregado s� � permitido em dias de semana dentro do hor�rio comercial');
            END CASE;
    END IF;
END;

-- Removerei a primeira trigger para n�o ter duas fazendo a mesma coisa
DROP TRIGGER B_I_EMPLOYEES_S_TRG;

-- Se��o 20.71 - (Database DML Triggers) - Triggers a n�vel de linha
-- Somente com triggers a n�vel de linha eu posso adicionar a cl�usula WHEN

-- Esse caso apenas se j� houver feito o teste anteriormente ou caso queira repeti-lo da Trigger a n�vel de linha
DROP TABLE employees_log;

-- Tabela de log de auditoria
create table employees_log 
    (employees_log_id NUMBER(11) NOT NULL,
    dt_log DATE DEFAULT SYSDATE NOT NULL,
    usuario VARCHAR2(30),
    evento char(1) NOT NULL, -- 1, pois ser� condiciona I = insert, U = update, D = delete 
    employee_id NUMBER(6) NOT NULL,
    salary_old NUMBER(8,2), -- neste caso, ser� o log da altera��o do sal�rio, poderia utilizar v�rias outras colunas, mas ser� apenas sal�rio por praticidade
    salary_new NUMBER (8,2));

-- Definir a Primary Key
ALTER TABLE employees_log
ADD CONSTRAINT employees_log_pk PRIMARY KEY (employees_log_id);

-- Criar uma sequ�ncia para employees_log_id, a primary key
CREATE SEQUENCE employees_log_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE
NOMAXVALUE;

-- Criando uma Trigger que gera Log de Auditoria para a Tabela Employees e a coluna Salary
CREATE OR REPLACE TRIGGER A_IUD_EMPLOYEES_R_TRG -- After pois o log preciso saber depois que aconteceu
    AFTER INSERT OR UPDATE OF SALARY OR DELETE
    ON EMPLOYEES
    FOR EACH ROW -- log ser� por n�vel de linha, pois preciso saber cada altera��o da tabela employees
DECLARE
    vevento         employees_log.evento%TYPE;
    vemployee_id    employees_log.employee_id%TYPE;
BEGIN
    CASE
        WHEN INSERTING THEN
            vevento         := 'I';
            vemployee_id    := :new.employee_id; -- apenas terei valor no new, pois no old n�o tinha nada antes da inser��o
        WHEN UPDATING THEN
            vevento         := 'U';
            vemployee_id    := :new.employee_id; -- aqui old ou new ter� o mesmo resultado pois ser� um update after
        ELSE
            vevento         := 'D';
            vemployee_id    := :old.employee_id; -- no delete apenas no old, pois se foi deletado n�o ter� nada novo
    END CASE;

    INSERT INTO employees_log
        (employees_log_id, dt_log, usuario, evento, employee_id, salary_old, salary_new)
    VALUES
        (employees_log_seq.nextval, SYSDATE, USER, vevento, vemployee_id, :old.salary, :new.salary);
END A_IUD_EMPLOYEES_R_TRG;

-- Testando o disparo da Trigger
UPDATE employees
SET salary = salary * 1.5;

-- Consultando a tabela employees_log
SELECT *
FROM employees_log;

COMMIT;

-- Limpar o log para poder executar novamente a TRIGGER abaixo com a cl�usula WHEN
DELETE FROM employees_log;
COMMIT;
drop trigger A_IUD_EMPLOYESS_R_TRG;
-- Exemplo com a Cl�usulia WHEN
CREATE OR REPLACE TRIGGER A_IUD_EMPLOYEES_R_TRG -- After pois o log preciso saber depois que aconteceu
    AFTER INSERT OR UPDATE OF SALARY OR DELETE
    ON EMPLOYEES
    FOR EACH ROW -- log ser� por n�vel de linha, pois preciso saber cada altera��o da tabela employees
    WHEN (new.job_id <> 'AD_PRES') -- S� ser� executado o bloco quando passar por esse WHEN, ou seja, n�o ter� log no presidente da empresa
    --  New n�o � bind :new porque est� fora do bloco BEGIN
DECLARE
    vevento         employees_log.evento%TYPE;
    vemployee_id    employees_log.employee_id%TYPE;
BEGIN
    CASE
        WHEN INSERTING THEN
            vevento         := 'I';
            vemployee_id    := :new.employee_id; -- apenas terei valor no new, pois no old n�o tinha nada antes da inser��o
        WHEN UPDATING THEN
            vevento         := 'U';
            vemployee_id    := :new.employee_id; -- aqui old ou new ter� o mesmo resultado pois ser� um update after
        ELSE
            vevento         := 'D';
            vemployee_id    := :old.employee_id; -- no delete apenas no old, pois se foi deletado n�o ter� nada novo
    END CASE;
    
    INSERT INTO employees_log
        (employees_log_id, dt_log, usuario, evento, employee_id, salary_old, salary_new)
    VALUES
        (employees_log_seq.nextval, SYSDATE, USER, vevento, vemployee_id, :old.salary, :new.salary);
END A_IUD_EMPLOYEES_R_TRG;

-- Se��o 20.72 - (Database DML Triggers) - Mutating Tables
/* Regra 1 de Mutating Tables: n�o altere dados em colunas de chaves prim�rias, chaves estrangeiras 
ou chaves �nicas de tabelas relacionadas �quela na qual a trigger disparada est� associada.
Em resumo: usar o UPDATE dentro da Trigger causar� MUTATING TABLE
*/

-- Email � unique, ent�o estamos for�ando a dar erro na regra de Mutating Tables e n�o existe corre��o por violar a regra de mutante. Uma op��o seria retirar a trigger
CREATE OR REPLACE TRIGGER A_I_EMPLOYEES_R_TRG
AFTER INSERT
ON EMPLOYEES
FOR EACH ROW
BEGIN
    UPDATE employees
    SET email = UPPER(SUBSTR(:new.first_name, 1, 1) || :new.last_name) -- Escolher� a primeira letra do first_name
    WHERE employee_id = :new.employee_id;
END;

-- Testando Viola��o da Regra
SET VERIFY OFF
BEGIN
    PRC_INSERE_EMPREGADO ('Eric', 'Clapton', 'ECLAPTON', '515.188.4861', SYSDATE, 'IT_PROG', 15000, NULL, 103, 60);
END;

-- Corrigindo a Trigger que n�o viola a regra
CREATE OR REPLACE TRIGGER B_I_EMPLOYEES_R_TRG
BEFORE INSERT
ON employees
FOR EACH ROW
BEGIN
    :new.email := UPPER(SUBSTR(:new.first_name, 1, 1) || UPPER(:new.last_name));
END;

-- Testando a corre��o da Viola��o da Regra
SET VERIFY OFF
BEGIN
    PRC_INSERE_EMPREGADO ('Eric', 'Clapton', 'ECLAPTON', '515.188.4861', SYSDATE, 'IT_PROG', 15000, NULL, 103, 60);
COMMIT;
END;


-- Viola��o da Regra 2 de Mutating Table
/* N�o leia informa��es da tabela que estejam sendo modificada
Em resumo: usar SELECT dentro da trigger causar� MUTATING TABLE
*/

CREATE OR REPLACE TRIGGER B_U_VALIDADE_SALARY_EMPLOYEES_R_TRG
BEFORE UPDATE OF salary
ON employees
FOR EACH ROW
DECLARE
    vMaxSalary  employees.salary%TYPE;
BEGIN
    SELECT MAX(salary)
    INTO vMaxSalary
    FROM employees;
    
    IF :new.salary > vMaxSalary * 1.2
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'Sal�rio n�o pode ser superior ao maior salario + 20%');
    END IF;
END;

-- Testando Viola��o da Regra 2
SET VERIFY OFF
UPDATE employees
SET salary = 70000
WHERE employee_id = 100;
COMMIT;

-- Resolvendo o problema de Mutating Tables. Um exemplo...
CREATE OR REPLACE PACKAGE PCK_EMPLOYEES_DADOS
AS
    TYPE max_salary_table_type IS TABLE OF NUMBER(10,2)
    INDEX BY BINARY_INTEGER;
    
    gMaxSalary max_salary_table_type; -- vari�vel global
END PCK_EMPLOYEES_DADOS;

-- Por estar usando a n�vel de comando e n�o utilizar DELETE CASCADE n�o ter� problemas de Mutating Table
CREATE OR REPLACE TRIGGER B_IU_VALIDATE_SALARY_EMPLOYEES_S_TRG 
BEFORE INSERT OR UPDATE OF salary
ON employees
DECLARE
    vmax_salary employees.salary%TYPE;
BEGIN
    SELECT MAX(salary)
    INTO PCK_EMPLOYEES_DADOS.gMaxSalary(1)
    FROM employees;
END;

CREATE OR REPLACE TRIGGER B_IU_VALIDADE_SALARY_EMPLOYEES_R_TRG
BEFORE INSERT OR UPDATE OF salary
ON employees
FOR EACH ROW
DECLARE
    vMaxSalary  employees.salary%TYPE;
BEGIN
    IF :new.salary > PCK_EMPLOYEES_DADOS.gMaxSalary(1) * 1.2
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'Novo sal�rio n�o pode ser superior ao maior sal�rio + 20%');
    END IF;
END;

-- Testando Viola��o da Regra 2 com novas solu��es
SET VERIFY OFF
UPDATE employees
SET salary = 30000
WHERE employee_id = 100;
COMMIT;

-- Se��o 20.73 - (Database DML Triggers) - Desabilitando e habilitando DATABASE DML TRIGGERS
/* Desabilitar ALTER TRIGGER nome_trigger DISABLE
Habilitar ALTER TRIGGER nome_trigger ENABLE
Todas as tabelas:
Desabilitar: ALTER TABLE nome_da_tabela DISABLE ALL TRIGGERS
Habilitar: ALTER TABLE nome_da_tabela ENABLE ALL TRIGGERS
*/

-- Desabilitando Trigger
ALTER TRIGGER B_IUD_VALIDA_HORARIOS_EMPLOYEES_S_TRG DISABLE;

-- Habilitando Trigger
ALTER TRIGGER B_IUD_VALIDA_HORARIOS_EMPLOYEES_S_TRG ENABLE;

-- Desabilitando todas as Triggers
ALTER TABLE employees DISABLE ALL TRIGGERS;

-- Habilitando todas as Triggers
ALTER TABLE employees ENABLE ALL TRIGGERS;

-- Se��o 20.74 - (Database DML Triggers) - Consultando Database DML Triggers pelo Dicion�rio de Dados
-- Vis�es dos dicion�rios de dados: USER_TRIGGERS (usu�rio que est� conectado), ALL_TRIGGERS (seu usu�rio e os seus objetos com privil�gios) e DBA_TRIGGERS (todas as triggers do banco)

SELECT *
FROM user_triggers
WHERE   table_name = 'EMPLOYEES' AND 
        table_owner = 'HR';
        
-- Se��o 20.75 - (Database DML Triggers) - Removendo uma DATABASE DML TRIGGER
-- DROP TRIGGER nome_da_trigger;
DROP TRIGGER B_IUD_VALIDA_HORARIOS_EMPLOYEES_S_TRG;

-- Obs: Se��o 21 e 22 repetiu as aulas de instala��o do SQLDEVELOPER e configura��o do SYS e HR

-- Entramos no curso de PL/SQL avan�ado
-- Se��o 23.82 - (SYS_REFCURSOR) - Utilizando o Cursor Fraco padr�o do PL/SQL SYS_REFCURSOR
CREATE OR REPLACE PROCEDURE PRC_CURSOR_EMPLOYEES
    (pemployees_cursor OUT SYS_REFCURSOR)
IS
BEGIN
    OPEN pemployees_cursor
    FOR
        SELECT first_name, last_name
        FROM employees;
END PRC_CURSOR_EMPLOYEES;

-- Procedure referenciando o Par�metro OUT SYS_REFCURSOR
CREATE OR REPLACE PROCEDURE PRC_DISPLAY_EMPLOYEES
IS
    employees_cursor    SYS_REFCURSOR;
    vfirst_name         employees.first_name%TYPE;
    vlast_name          employees.last_name%TYPE;
BEGIN
    PRC_CURSOR_EMPLOYEES(employees_cursor);
    
    LOOP
        FETCH employees_cursor
        INTO vfirst_name, vlast_name;
        EXIT WHEN employees_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE (vfirst_name || ' ' || vlast_name);
    END LOOP;
    
    CLOSE employees_cursor;
END PRC_DISPLAY_EMPLOYEES;

-- Executando a Procedure PRC_DISPLAY_EMPLOYEES
SET SERVEROUTPUT ON
SET VERIFY OFF
exec PRC_DISPLAY_EMPLOYEES;

-- Vari�vel Cursor e Reference Cursor agora em uma function
CREATE OR REPLACE FUNCTION FNC_GET_EMPLOYEES
    (pemployee_id IN NUMBER)
    RETURN SYS_REFCURSOR
IS
    employees_cursor    SYS_REFCURSOR;
BEGIN
    OPEN employees_cursor
    FOR
        SELECT first_name, last_name
        FROM employees
        WHERE employee_id = pemployee_id;
    RETURN employees_cursor;
END FNC_GET_EMPLOYEES;

-- Referenciando a Fun��o
CREATE OR REPLACE PROCEDURE PRC_DISPLAY_EMPLOYEES2 -- Referenciando a fun��o FNC_GET_EMPLOYEES
    (pemployee_id IN NUMBER)
IS
    employees_cursor    SYS_REFCURSOR;
    vfirst_name         employees.first_name%TYPE;
    vlast_name          employees.last_name%TYPE;
BEGIN
    employees_cursor := FNC_GET_EMPLOYEES(pemployee_id);
    
    LOOP
        FETCH employees_cursor
        INTO  vfirst_name, vlast_name;
        EXIT WHEN   employees_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE (vfirst_name || ' ' || vlast_name);
    END LOOP;
    CLOSE employees_cursor;
END PRC_DISPLAY_EMPLOYEES2;

-- Executando a Procedure
SET SERVEROUTPUT ON
SET VERIFY OFF
EXEC PRC_DISPLAY_EMPLOYEES2(100);

-- Se��o 24.83 - (BULK COLLECT) - Bulk Collect
/* Imagem do Diagrama PL/SQL. O ENGINE PL/SQL trabalha com um bloco(PL/SQL Block) que encaminha para um executor (PL/SQL Statement Executor) e h� tamb�m a Engine para apenas o SQL
Essa troca chama Switch Context (PL/SQL para SQL e vice-versa) e muitas trocas traz um problema de performance
A cl�usula BULK COLLECT INTO � uma estrutura PL/SQL e dessa forma ser� carregada como Engine PL/SQL evitando a troca para a Engine SQL e h� uma outra forma com Cursor que verei adiante 
Obs: Cuidado com o uso do SELECT * se seu servidor possuir milhares ou milh�es de registros, pois sobrecarregar� o servidor com o uso de muita mem�ria. Uma corre��o para isso � o Bulk Collect com For ALL e Limit ou Cursor � mais recomendado*/

-- 24.84 at� 24.87 ser� uma revis�o, apenas a teoria foi melhor implementada do 24.83 o restante � igual a Se��o 11
-- Se��o 24.84 - (BULK COLLECT) - Associative Array of Records
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    TYPE employees_table_type IS TABLE OF employees%ROWTYPE
    INDEX BY BINARY_INTEGER;
    employees_table employees_table_type;
BEGIN
    SELECT *
        BULK COLLECT INTO employees_table
    FROM employees;
    FOR i IN employees_table.first..employees_table.last LOOP
        DBMS_OUTPUT.PUT_LINE (  employees_table(i).employee_id || ' - ' ||
                                employees_table(i).first_name || ' ' || 
                                employees_table(i).last_name || ' - ' ||
                                employees_table(i).phone_number || ' - ' ||
                                employees_table(i).job_id || ' - ' ||
                                LTRIM(TO_CHAR(employees_table(i).salary, '99G999G999D99')));
    END LOOP;
END;

-- Se��o 24.85 - (BULK COLLECT) - Nested Table of Records
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    TYPE employees_table_type IS TABLE OF employees%ROWTYPE;
    employees_table employees_table_type := employees_table_type();
BEGIN
    SELECT *
        BULK COLLECT INTO employees_table
    FROM employees;
    
    FOR i IN employees_table.first..employees_table.last 
    LOOP
         DBMS_OUTPUT.PUT_LINE (  employees_table(i).employee_id || ' - ' ||
                                employees_table(i).first_name || ' ' || 
                                employees_table(i).last_name || ' - ' ||
                                employees_table(i).phone_number || ' - ' ||
                                employees_table(i).job_id || ' - ' ||
                                LTRIM(TO_CHAR(employees_table(i).salary, '99G999G999D99')));
    END LOOP;
END;

-- Se��o 24.86 - (BULK COLLECT) - Varray Records
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    TYPE employees_table_type IS VARRAY(200) OF employees%ROWTYPE;
    employees_table employees_table_type := employees_table_type();
BEGIN
    SELECT *
        BULK COLLECT INTO employees_table
    FROM employees;
    
    FOR i IN employees_table.first..employees_table.last 
    LOOP
         DBMS_OUTPUT.PUT_LINE (  employees_table(i).employee_id || ' - ' ||
                                employees_table(i).first_name || ' ' || 
                                employees_table(i).last_name || ' - ' ||
                                employees_table(i).phone_number || ' - ' ||
                                employees_table(i).job_id || ' - ' ||
                                LTRIM(TO_CHAR(employees_table(i).salary, '99G999G999D99')));
    END LOOP;
END;

-- Se��o 24.87 - (BULK COLLECT) - M�todos para controlar Collections (aula repetida 11.39)

-- Obs: fim da revis�o

-- Se��o 25.88 - (BULK COLLECT) - Bulk Collect e FOR ALL
/* Serve para diminuir significantemente a troca de contexto (Context Switch). Da seguinte forma:
o FOR all empacota todas as atualiza��es das linhas DML de uma Collection como um �nico context switch */