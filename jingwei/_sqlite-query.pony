use "collections"
use "pony_test"

class \nodoc\ _TestSqliteQuery is UnitTest
  fun name(): String => "Sqlite Query"

  fun apply(
    h: TestHelper)
  =>
    let corrector = recover val SqliteIdentifierCorrector end
    _select(h, corrector)
    _insert(h, corrector)
    _update(h, corrector)
    _delete(h, corrector)

  fun _select(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let cols: Array[ResultColumn] val = [
      ColumnBuilder.increments("id")
      ColumnBuilder.nullable(ColumnBuilder.integer("int"))
    ]
    let table_foo: Table val =
      object val is Table
        fun box name(): String => "foo"

        fun box columns(): Array[Column] val => [
          ColumnBuilder.increments("id")
          ColumnBuilder.nullable(ColumnBuilder.integer("int"))
        ]
      end
    let table_bar: Table val =
      object val is Table
        fun box name(): String => "bar"

        fun box columns(): Array[Column] val => [
          ColumnBuilder.increments("id")
          ColumnBuilder.nullable(ColumnBuilder.integer("int"))
        ]
      end

    let select1 = SelectBuilder.from_table(SelectBuilder(cols), table_foo)
    h.assert_eq[String val](SqliteQueryResolver.select(select1, corrector), "SELECT id, int FROM foo")

    let select2 = SelectBuilder.from_table(SelectBuilder(cols, true), table_foo)
    h.assert_eq[String val](SqliteQueryResolver.select(select2, corrector), "SELECT DISTINCT id, int FROM foo")

    let select3 = SelectBuilder.from_subquery(SelectBuilder(cols), select2)
    h.assert_eq[String val](SqliteQueryResolver.select(select3, corrector), "SELECT id, int FROM (SELECT DISTINCT id, int FROM foo)")

    let join: JoinClause val = (TableOrSubquery(table_foo), [(Join, TableOrSubquery(table_bar), (On, GreaterThanExpression(ColumnBuilder.increments("id"), I64(0))))])
    let select4 = SelectBuilder.join(SelectBuilder(cols, false, TableOrSubquery(table_foo)), Join, TableOrSubquery(table_bar), (On, GreaterThanExpression(ColumnBuilder.increments("id"), I64(0))))
    h.assert_eq[String val](SqliteQueryResolver.select(select4, corrector), "SELECT id, int FROM foo JOIN bar ON id > 0")

    let select5 = SelectBuilder.where_filter(SelectBuilder.from_table(SelectBuilder(cols), table_foo), GreaterThanExpression(ColumnBuilder.increments("id"), I64(0)))
    h.assert_eq[String val](SqliteQueryResolver.select(select5, corrector), "SELECT id, int FROM foo WHERE id > 0")

    let select6 = SelectBuilder.where_filter(SelectBuilder.from_table(SelectBuilder(cols), table_foo), AndExpression( GreaterThanExpression(ColumnBuilder.increments("id"), I64(0)), GreaterThanExpression(ColumnBuilder.integer("int"), I64(0))))
    h.assert_eq[String val](SqliteQueryResolver.select(select6, corrector), "SELECT id, int FROM foo WHERE (id > 0) AND (int > 0)")

    let select7 = SelectBuilder.where_filter(SelectBuilder.from_table(SelectBuilder(cols), table_foo), OrExpression( GreaterThanExpression(ColumnBuilder.increments("id"), I64(0)), GreaterThanExpression(ColumnBuilder.integer("int"), I64(0))))
    h.assert_eq[String val](SqliteQueryResolver.select(select7, corrector), "SELECT id, int FROM foo WHERE (id > 0) OR (int > 0)")

    let select8 = SelectBuilder.group_by(SelectBuilder.where_filter(SelectBuilder.from_table(SelectBuilder(cols), table_foo), GreaterThanExpression(ColumnBuilder.increments("id"), I64(0))), [ColumnBuilder.integer("int")])
    h.assert_eq[String val](SqliteQueryResolver.select(select8, corrector), "SELECT id, int FROM foo WHERE id > 0 GROUP BY int")

    let select9 = SelectBuilder.having(SelectBuilder.group_by(SelectBuilder.where_filter(SelectBuilder.from_table(SelectBuilder(cols), table_foo), GreaterThanExpression(ColumnBuilder.increments("id"), I64(0))), [ColumnBuilder.integer("int")]), GreaterThanExpression(ApplyExpression("count", [ColumnBuilder.integer("int")]), I64(2)))
    h.assert_eq[String val](SqliteQueryResolver.select(select9, corrector), "SELECT id, int FROM foo WHERE id > 0 GROUP BY int HAVING count(int) > 2")

    let select10 = SelectBuilder.order_by(SelectBuilder.having(SelectBuilder.group_by(SelectBuilder.where_filter(SelectBuilder.from_table(SelectBuilder(cols), table_foo), GreaterThanExpression(ColumnBuilder.increments("id"), I64(0))), [ColumnBuilder.integer("int")]), GreaterThanExpression(ApplyExpression("count", [ColumnBuilder.integer("int")]), I64(2))), [ColumnBuilder.integer("int")])
    h.assert_eq[String val](SqliteQueryResolver.select(select10, corrector), "SELECT id, int FROM foo WHERE id > 0 GROUP BY int HAVING count(int) > 2 ORDER BY int")

    let select11 = SelectBuilder.limit(SelectBuilder.order_by(SelectBuilder.having(SelectBuilder.group_by(SelectBuilder.where_filter(SelectBuilder.from_table(SelectBuilder(cols), table_foo), GreaterThanExpression(ColumnBuilder.increments("id"), I64(0))), [ColumnBuilder.integer("int")]), GreaterThanExpression(ApplyExpression("count", [ColumnBuilder.integer("int")]), I64(2))), [ColumnBuilder.integer("int")]), 10)
    h.assert_eq[String val](SqliteQueryResolver.select(select11, corrector), "SELECT id, int FROM foo WHERE id > 0 GROUP BY int HAVING count(int) > 2 ORDER BY int LIMIT 10")

    let select12 = SelectBuilder.offset(SelectBuilder.limit(SelectBuilder.order_by(SelectBuilder.having(SelectBuilder.group_by(SelectBuilder.where_filter(SelectBuilder.from_table(SelectBuilder(cols), table_foo), GreaterThanExpression(ColumnBuilder.increments("id"), I64(0))), [ColumnBuilder.integer("int")]), GreaterThanExpression(ApplyExpression("count", [ColumnBuilder.integer("int")]), I64(2))), [ColumnBuilder.integer("int")]), 10), 1)
    h.assert_eq[String val](SqliteQueryResolver.select(select12, corrector), "SELECT id, int FROM foo WHERE id > 0 GROUP BY int HAVING count(int) > 2 ORDER BY int LIMIT 10 OFFSET 1")

  fun _insert(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let cols: Array[ResultColumn] val = [
      ColumnBuilder.increments("id")
      ColumnBuilder.nullable(ColumnBuilder.integer("int"))
    ]
    let table_foo: Table val =
      object val is Table
        fun box name(): String => "foo"

        fun box columns(): Array[Column] val => [
          ColumnBuilder.increments("id")
          ColumnBuilder.nullable(ColumnBuilder.integer("int"))
        ]
      end
    let insert1 = InsertBuilder(table_foo, [ColumnBuilder.integer("int")], [[I64(1)]])
    h.assert_eq[String val](SqliteQueryResolver.insert(insert1, corrector), "INSERT INTO foo(int) VALUES (1)")
    let insert2 = InsertBuilder(table_foo, [ColumnBuilder.integer("int")], [[Placeholder]; [Placeholder]])
    h.assert_eq[String val](SqliteQueryResolver.insert(insert2, corrector), "INSERT INTO foo(int) VALUES (?), (?)")

  fun _update(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let cols: Array[ResultColumn] val = [
      ColumnBuilder.increments("id")
      ColumnBuilder.nullable(ColumnBuilder.integer("int"))
    ]
    let table_foo: Table val =
      object val is Table
        fun box name(): String => "foo"

        fun box columns(): Array[Column] val => [
          ColumnBuilder.increments("id")
          ColumnBuilder.nullable(ColumnBuilder.integer("int"))
        ]
      end

    let update1 = UpdateBuilder(table_foo, [(ColumnBuilder.integer("int"), I64(1))])
    h.assert_eq[String val](SqliteQueryResolver.update(update1, corrector), "UPDATE foo SET int = 1")
    let update2 = UpdateBuilder(table_foo, [(ColumnBuilder.integer("int"), I64(1))], EqualsToExpression(ColumnBuilder.integer("id"), I64(0)))
    h.assert_eq[String val](SqliteQueryResolver.update(update2, corrector), "UPDATE foo SET int = 1 WHERE id = 0")

  fun _delete(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let cols: Array[ResultColumn] val = [
      ColumnBuilder.increments("id")
      ColumnBuilder.nullable(ColumnBuilder.integer("int"))
    ]
    let table_foo: Table val =
      object val is Table
        fun box name(): String => "foo"

        fun box columns(): Array[Column] val => [
          ColumnBuilder.increments("id")
          ColumnBuilder.nullable(ColumnBuilder.integer("int"))
        ]
      end

    let delete1 = DeleteBuilder(table_foo)
    h.assert_eq[String val](SqliteQueryResolver.delete(delete1, corrector), "DELETE FROM foo")
    let delete2 = DeleteBuilder(table_foo, EqualsToExpression(ColumnBuilder.integer("id"), I64(0)))
    h.assert_eq[String val](SqliteQueryResolver.delete(delete2, corrector), "DELETE FROM foo WHERE id = 0")
