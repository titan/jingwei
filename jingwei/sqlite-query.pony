use "itertools"

primitive SqliteBoolExpressionResolver
  fun val apply(
    expr: BoolExpression,
    corrector: IdentifierCorrector val,
    depth: USize = 0)
  : String val =>
    match expr
    | let x: AndExpression val =>
      and_expr(x, corrector, depth)
    | let x: OrExpression val =>
      or_expr(x, corrector, depth)
    | let x: NotExpression val =>
      not_expr(x, corrector, depth)
    | let x: NotEqualsToExpression val =>
      not_equals_to_expr(x, corrector, depth)
    | let x: EqualsToExpression val =>
      equals_to_expr(x, corrector, depth)
    | let x: LessThanExpression val =>
      less_than_expr(x, corrector, depth)
    | let x: LessThanOrEqualsToExpression val =>
      less_than_or_equals_to_expr(x, corrector, depth)
    | let x: GreaterThanExpression val =>
      greater_than_expr(x, corrector, depth)
    | let x: GreaterThanOrEqualsToExpression val =>
      greater_than_or_equals_to_expr(x, corrector, depth)
    | let x: IsExpression val =>
      is_expr(x, corrector, depth)
    | let x: IsNullExpression val =>
      is_null_expr(x, corrector, depth)
    | let x: NotNullExpression val =>
      not_null_expr(x, corrector, depth)
    | let x: InExpression val =>
      in_expr(x, corrector, depth)
    | let x: BetweenExpression val =>
      between_expr(x, corrector, depth)
    | let x: NotBetweenExpression val =>
      not_between_expr(x, corrector, depth)
    | let x: ExistsExpression val =>
      exists_expr(x, corrector, depth)
    end

  fun val and_expr(
    expr: AndExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = SqliteExpressionResolver(expr.left, corrector, depth + 1)
    let right = SqliteExpressionResolver(expr.right, corrector, depth + 1)
    let result: String iso = recover iso String(left.size() + right.size() + 5 + if depth != 0 then 2 else 0 end) end
    if depth != 0 then
      result.append("(")
    end
    result.append(left)
    result.append(" AND ")
    result.append(right)
    if depth != 0 then
      result.append(")")
    end
    consume result

  fun val or_expr(
    expr: OrExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = SqliteExpressionResolver(expr.left, corrector, depth + 1)
    let right = SqliteExpressionResolver(expr.right, corrector, depth + 1)
    let result: String iso = recover iso String(left.size() + right.size() + 4 + if depth != 0 then 2 else 0 end) end
    if depth != 0 then
      result.append("(")
    end
    result.append(left)
    result.append(" OR ")
    result.append(right)
    if depth != 0 then
      result.append(")")
    end
    consume result

  fun val not_expr(
    expr: NotExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let expr' = SqliteExpressionResolver(expr.expr, corrector, depth + 1)
    let result: String iso = recover iso String(expr'.size() + 4) end
    (consume result) .> append("NOT ") .> append(expr')

  fun val not_equals_to_expr(
    expr: NotEqualsToExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = SqliteExpressionResolver(expr.left, corrector, depth + 1)
    let right = SqliteExpressionResolver(expr.right, corrector, depth + 1)
    let result: String iso = recover iso String(left.size() + right.size() + 4 + if depth != 0 then 2 else 0 end) end
    if depth != 0 then
      result.append("(")
    end
    result.append(left)
    result.append(" <> ")
    result.append(right)
    if depth != 0 then
      result.append(")")
    end
    consume result

  fun val equals_to_expr(
    expr: EqualsToExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = SqliteExpressionResolver(expr.left, corrector, depth + 1)
    let right = SqliteExpressionResolver(expr.right, corrector, depth + 1)
    let result: String iso = recover iso String(left.size() + right.size() + 3 + if depth != 0 then 2 else 0 end) end
    if depth != 0 then
      result.append("(")
    end
    result.append(left)
    result.append(" = ")
    result.append(right)
    if depth != 0 then
      result.append(")")
    end
    consume result

  fun val less_than_expr(
    expr: LessThanExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = SqliteExpressionResolver(expr.left, corrector, depth + 1)
    let right = SqliteExpressionResolver(expr.right, corrector, depth + 1)
    let result: String iso = recover iso String(left.size() + right.size() + 3 + if depth != 0 then 2 else 0 end) end
    if depth != 0 then
      result.append("(")
    end
    result.append(left)
    result.append(" < ")
    result.append(right)
    if depth != 0 then
      result.append(")")
    end
    consume result

  fun val less_than_or_equals_to_expr(
    expr: LessThanOrEqualsToExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = SqliteExpressionResolver(expr.left, corrector, depth + 1)
    let right = SqliteExpressionResolver(expr.right, corrector, depth + 1)
    let result: String iso = recover iso String(left.size() + right.size() + 4 + if depth != 0 then 2 else 0 end) end
    if depth != 0 then
      result.append("(")
    end
    result.append(left)
    result.append(" <= ")
    result.append(right)
    if depth != 0 then
      result.append(")")
    end
    consume result

  fun val greater_than_expr(
    expr: GreaterThanExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = SqliteExpressionResolver(expr.left, corrector, depth + 1)
    let right = SqliteExpressionResolver(expr.right, corrector, depth + 1)
    let result: String iso = recover iso String(left.size() + right.size() + 3 + if depth != 0 then 2 else 0 end) end
    if depth != 0 then
      result.append("(")
    end
    result.append(left)
    result.append(" > ")
    result.append(right)
    if depth != 0 then
      result.append(")")
    end
    consume result

  fun val greater_than_or_equals_to_expr(
    expr: GreaterThanOrEqualsToExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = SqliteExpressionResolver(expr.left, corrector, depth + 1)
    let right = SqliteExpressionResolver(expr.right, corrector, depth + 1)
    let result: String iso = recover iso String(left.size() + right.size() + 4 + if depth != 0 then 2 else 0 end) end
    if depth != 0 then
      result.append("(")
    end
    result.append(left)
    result.append(" >= ")
    result.append(right)
    if depth != 0 then
      result.append(")")
    end
    consume result

  fun val is_expr(
    expr: IsExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = SqliteExpressionResolver(expr.left, corrector, depth + 1)
    let right = SqliteExpressionResolver(expr.right, corrector, depth + 1)
    let result: String iso = recover iso String(left.size() + right.size() + 4 + if depth != 0 then 2 else 0 end) end
    if depth != 0 then
      result.append("(")
    end
    result.append(left)
    result.append(" IS ")
    result.append(right)
    if depth != 0 then
      result.append(")")
    end
    consume result

  fun val is_null_expr(
    expr: IsNullExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let expr' = SqliteExpressionResolver(expr.expr, corrector, depth + 1)
    let result: String iso = recover iso String(expr'.size() + " IS NULL".size()) end
    (consume result) .> append(expr') .> append(" IS NULL")

  fun val not_null_expr(
    expr: NotNullExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let expr' = SqliteExpressionResolver(expr.expr, corrector, depth + 1)
    let result: String iso = recover iso String(expr'.size() + " NOTNULL".size()) end
    (consume result) .> append(expr') .> append(" NOTNULL")

  fun val in_expr(
    expr: InExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = SqliteExpressionResolver(expr.left, corrector, depth + 1)
    let right =
      match expr.right
      | let expr': Expression val =>
        SqliteExpressionResolver(expr', corrector, depth + 1)
      | let subquery: Select =>
        SqliteQueryResolver.select(subquery, corrector)
      | None =>
        ""
      end
    let result: String iso = recover iso String(left.size() + right.size() + 4) end
    result.append(left)
    result.append(" IN ")
    result.append("(")
    result.append(right)
    result.append(")")
    consume result

  fun val between_expr(
    expr: BetweenExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let expr' = SqliteExpressionResolver(expr.expr, corrector, depth + 1)
    let infimum = SqliteExpressionResolver(expr.infimum, corrector, depth + 1)
    let supremum = SqliteExpressionResolver(expr.supremum, corrector, depth + 1)
    let result: String iso = recover iso String(expr'.size() + infimum.size() + supremum.size() + " BETWEEN  AND ".size()) end
    result.append(expr')
    result.append(" BETWEEN ")
    result.append(infimum)
    result.append(" AND ")
    result.append(supremum)
    consume result

  fun val not_between_expr(
    expr: NotBetweenExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let expr' = SqliteExpressionResolver(expr.expr, corrector, depth + 1)
    let infimum = SqliteExpressionResolver(expr.infimum, corrector, depth + 1)
    let supremum = SqliteExpressionResolver(expr.supremum, corrector, depth + 1)
    let result: String iso = recover iso String(expr'.size() + infimum.size() + supremum.size() + " NOT BETWEEN  AND ".size()) end
    result.append(expr')
    result.append(" NOT BETWEEN ")
    result.append(infimum)
    result.append(" AND ")
    result.append(supremum)
    consume result

  fun val exists_expr(
    expr: ExistsExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let subquery = SqliteQueryResolver.select(expr.subquery, corrector)
    let result: String iso = recover iso String(subquery.size() + "EXISTS ()".size()) end
    result.append("EXISTS (")
    result.append(subquery)
    result.append(")")
    consume result

primitive SqliteExpressionResolver
  fun val apply(
    expr: Expression val,
    corrector: IdentifierCorrector val,
    depth: USize = 0)
  : String val =>
    match expr
    | let x: I64 =>
      x.string()
    | let x: F64 =>
      x.string()
    | let x: String val =>
      let result: String iso = recover iso String(x.size() + 2) end
      (consume result) .> append("'") .> append(x) .> append("'")
    | let x: Placeholder =>
      "?"
    | let x: Column =>
      _Column.name(x, corrector~correct())
    | let x: Table val =>
      corrector.correct(x.name())
    | (let tab: Table val, let col: Column) =>
      let tabname: String val = corrector.correct(tab.name())
      let colname: String val = _Column.name(col, corrector~correct())
      let x: String iso = recover iso String(tabname.size() + colname.size() + 1) end
      (consume x) .> append(tabname) .> append(".") .> append(colname)
    | let x: BoolExpression =>
      SqliteBoolExpressionResolver(x, corrector, depth)
    | let x: AddExpression val =>
      add(x, corrector, depth)
    | let x: SubExpression val =>
      sub(x, corrector, depth)
    | let x: MulExpression val =>
      mul(x, corrector, depth)
    | let x: DivExpression val =>
      div(x, corrector, depth)
    | let x: RemExpression val =>
      rem(x, corrector, depth)
    | let x: ApplyExpression val =>
      app(x, corrector, depth)
    end

  fun val add(
    expr: AddExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = apply(expr.left, corrector, depth)
    let right = apply(expr.right, corrector, depth)
    let result: String iso = recover iso String(left.size() + right.size() + 3 + if depth != 0 then 2 else 0 end) end
    if depth != 0 then
      result.append("(")
    end
    result.append(left)
    result.append(" + ")
    result.append(right)
    if depth != 0 then
      result.append(")")
    end
    consume result

  fun val sub(
    expr: SubExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = apply(expr.left, corrector, depth)
    let right = apply(expr.right, corrector, depth)
    let result: String iso = recover iso String(left.size() + right.size() + 3 + if depth != 0 then 2 else 0 end) end
    if depth != 0 then
      result.append("(")
    end
    result.append(left)
    result.append(" - ")
    result.append(right)
    if depth != 0 then
      result.append(")")
    end
    consume result

  fun val mul(
    expr: MulExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = apply(expr.left, corrector, depth)
    let right = apply(expr.right, corrector, depth)
    let result: String iso = recover iso String(left.size() + right.size() + 3) end
    (consume result) .> append(left) .> append(" * ") .> append(right)

  fun val div(
    expr: DivExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = apply(expr.left, corrector, depth)
    let right = apply(expr.right, corrector, depth)
    let result: String iso = recover iso String(left.size() + right.size() + 3) end
    (consume result) .> append(left) .> append(" / ") .> append(right)

  fun val rem(
    expr: RemExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let left = apply(expr.left, corrector, depth)
    let right = apply(expr.right, corrector, depth)
    let result: String iso = recover iso String(left.size() + right.size() + 3) end
    (consume result) .> append(left) .> append(" % ") .> append(right)

  fun val app(
    expr: ApplyExpression val,
    corrector: IdentifierCorrector val,
    depth: USize)
  : String val =>
    let name = expr.name
    let arguments: String val = ", ".join(Iter[Expression val](expr.arguments.values()).map[String val]({(x: Expression val): String val => SqliteExpressionResolver(x, corrector, 0)}))
    let result: String iso = recover iso String(name.size() + arguments.size() + 2) end
    (consume result) .> append(name) .> append("(") .> append(arguments) .> append(")")

primitive SqliteAssignmentResolver
  fun val apply(
    assignment: Assignment,
    corrector: IdentifierCorrector val)
  : String val =>
    let col: Column = assignment._1
    let expr: Expression = assignment._2
    let expr_repr: String val = SqliteExpressionResolver(expr, corrector)
    let colname = _Column.name(col, corrector~correct())
    let result: String iso = recover iso String(colname.size() + expr_repr.size() + " = ".size()) end
    (consume result) .> append(colname) .> append(" = ") .> append(expr_repr)

primitive SqliteTableOrSubqueryResolver
  fun val apply(
    table_or_subquery: TableOrSubquery val,
    corrector: IdentifierCorrector val)
  : String val =>
    match table_or_subquery.entity
    | let table: Table val =>
      corrector.correct(table.name())
    | let subquery: Select val =>
      let subquery': String val = SqliteQueryResolver.select(subquery, corrector)
      let result: String iso = recover iso String(subquery'.size() + 2) end
      (consume result) .> append("(") .> append(subquery') .> append(")")
    end

primitive SqliteJoinClauseResolver
  fun val apply(
    join: JoinClause val,
    corrector: IdentifierCorrector val)
  : String val =>
    let table_or_subquery: String val = SqliteTableOrSubqueryResolver(join._1, corrector)
    let joinbody: String val = " ".join(Iter[(JoinOperator, TableOrSubquery val, (JoinContraint | None))](join._2.values()).map[String val]({(x: (JoinOperator, TableOrSubquery val, (JoinContraint | None))): String val =>
      let operator: String val =
        match x._1
        | Join => "JOIN"
        | LeftJoin => "LEFT JOIN"
        | LeftOuterJoin => "LEFT OUTER JOIN"
        end
      let table_or_subquery': String val = SqliteTableOrSubqueryResolver(x._2, corrector)
      match x._3
      | let contraint: JoinContraint =>
        match contraint
        | (On, let expr: BoolExpression) =>
          let expr': String val = SqliteBoolExpressionResolver(expr, corrector)
          let result: String iso = recover iso String(operator.size() + table_or_subquery'.size() + expr'.size() + 5) end
          (consume result) .> append(operator) .> append(" ") .> append(table_or_subquery') .> append(" ON ") .> append(expr')
        | (Using, let cols: Array[Column] val) =>
          let cols': String val = ", ".join(Iter[Column](cols.values()).map[String val]({(x: Column): String val =>
            corrector.correct(_Column.name(x))
          }))
          let result: String iso = recover iso String(operator.size() + table_or_subquery'.size() + cols'.size() + 10) end
          (consume result) .> append(operator) .> append(" ") .> append(table_or_subquery') .> append(" USING (") .>  append(cols') .> append(")")
        end
      else
        let result: String iso = recover iso String(operator.size() + table_or_subquery'.size() + 1) end
        (consume result) .> append(operator) .> append(" ") .> append(table_or_subquery')
      end
    }))
    let result: String iso = recover iso String(table_or_subquery.size() + joinbody.size() + 1) end
    (consume result) .> append(table_or_subquery) .> append(" ") .> append(joinbody)

primitive SqliteDataSourceResolver
  fun val apply(
    input: DataSource,
    corrector: IdentifierCorrector val)
  : String val =>
    match input
    | let table_or_subquery: TableOrSubquery val =>
      SqliteTableOrSubqueryResolver(table_or_subquery, corrector)
    | let table_or_subqueries: Array[TableOrSubquery val] val =>
      ", ".join(Iter[TableOrSubquery val](table_or_subqueries.values()).map[String val]({(x: TableOrSubquery val): String val => SqliteTableOrSubqueryResolver(x, corrector)}))
    | let join: JoinClause val =>
      SqliteJoinClauseResolver(join, corrector)
    end

primitive SqliteResultColumnResolver
  fun val apply(
    col: ResultColumn,
    corrector: IdentifierCorrector val)
  : String val =>
    match col
    | let col': Column =>
      corrector.correct(_Column.name(col'))
    | let acol: AggregateColumn =>
      SqliteExpressionResolver(acol, corrector)
    end

primitive SqliteQueryResolver is QueryResolver

  fun val select(
    query: Select,
    corrector: IdentifierCorrector val)
  : String val =>
    let input: String val = SqliteDataSourceResolver(_Select.from(query), corrector)
    let columns: String val = ", ".join(Iter[ResultColumn](_Select.result(query).values()).map[String val]({(x: ResultColumn): String val => SqliteResultColumnResolver(x, corrector)}))
    let distinct: String val = if _Select.distinct(query) then "DISTINCT " else "" end
    let where_filter: String val =
      match _Select.where_filter(query)
      | let expr: BoolExpression =>
        " WHERE " + SqliteBoolExpressionResolver(expr, corrector)
      | None =>
        ""
      end
    let group_by: String val =
      match _Select.group_by(query)
      | let cols: Array[Column] val =>
        let cols': String val = ", ".join(Iter[Column](cols.values()).map[String val]({(x: Column): String val => corrector.correct(_Column.name(x))}))
        let result: String iso = recover iso String(" GROUP BY ".size() + cols'.size()) end
        (consume result) .> append(" GROUP BY ") .> append(cols')
      | None =>
        ""
      end
    let having: String val =
      match _Select.having(query)
      | let expr: BoolExpression =>
        let expr_repr: String val = SqliteBoolExpressionResolver(expr, corrector)
        let result: String iso = recover iso String(" HAVING ".size() + expr_repr.size()) end
        (consume result) .> append(" HAVING ") .> append(expr_repr)
      | None =>
        ""
      end
    let order_by: String val =
      match _Select.order_by(query)
      | (let cols: Array[Column] val, let order: Order) =>
        let cols': String val = ", ".join(Iter[Column](cols.values()).map[String val]({(x: Column): String val => corrector.correct(_Column.name(x))}))
        let order': String val = if order == Asc then "" else " DESC" end
        let result: String iso = recover iso String(" ORDER BY ".size() + cols'.size() + order'.size()) end
        (consume result) .> append(" ORDER BY ") .> append(cols') .> append(order')
      | None =>
        ""
      end
    let limit: String val = if _Select.limit(query) != 0 then " LIMIT " + _Select.limit(query).string() else "" end
    let offset: String val = if _Select.offset(query) != 0 then " OFFSET " + _Select.offset(query).string() else "" end
    let result: String iso = recover iso String("SELECT  FROM ".size() + columns.size() + distinct.size() + input.size() + where_filter.size() + group_by.size() + having.size() + order_by.size() + limit.size() + offset.size()) end
    (consume result) .> append("SELECT ") .> append(distinct) .> append(columns) .> append(" FROM ") .> append(input) .> append(where_filter) .> append(group_by) .> append(having) .> append(order_by) .> append(limit) .> append(offset)

  fun val insert(
    query: Insert,
    corrector: IdentifierCorrector val)
  : String val =>
    let table: String val = corrector.correct(_Insert.table(query).name())
    let columns: String val = ", ".join(Iter[Column](_Insert.columns(query).values()).map[String val]({(x: Column): String val => corrector.correct(_Column.name(x))}))
    let values: String val = ", ".join(Iter[Array[Expression] val](_Insert.values(query).values()).map[String val]({(x: Array[Expression] val)(corrector): String val =>
      let vals: String val = ", ".join(Iter[Expression](x.values()).map[String val]({(y: Expression): String val =>
        SqliteExpressionResolver(y, corrector)
      }))
      let result: String iso = recover iso String("()".size() + vals.size()) end
      (consume result) .> append("(") .> append(vals) .> append(")")
    }))
    let result: String iso = recover iso String("INSERT INTO () VALUES ".size() + table.size() + columns.size() + values.size()) end
    (consume result) .> append("INSERT INTO ") .> append(table) .> append("(") .> append(columns) .> append(") VALUES ") .> append(values)

  fun val update(
    query: Update,
    corrector: IdentifierCorrector val)
  : String val =>
    let table: String val = corrector.correct(_Update.table(query).name())
    let assignments: String val = ", ".join(Iter[Assignment](_Update.assignments(query).values()).map[String val]({(x: Assignment): String val => SqliteAssignmentResolver(x, corrector)}))
    let where_filter: String val =
      match _Update.where_filter(query)
      | let expr: BoolExpression =>
        " WHERE " + SqliteBoolExpressionResolver(expr, corrector)
      | None =>
        ""
      end
    let result: String iso = recover iso String("UPDATE  SET ".size() + table.size() + assignments.size() + where_filter.size()) end
    (consume result) .> append("UPDATE ") .> append(table) .> append(" SET ") .> append(assignments) .> append(where_filter)

  fun val delete(
    query: Delete,
    corrector: IdentifierCorrector val)
  : String val =>
    let table: String val = corrector.correct(_Delete.table(query).name())
    let where_filter: String val =
      match _Delete.where_filter(query)
      | let expr: BoolExpression =>
        " WHERE " + SqliteBoolExpressionResolver(expr, corrector)
      | None =>
        ""
      end
    let result: String iso = recover iso String("DELETE FROM ".size() + table.size() + where_filter.size()) end
    (consume result) .> append("DELETE FROM ") .> append(table) .> append(where_filter)
