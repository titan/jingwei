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

type JoinContraint is ((On, BoolExpression) | (Using, Array[Column] val))

type JoinClause is
  ( TableOrSubquery val
  , Array[(JoinOperator, TableOrSubquery val, (JoinContraint | None))]
  )

type DataSource is (TableOrSubquery val | Array[TableOrSubquery val] val | JoinClause val)

type AggregateColumn is Expression

type ResultColumn is (Column | AggregateColumn)

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

type Select is
  ( Array[ResultColumn] val // result
  , Bool // distinct
  , DataSource // from
  , (BoolExpression | None) // where filter
  , (Array[Column] val | None) // group-by
  , (BoolExpression | None) // having
  , ((Array[Column] val, Order) | None) // order-by
  , USize // limit
  , USize // offset
  )

primitive _Select
  fun val result(
    query: Select val)
  : Array[ResultColumn] val =>
    query._1

  fun val distinct(
    query: Select val)
  : Bool =>
    query._2

  fun val from(
    query: Select val)
  : DataSource =>
    query._3

  fun val where_filter(
    query: Select val)
  : (BoolExpression | None) =>
    query._4

  fun val group_by(
    query: Select val)
  : (Array[Column] val | None) =>
    query._5

  fun val having(
    query: Select val)
  : (BoolExpression | None) =>
    query._6

  fun val order_by(
    query: Select val)
  : ((Array[Column] val, Order) | None) =>
    query._7

  fun val limit(
    query: Select val)
  : USize =>
    query._8

  fun val offset(
    query: Select val)
  : USize =>
    query._9

