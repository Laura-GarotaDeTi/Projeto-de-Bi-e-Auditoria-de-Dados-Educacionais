# Projeto-de-Bi-e-Auditoria-de-Dados-Educacionais
Projeto de BI e Auditoria de Dados Educacionais

Projeto focado em auditoria de qualidade de dados, análise operacional e construção de dashboards estratégicos utilizando Excel, SQL e Power BI.



# Tecnologias Utilizadas

- Excel
- SQL
- PostgreSQL
- DBeaver
- Power BI

---

# Objetivos do Projeto

- Auditoria de qualidade dos dados
- Identificação de inconsistências
- Classificação de desempenho acadêmico
- Análise financeira e operacional
- Construção de dashboard executivo

---

# Auditoria de Dados

Foi realizada uma inspeção para identificação de:

- registros inválidos
- inconsistências de formato
- duplicidades
- notas fora do padrão
- possíveis falhas operacionais

Os desvios encontrados foram documentados em uma estrutura de log de erros contendo linha, coluna, tipo de problema e valor identificado.

---

# Classificação de Desempenho

Foi criada a coluna faixa_desempenho para classificação acadêmica dos alunos:

| Faixa | Critério |
|---|---|
| Baixo | nota < 5 |
| Médio | nota entre 5 e 7,9 |
| Alto | nota >= 8 |

---

# Análises SQL

As análises SQL foram utilizadas para:

- análise de inadimplência
- identificação de alunos inativos
- detecção de duplicidades
- ranking acadêmico
- análise operacional das escolas

## Exemplo de Query

sql
SELECT
    status,
    COUNT(*) AS total
FROM pagamentos
GROUP BY status;




# Dashboard Executivo

O dashboard foi desenvolvido com foco em visão estratégica e apoio à tomada de decisão.

Indicadores principais:

- inadimplência
- ranking acadêmico
- indicadores operacionais
- desempenho das escolas
![Dashboard](./imagens/Dashboard-ProjetoBi.png)

# Principais Insights

- Foram encontradas inconsistências na base de dados.
- Algumas unidades apresentaram maior risco operacional.
- Houve identificação de possíveis falhas de governança.
- O ranking acadêmico mostrou concentração de desempenho entre escolas específicas.

---

# Visão Estratégica

Projeto desenvolvido com foco em governança de dados, qualidade da informação e análise orientada a dados para suporte executivo.
