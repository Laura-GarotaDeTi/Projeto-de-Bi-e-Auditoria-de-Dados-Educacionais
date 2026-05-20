SELECT*
FROM alunos;  --Consulta inicial da tabela alunos

SELECT nome, ativo -- Alunos ativos
FROM alunos;

SELECT nome, ativo -- Alunos inativos 
FROM alunos 
WHERE ativo=false


SELECT--Join entre alunos e pagamentos 
a.nome,
p.status,
p.valor
FROM alunos a
JOIN pagamentos p 
ON a.aluno_id=p.aluno_id;



SELECT --Aqui estamos vendo quantos pagamentos existem em cada status
status,
COUNT(*) AS quantidade
FROM pagamentos 
GROUP BY status;


SELECT -- Aqui estamos vendo a taxa de inadimplência com percentual
status,
COUNT(*) as quantidade,
ROUND(COUNT(*)*100.0/Sum(COUNT(*)) OVER (),
2 ) AS percentual
FROM pagamentos 
GROUP BY status;


SELECT-- Aqui estamos vendo os alunos que tem pagamentos pedentes (inadimplentes)
a.aluno_id,
a.nome,
COUNT(p.pagamento_id) AS pagamentos_pendentes
FROM alunos a
JOIN pagamentos p ON p.aluno_id= a.aluno_id
WHERE p.status='pendente'
GROUP BY a.aluno_id, a.nome 
ORDER BY pagamentos_pendentes DESC; 

SELECT --Alunos inativos com pagamentos (Possível inconsistência)
a.aluno_id,
a.nome,
a.ativo,
COUNT(p.pagamento_id) AS total_pagamentos
FROM alunos a
JOIN pagamentos p ON p.aluno_id = a.aluno_id 
WHERE a.ativo= false
GROUP BY a.aluno_id,a.nome, a.ativo 
HAVING COUNT(p.pagamento_id)>0;

SELECT -- Detectar possíveis duplicadas de pagamento
aluno_id,
mes_ref, 
COUNT(*) AS qtd_registros
FROM  pagamentos 
GROUP BY aluno_id, mes_ref 
HAVING COUNT=(*)> 1;


--- Meu insight 
-- A análise da saúde financeira da operação indica:
--  Presença de inadimplência relevante baseada no status de pagamentos
--  Existência de alunos inativos com registros financeiros ativos, sugerindo inconsistência de status
--  Não foram identificadas duplicidades de pagamentos por aluno e mês, indicando consistência dos dados financeiros
-- Apesar do schema prever o status 'isento', não foram encontrados registros com esse valor
-- na base de pagamentos analisada, indicando que essa categoria não está sendo utilizada
-- ou não foi populada no dataset atual.
-- Foram identificados apenas os status 'pago' e 'pendente' na base de pagamentos,
-- não havendo registros da categoria 'isento', o que pode indicar que esse tipo de
-- benefício não está sendo aplicado ou não foi registrado no período analisado.



SELECT --Aqui estamos juntando as notas dos alunos e calculando a média geral
aluno_id, AVG (nota) AS media_notas
FROM avaliacoes 
GROUP BY aluno_id;


SELECT --Aqui estamos criando o ranking dos alunos , ordenando por média
a.aluno_id,
a.nome,
AVG(av.nota) AS media_notas,
RANK() OVER (ORDER BY avg(av.nota) DESC) AS ranking_geral
FROM alunos a
JOIN avaliacoes av on av.aluno_id=a.aluno_id 
GROUP BY a.aluno_id,a.nome; 


SELECT -- aqui estamos fazendo o ranking por escola 
    escola_id,
    aluno_id,
    nome,
    media_notas,
    RANK() OVER(
        PARTITION BY escola_id 
        order BY media_notas desc
    ) AS ranking_escola
FROM (
    SELECT
        a.escola_id,
        a.aluno_id,
        a.nome,
        avg(av.nota) as media_notas
    FROM alunos a
    JOIN avaliacoes av on av.aluno_id = a.aluno_id
    GROUP BY a.escola_id, a.aluno_id, a.nome
) sub;



SELECT * --top 3 por escola 
FROM (
    SELECT 
        escola_id,
        aluno_id,
        nome,
        media_notas,
        RANK() OVER (
            PARTITION BY escola_id 
            ORDER BY media_notas DESC
        ) AS ranking_escola
    FROM (
        SELECT 
            a.escola_id,
            a.aluno_id,
            a.nome,
            AVG(av.nota) AS media_notas
        FROM alunos a
        JOIN avaliacoes av ON av.aluno_id = a.aluno_id
        GROUP BY a.escola_id, a.aluno_id, a.nome
    ) sub
) final
WHERE ranking_escola <= 3;

-- A análise de desempenho acadêmico foi realizada com base na média de notas dos alunos.
-- Foi aplicado ranking utilizando função RANK() particionada por escola,
-- permitindo identificar os 3 melhores alunos de cada unidade.
-- Em casos de empate, o RANK() atribui a mesma posição sem forçar desempate artificial,
-- garantindo maior fidelidade ao desempenho real dos alunos.