primitive SelectBuilder
  fun val apply(
    result': Array[ResultColumn] val,
    distinct': Bool = false,
    from': DataSource = [],
    where_filter': (BoolExpression | None) = None,
    group_by': (Array[Column] val | None) = None,
    having': (BoolExpression | None) = None,
    order_by': ((Array[Column] val, Order) | None) = None,
    limit': USize = 0,
    offset': USize = 0)
  : Select val =>
    ( result'
    , distinct'
    , from'
    , where_filter'
    , group_by'
    , having'
    , order_by'
    , limit'
    , offset'
    )

  fun val result(
    query: Select val,
    result': Array[ResultColumn] val)
  : Select val =>
    apply(
      result',
      query._2,
      query._3,
      query._4,
      query._5,
      query._6,
      query._7,
      query._8,
      query._9
    )

  fun val distinct(
    query: Select val,
    distinct': Bool)
  : Select val =>
    apply(
      query._1,
      distinct',
      query._3,
      query._4,
      query._5,
      query._6,
      query._7,
      query._8,
      query._9
    )

  fun val from(
    query: Select val,
    input: DataSource)
  : Select val =>
    apply(
      query._1,
      query._2,
      input,
      query._4,
      query._5,
      query._6,
      query._7,
      query._8,
      query._9
    )

  fun val from_table(
    query: Select val,
    table: Table val)
  : Select val =>
    match _Select.from(query)
    | let x: TableOrSubquery val =>
      apply(
        query._1,
        query._2,
        [x; TableOrSubquery(table)],
        query._4,
        query._5,
        query._6,
        query._7,
        query._8,
        query._9
      )
    | let x: Array[TableOrSubquery val] val if x.size() == 0 =>
      apply(
        query._1,
        query._2,
        TableOrSubquery(table),
        query._4,
        query._5,
        query._6,
        query._7,
        query._8,
        query._9
      )
    | let x: Array[TableOrSubquery val] val =>
      let ds: Array[TableOrSubquery val] iso = recover iso Array[TableOrSubquery](x.size() + 1) end
      for x' in x.values() do
        ds.push(x')
      end
      ds.push(TableOrSubquery(table))
      apply(
        query._1,
        query._2,
        consume ds,
        query._4,
        query._5,
        query._6,
        query._7,
        query._8,
        query._9
      )
    | let join': JoinClause val =>
      let ds: Array[TableOrSubquery val] val = [TableOrSubquery(table)]
      apply(
        query._1,
        query._2,
        ds,
        query._4,
        query._5,
        query._6,
        query._7,
        query._8,
        query._9
      )
    end

  fun val from_subquery(
    query: Select val,
    subquery: Select val)
  : Select val =>
    match _Select.from(query)
    | let x: TableOrSubquery val =>
      apply(
        query._1,
        query._2,
        [x; TableOrSubquery(subquery)],
        query._4,
        query._5,
        query._6,
        query._7,
        query._8,
        query._9
      )
    | let x: Array[TableOrSubquery val] val if x.size() == 0 =>
      apply(
        query._1,
        query._2,
        TableOrSubquery(subquery),
        query._4,
        query._5,
        query._6,
        query._7,
        query._8,
        query._9
      )
    | let x: Array[TableOrSubquery val] val =>
      let ds: Array[TableOrSubquery val] iso = recover iso Array[TableOrSubquery](x.size() + 1) end
      for x' in x.values() do
        ds.push(x')
      end
      ds.push(TableOrSubquery(subquery))
      apply(
        query._1,
        query._2,
        consume ds,
        query._4,
        query._5,
        query._6,
        query._7,
        query._8,
        query._9
      )
    | let join': JoinClause val =>
      let ds: Array[TableOrSubquery val] val = [TableOrSubquery(subquery)]
      apply(
        query._1,
        query._2,
        ds,
        query._4,
        query._5,
        query._6,
        query._7,
        query._8,
        query._9
      )
    end

  fun val join(
    query: Select val,
    operator: JoinOperator,
    table_or_subquery: TableOrSubquery val,
    contraint: (JoinContraint | None) = None)
  : Select val =>
    match _Select.from(query)
    | let x: TableOrSubquery val =>
      apply(
        query._1,
        query._2,
        (x, [(operator, table_or_subquery, contraint)]),
        query._4,
        query._5,
        query._6,
        query._7,
        query._8,
        query._9
      )
    | let x: Array[TableOrSubquery val] val if x.size() > 0 =>
      try
        apply(
          query._1,
          query._2,
          (x(0)?, [(operator, table_or_subquery, contraint)]),
          query._4,
          query._5,
          query._6,
          query._7,
          query._8,
          query._9
        )
      else
        query
      end
    | let join': JoinClause val =>
      let root = join'._1
      let bodies = join'._2
      let bodies': Array[(JoinOperator, TableOrSubquery val, (JoinContraint | None))] iso = recover iso Array[(JoinOperator, TableOrSubquery val, (JoinContraint | None))](bodies.size() + 1) end
      for body in bodies.values() do
        bodies'.push(body)
      end
      bodies'.push((operator, table_or_subquery, contraint))

      apply(
        query._1,
        query._2,
        (root, consume bodies'),
        query._4,
        query._5,
        query._6,
        query._7,
        query._8,
        query._9
      )
    else
      query
    end

  fun val where_filter(
    query: Select val,
    filter: BoolExpression)
  : Select val =>
    apply(
      query._1,
      query._2,
      query._3,
      filter,
      query._5,
      query._6,
      query._7,
      query._8,
      query._9
    )

  fun val group_by(
    query: Select val,
    group_by': Array[Column] val)
  : Select val =>
    apply(
      query._1,
      query._2,
      query._3,
      query._4,
      group_by',
      query._6,
      query._7,
      query._8,
      query._9
    )

  fun val having(
    query: Select val,
    having': BoolExpression)
  : Select val =>
    apply(
      query._1,
      query._2,
      query._3,
      query._4,
      query._5,
      having',
      query._7,
      query._8,
      query._9
    )

  fun val order_by(
    query: Select val,
    columns: Array[Column] val,
    order: Order = Asc)
  : Select val =>
    apply(
      query._1,
      query._2,
      query._3,
      query._4,
      query._5,
      query._6,
      (columns, order),
      query._8,
      query._9
    )

  fun val limit(
    query: Select val,
    limit': USize)
  : Select val =>
    apply(
      query._1,
      query._2,
      query._3,
      query._4,
      query._5,
      query._6,
      query._7,
      limit',
      query._9
    )

  fun val offset(
    query: Select val,
    offset': USize)
  : Select val =>
    apply(
      query._1,
      query._2,
      query._3,
      query._4,
      query._5,
      query._6,
      query._7,
      query._8,
      offset'
    )

type Insert is
  ( Table val // table
  , Array[Column] val // columns
  , Array[Array[Expression] val] val // values
  )

primitive _Insert
  fun val table(
    query: Insert val)
  : Table val =>
    query._1

  fun val columns(
    query: Insert val)
  : Array[Column] val =>
    query._2

  fun val values(
    query: Insert val)
  : Array[Array[Expression] val] val =>
    query._3

primitive InsertBuilder
  fun val apply(
    table': Table val,
    columns': Array[Column] val,
    values': Array[Array[Expression] val] val)
  : Insert val =>
    ( table'
    , columns'
    , values'
    )

  fun val table(
    query: Insert,
    table': Table val)
  : Insert val =>
    ( table'
    , query._2
    , query._3
    )

  fun val columns(
    query: Insert,
    columns': Array[Column] val)
  : Insert val =>
    ( query._1
    , columns'
    , query._3
    )

  fun val values(
    query: Insert,
    values': Array[Array[Expression] val] val)
  : Insert val =>
    ( query._1
    , query._2
    , values'
    )

type Update is
  ( Table val // table
  , Array[Assignment] val // assignments
  , (BoolExpression | None) // where filter
  )

primitive _Update
  fun val table(
    query: Update)
  : Table val =>
    query._1

  fun val assignments(
    query: Update)
  : Array[Assignment] val =>
    query._2

  fun val where_filter(
    query: Update)
  : (BoolExpression | None) =>
    query._3

primitive UpdateBuilder
  fun val apply(
    table': Table val,
    assignments': Array[Assignment] val,
    where_filter': (BoolExpression | None) = None)
  : Update =>
    ( table'
    , assignments'
    , where_filter'
    )

  fun val table(
    query: Update,
    table': Table val)
  : Update =>
    ( table'
    , query._2
    , query._3
    )

  fun val assignments(
    query: Update,
    assignments': Array[Assignment] val)
  : Update =>
    ( query._1
    , assignments'
    , query._3
    )

  fun val where_filter(
    query: Update,
    where_filter': BoolExpression)
  : Update =>
    ( query._1
    , query._2
    , where_filter'
    )

type Delete is
  ( Table val // table
  , (BoolExpression | None) // where filter
  )

primitive _Delete
  fun val table(
    query: Delete)
  : Table val =>
    query._1

  fun val where_filter(
    query: Delete)
  : (BoolExpression | None) =>
    query._2

primitive DeleteBuilder
  fun val apply(
    table': Table val,
    where_filter': (BoolExpression | None) = None)
  : Delete =>
    ( table'
    , where_filter'
    )

  fun val table(
    query: Delete,
    table': Table val)
  : Delete =>
    ( table'
    , query._2
    )

  fun val where_filter(
    query: Delete,
    where_filter': BoolExpression)
  : Delete =>
    ( query._1
    , where_filter'
    )

trait QueryResolver

  fun val select(
    query: Select,
    corrector: IdentifierCorrector val)
  : String val

  fun val insert(
    query: Insert,
    corrector: IdentifierCorrector val)
  : String val

  fun val update(
    query: Update,
    corrector: IdentifierCorrector val)
  : String val

  fun val delete(
    query: Delete,
    corrector: IdentifierCorrector val)
  : String val
