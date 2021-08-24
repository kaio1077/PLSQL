-- Seção 17.58 - Gerenciando Dependências de Objetos

-- Consultar dependências Diretas e Indiretas dos objetos de todos os schemas usando DBA_Dependencies
DESC DBA_DEPENDENCIES; -- Há o OWNER do objeto a mais

-- Consulta mais completa para as dependências
SELECT *
FROM dba_dependencies
START WITH  referenced_owner = 'HR' AND
            referenced_name = 'EMPLOYEES' AND
            referenced_type = 'TABLE'
CONNECT BY PRIOR    owner = referenced_owner AND
                    name = referenced_name AND
                    type = referenced_type;
                    
-- Seção 17.59 - (Gerenciando Dependências de Objetos) - Debugando Procedures e Functions
grant DEBUG CONNECT SESSION, DEBUG ANY PROCEDURE to hr;

-- Utilizando o 5º passo.
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
-- Permissão concedida para debugar pelo HR

-- Seção 29.95 - (Package DBMS_SCHEDULER) - Criando um Programa 
-- Dando permissão para a criação de Jobs
grant CREATE JOB to HR;

-- Seção 29.97 - (Package UTL_FILE) - Ler e Gravar Arquivos
-- Permissão para acesso ao C:\Files que será nosso servidor local

CREATE OR REPLACE DIRECTORY Arquivos AS 'C:\Files';
GRANT READ, WRITE ON DIRECTORY Arquivos TO hr;

-- Seção 31.99 - (Package FLASHBACK) - DBMS_FLASHBACK
GRANT EXECUTE ON DBMS_FLASHBACK TO hr;

-- Seção 31.100 - (Package FLASHBACK) - FLASHBACK QUERY
-- Vendo a função UNDO RETENTION, visão de um DBA
SELECT name, value
FROM v$parameter
WHERE name LIKE '%undo%'; 
-- undo_retention = 900

SELECT 900/60
FROM dual;
-- Tempo de retenção igual a 15 minutos, porém isso não tem problema porque o TABLE SPACE tem um tamanho muito maior, ele é apenas uma meta

-- Seção 31.102 - (FLASHBACK) - Flashback Table
GRANT FLASHBACK ON hr.employees_copia2 TO hr;

-- Habilitando a movimentação de registros
ALTER TABLE hr.employees_copia2 ENABLE ROW MOVEMENT;
-- Obs: Esse comando é para a Oracle não mudar as IDS das linhas quando recuperada

-- Seção 32.105 - (Large Objects - LOBs) - BLOBs
-- Dado permissão para acesso a pasta imagens
-- DROP DIRECTORY IMAGENS;
CREATE DIRECTORY IMAGENS AS 'C:\Files';
GRANT READ, WRITE ON DIRECTORY imagens TO hr;

CREATE DIRECTORY IMAGENS AS 'C:\imagens';
GRANT READ, WRITE ON DIRECTORY imagens TO hr;