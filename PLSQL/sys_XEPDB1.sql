-- Se��o 17.58 - Gerenciando Depend�ncias de Objetos

-- Consultar depend�ncias Diretas e Indiretas dos objetos de todos os schemas usando DBA_Dependencies
DESC DBA_DEPENDENCIES; -- H� o OWNER do objeto a mais

-- Consulta mais completa para as depend�ncias
SELECT *
FROM dba_dependencies
START WITH  referenced_owner = 'HR' AND
            referenced_name = 'EMPLOYEES' AND
            referenced_type = 'TABLE'
CONNECT BY PRIOR    owner = referenced_owner AND
                    name = referenced_name AND
                    type = referenced_type;
                    
-- Se��o 17.59 - (Gerenciando Depend�ncias de Objetos) - Debugando Procedures e Functions
grant DEBUG CONNECT SESSION, DEBUG ANY PROCEDURE to hr;

-- Utilizando o 5� passo.
BEGIN
    DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE
    (
    host => '127.0.0.1',
    lower_port => null,
    upper_port => null,
    ace => xs$ace_type(privilege_list => xs$name_list('jdwp'),
    principal_name => 'hr',
    principal_type => xs_acl.ptype_db)
    );
END;
-- Permiss�o concedida para debugar pelo HR

-- Se��o 29.95 - (Package DBMS_SCHEDULER) - Criando um Programa 
-- Dando permiss�o para a cria��o de Jobs
grant CREATE JOB to HR;

-- Se��o 29.97 - (Package UTL_FILE) - Ler e Gravar Arquivos
-- Permiss�o para acesso ao C:\Files que ser� nosso servidor local

CREATE OR REPLACE DIRECTORY Arquivos AS 'C:\Files';
GRANT READ, WRITE ON DIRECTORY Arquivos TO hr;

-- Se��o 31.99 - (Package FLASHBACK) - DBMS_FLASHBACK
GRANT EXECUTE ON DBMS_FLASHBACK TO hr;

-- Se��o 31.100 - (Package FLASHBACK) - FLASHBACK QUERY
-- Vendo a fun��o UNDO RETENTION, vis�o de um DBA
SELECT name, value
FROM v$parameter
WHERE name LIKE '%undo%'; 
-- undo_retention = 900

SELECT 900/60
FROM dual;
-- Tempo de reten��o igual a 15 minutos, por�m isso n�o tem problema porque o TABLE SPACE tem um tamanho muito maior, ele � apenas uma meta

-- Se��o 31.102 - (FLASHBACK) - Flashback Table
GRANT FLASHBACK ON hr.employees_copia2 TO hr;

-- Habilitando a movimenta��o de registros
ALTER TABLE hr.employees_copia2 ENABLE ROW MOVEMENT;
-- Obs: Esse comando � para a Oracle n�o mudar as IDS das linhas quando recuperada

-- Se��o 32.105 - (Large Objects - LOBs) - BLOBs
-- Dado permiss�o para acesso a pasta imagens
-- DROP DIRECTORY IMAGENS;
CREATE DIRECTORY IMAGENS AS 'C:\Files';
GRANT READ, WRITE ON DIRECTORY imagens TO hr;

CREATE DIRECTORY IMAGENS AS 'C:\imagens';
GRANT READ, WRITE ON DIRECTORY imagens TO hr;