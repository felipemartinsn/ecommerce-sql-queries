# Descrição do Projeto: Sistema de Gestão de Funcionários e Departamentos

Este repositório contém o script SQL para criação das tabelas `employee` e `department`, além de alguns exemplos de consultas SQL para recuperação de informações sobre departamentos e empregados.

## Índices Criados:

A criação de índices tem como objetivo otimizar as consultas SQL, garantindo que operações de leitura em tabelas grandes ocorram de forma eficiente.

### Índices e Justificativas:

1. **Índice `idx_employee_dno`** na coluna `Dno` da tabela `employee`:
   - Criado para otimizar a consulta que busca o departamento com o maior número de pessoas, utilizando o `GROUP BY Dno` e contando os empregados por departamento.

2. **Índice `idx_employee_dno_lname`** nas colunas `Dno` e `Lname` da tabela `employee`:
   - Criado para otimizar a consulta que relaciona empregados a departamentos, realizando uma junção entre as tabelas `employee` e `department` e ordenando por `Dname` e `Lname`.

## Como rodar o script

Basta executar os scripts SQL fornecidos para criar as tabelas e os índices, e realizar as consultas conforme desejado.

