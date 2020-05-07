-----------------------------------------------------------------------
--  LeetCode 1440. Evaluate Boolean Expression
--
--  Medium
--
--  SQL Schema
--  Table Variables:
--
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | name          | varchar |
--  | value         | int     |
--  +---------------+---------+
--  name is the primary key for this table.
--  This table contains the stored variables and their values.
-- 
--  Table Expressions:
--  +---------------+---------+
--  | Column Name   | Type    |
--  +---------------+---------+
--  | left_operand  | varchar |
--  | operator      | enum    |
--  | right_operand | varchar |
--  +---------------+---------+
--  (left_operand, operator, right_operand) is the primary key for this table.
--  This table contains a boolean expression that should be evaluated.
--  operator is an enum that takes one of the values ('<', '>', '=')
--  The values of left_operand and right_operand are guaranteed to be in the 
--  Variables table.
--  
--  Write an SQL query to evaluate the boolean expressions in Expressions table.
--
--  Return the result table in any order.
-- 
--  The query result format is in the following example.
--
--  Variables table:
--  +------+-------+
--  | name | value |
--  +------+-------+
--  | x    | 66    |
--  | y    | 77    |
--  +------+-------+
--
--  Expressions table:
--  +--------------+----------+---------------+
--  | left_operand | operator | right_operand |
--  +--------------+----------+---------------+
--  | x            | >        | y             |
--  | x            | <        | y             |
--  | x            | =        | y             |
--  | y            | >        | x             |
--  | y            | <        | x             |
--  | x            | =        | x             |
--  +--------------+----------+---------------+
-- 
--  Result table:
--  +--------------+----------+---------------+-------+
--  | left_operand | operator | right_operand | value |
--  +--------------+----------+---------------+-------+
--  | x            | >        | y             | false |
--  | x            | <        | y             | true  |
--  | x            | =        | y             | false |
--  | y            | >        | x             | true  |
--  | y            | <        | x             | false |
--  | x            | =        | x             | true  |
--  +--------------+----------+---------------+-------+
--  As shown, you need find the value of each boolean exprssion in the table 
--  using the variables table.
--------------------------------------------------------------------
/* Write your T-SQL query statement below */

SELECT 
    A.left_operand,
    A.operator,
    A.right_operand,
    CASE 
        WHEN operator = '>' THEN CASE WHEN B.value > C.value THEN 'true' ELSE 'false' END 
        WHEN operator = '=' THEN CASE WHEN B.value = C.value THEN 'true' ELSE 'false' END 
        WHEN operator = '<' THEN CASE WHEN B.value < C.value THEN 'true' ELSE 'false' END
        END AS value		
FROM
    Expressions AS A
INNER JOIN
    Variables AS B
ON
   A.left_operand = B.name
INNER JOIN
    Variables AS C
ON
   A.right_operand = C.name
