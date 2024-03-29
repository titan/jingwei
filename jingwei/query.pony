class val CountCall
  let expr: (String val | Column val)
  let result_type: DataType
  let alias: (String val | None)

  new val create(
    expr': (String val | Column val),
    result_type': DataType,
    alias': (String val | None) = None)
  =>
    expr = expr'
    result_type = result_type'
    alias = alias'

class val MinCall
  let expr: (String val | Column val)
  let result_type: DataType
  let alias: (String val | None)

  new val create(
    expr': (String val | Column val),
    result_type': DataType,
    alias': (String val | None) = None)
  =>
    expr = expr'
    result_type = result_type'
    alias = alias'

class val MaxCall
  let expr: (String val | Column val)
  let result_type: DataType
  let alias: (String val | None)

  new val create(
    expr': (String val | Column val),
    result_type': DataType,
    alias': (String val | None) = None)
  =>
    expr = expr'
    result_type = result_type'
    alias = alias'

class val AvgCall
  let expr: (String val | Column val)
  let result_type: DataType
  let alias: (String val | None)

  new val create(
    expr': (String val | Column val),
    result_type': DataType,
    alias': (String val | None) = None)
  =>
    expr = expr'
    result_type = result_type'
    alias = alias'

class val TableOrSubquery
  let entity: (Table val | Select val)

  new val create(
    entity': (Table val | Select val))
  =>
    entity = entity'

primitive Join
primitive LeftJoin
primitive LeftOuterJoin

type JoinOperator is (Join | LeftJoin | LeftOuterJoin)

primitive On
primitive Using

type JoinContraint is ((On, BoolExpression) | (Using, Array[Column val] val))

type JoinClause is
  ( TableOrSubquery val
  , Array[(JoinOperator, TableOrSubquery val, (JoinContraint | None))]
  )

type DataSource is (TableOrSubquery val | Array[TableOrSubquery val] val | JoinClause val)

type AggregateColumn is (Expression | CountCall val | MinCall val | MaxCall val | AvgCall val)

type ResultColumn is (Column val | (Table val, Column val) | AggregateColumn)

interface val _Order is Equatable[_Order]

primitive Asc is _Order
  fun eq(
    o: _Order)
  : Bool =>
    o is this

primitive Desc is _Order
  fun eq(
    o: _Order)
  : Bool =>
    o is this

type Order is (Asc | Desc)

class Select
  var result_columns: Array[ResultColumn] val // result
  var distinct_result: Bool // distinct
  var from_clause: DataSource // from
  var where_clause: (BoolExpression | None) // where filter
  var group_by_clause: ((Array[Column val] val, (BoolExpression | None)) | None) // group-by
  var order_by_clause: ((Array[Expression] val, Order) | None) // order-by
  var limit_clause: I64 // limit
  var offset_clause: I64 // offset

  new create(
    result': Array[ResultColumn] val,
    distinct': Bool = false,
    from': DataSource = [],
    where_filter': (BoolExpression | None) = None,
    group_by': ((Array[Column val] val, (BoolExpression | None)) | None) = None,
    order_by': ((Array[Expression] val, Order) | None) = None,
    limit': I64 = I64(0),
    offset': I64 = I64(0))
  =>
    result_columns = result'
    distinct_result = distinct'
    from_clause = from'
    where_clause = where_filter'
    group_by_clause = group_by'
    order_by_clause = order_by'
    limit_clause = limit'
    offset_clause = offset'

  fun ref result(
    result': Array[ResultColumn] val)
  =>
    result_columns = result'

  fun ref distinct(
    distinct': Bool)
  =>
    distinct_result = distinct'

  fun ref from(
    from': DataSource)
  =>
    from_clause = from'

  fun ref from_table(
    table: Table val)
  =>
    match from_clause
    | let x: TableOrSubquery val =>
      from_clause = [x; TableOrSubquery(table)]
    | let x: Array[TableOrSubquery val] val if x.size() == 0 =>
      from_clause = TableOrSubquery(table)
    | let x: Array[TableOrSubquery val] val =>
      let ds: Array[TableOrSubquery val] iso = recover iso Array[TableOrSubquery](x.size() + 1) end
      for x' in x.values() do
        ds.push(x')
      end
      ds.push(TableOrSubquery(table))
      from_clause = consume ds
    | let join': JoinClause val =>
      from_clause = [TableOrSubquery(table)]
    end

  fun ref from_subquery(
    subquery: Select val)
  =>
    match from_clause
    | let x: TableOrSubquery val =>
      from_clause = [x; TableOrSubquery(subquery)]
    | let x: Array[TableOrSubquery val] val if x.size() == 0 =>
      from_clause = TableOrSubquery(subquery)
    | let x: Array[TableOrSubquery val] val =>
      let ds: Array[TableOrSubquery val] iso = recover iso Array[TableOrSubquery](x.size() + 1) end
      for x' in x.values() do
        ds.push(x')
      end
      ds.push(TableOrSubquery(subquery))
      from_clause = consume ds
    | let join': JoinClause val =>
      from_clause = [TableOrSubquery(subquery)]
    end

  fun ref join_table(
    table: Table val,
    contraint: (JoinContraint | None) = None)
  =>
    _join(Join, TableOrSubquery(table), contraint)

  fun ref left_join_table(
    table: Table val,
    contraint: (JoinContraint | None) = None)
  =>
    _join(LeftJoin, TableOrSubquery(table), contraint)

  fun ref left_outer_join_table(
    table: Table val,
    contraint: (JoinContraint | None) = None)
  =>
    _join(LeftOuterJoin, TableOrSubquery(table), contraint)

  fun ref join_subquery(
    subquery: Select val,
    contraint: (JoinContraint | None) = None)
  =>
    _join(Join, TableOrSubquery(subquery), contraint)

  fun ref left_join_subquery(
    subquery: Select val,
    contraint: (JoinContraint | None) = None)
  =>
    _join(LeftJoin, TableOrSubquery(subquery), contraint)

  fun ref left_outer_join_subquery(
    subquery: Select val,
    contraint: (JoinContraint | None) = None)
  =>
    _join(LeftOuterJoin, TableOrSubquery(subquery), contraint)

  fun ref _join(
    operator: JoinOperator,
    table_or_subquery: TableOrSubquery val,
    contraint: (JoinContraint | None) = None)
  =>
    match from_clause
    | let x: TableOrSubquery val =>
      from_clause = (x, [(operator, table_or_subquery, contraint)])
    | let x: Array[TableOrSubquery val] val if x.size() > 0 =>
      try
        from_clause = (x(0)?, [(operator, table_or_subquery, contraint)])
      end
    | let join': JoinClause val =>
      let root = join'._1
      let bodies = join'._2
      let bodies': Array[(JoinOperator, TableOrSubquery val, (JoinContraint | None))] iso = recover iso Array[(JoinOperator, TableOrSubquery val, (JoinContraint | None))](bodies.size() + 1) end
      for body in bodies.values() do
        bodies'.push(body)
      end
      bodies'.push((operator, table_or_subquery, contraint))
      from_clause = (root, consume bodies')
    end

  fun ref and_where(
    filter: BoolExpression)
  =>
    match where_clause
    | let clause: BoolExpression =>
      where_clause = AndExpression(clause, filter)
    else
      where_clause = filter
    end

  fun ref or_where(
    filter: BoolExpression)
  =>
    match where_clause
    | let clause: BoolExpression =>
      where_clause = OrExpression(clause, filter)
    else
      where_clause = filter
    end

  fun ref group_by(
    group_by': Array[Column val] val)
  =>
    match group_by_clause
    | (let _: Array[Column val] val, let having': (BoolExpression | None)) =>
      group_by_clause = (group_by', having')
    | None =>
      group_by_clause = (group_by', None)
    end

  fun ref having(
    having': BoolExpression)
  =>
    match group_by_clause
    | (let cols: Array[Column val] val, let _: (BoolExpression | None)) =>
      group_by_clause = (cols, having')
    end

  fun ref order_by(
    exprs: Array[Expression] val,
    order: Order = Asc)
  =>
    order_by_clause = (exprs, order)

  fun ref limit(
    limit': USize)
  =>
    limit_clause = limit'.i64()

  fun ref offset(
    offset': USize)
  =>
    offset_clause = offset'.i64()

class Insert
  var table: Table val
  var columns: Array[Column val] val
  var values: (Array[Array[Expression] val] | Select val)

  new create(
    table': Table val,
    columns': Array[Column val] val = [],
    values': (Array[Array[Expression] val] val | Select val) = [])
  =>
    table = table'
    columns = columns'
    match values'
    | let values'': Array[Array[Expression] val] val =>
      let values''' = Array[Array[Expression] val](values''.size())
      for v in values''.values() do
        values'''.push(v)
      end
      values = values'''
    | let select': Select val =>
      values = select'
    end

  fun ref into(
    table': Table val,
    columns': Array[Column val] val)
  =>
    table = table'
    columns = columns'

  fun ref add_value(
    value: Array[Expression] val)
  =>
    match values
    | let values': Array[Array[Expression] val] =>
      values'.push(value)
    else
      let values': Array[Array[Expression] val] = Array[Array[Expression] val](1)
      values'.push(value)
      values = values'
    end

  fun ref select(
    select': Select val)
  =>
    values = select'

class Update
  var table: Table val
  var assignments: Array[Assignment]
  var where_clause: (BoolExpression | None)

  new create(
    table': Table val,
    assignments': Array[Assignment] val = [],
    where_filter': (BoolExpression | None) = None)
  =>
    table = table'
    assignments = []
    for a in assignments'.values() do
      assignments.push(a)
    end
    where_clause = where_filter'

  fun ref add_assignment(
    assignment: Assignment)
  =>
    assignments.push(assignment)

  fun ref and_where(
    filter: BoolExpression)
  =>
    match where_clause
    | let clause: BoolExpression =>
      where_clause = AndExpression(clause, filter)
    else
      where_clause = filter
    end

  fun ref or_where(
    filter: BoolExpression)
  =>
    match where_clause
    | let clause: BoolExpression =>
      where_clause = OrExpression(clause, filter)
    else
      where_clause = filter
    end

class Delete
  var table: Table val
  var where_clause: (BoolExpression | None)

  new create(
    table': Table val,
    where_filter': (BoolExpression | None) = None)
  =>
    table = table'
    where_clause = where_filter'

  fun ref and_where(
    filter: BoolExpression)
  =>
    match where_clause
    | let clause: BoolExpression =>
      where_clause = AndExpression(clause, filter)
    else
      where_clause = filter
    end

  fun ref or_where(
    filter: BoolExpression)
  =>
    match where_clause
    | let clause: BoolExpression =>
      where_clause = OrExpression(clause, filter)
    else
      where_clause = filter
    end

trait QueryResolver

  fun val select(
    query: Select val,
    corrector: IdentifierCorrector val)
  : String val

  fun val insert(
    query: Insert val,
    corrector: IdentifierCorrector val)
  : String val

  fun val update(
    query: Update val,
    corrector: IdentifierCorrector val)
  : String val

  fun val delete(
    query: Delete val,
    corrector: IdentifierCorrector val)
  : String val
