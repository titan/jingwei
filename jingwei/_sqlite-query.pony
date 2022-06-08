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
    let id = recover val Column.increments("id") end
    let int = recover val Column.integer("int") .> nullable() end
    let cols: Array[ResultColumn] val = [
      id
      int
    ]
    let table_foo: Table val =
      object val is Table
        fun box name(): String => "foo"

        fun box columns(): Array[Column val] val => [
          id
          int
        ]
      end
    let table_bar: Table val =
      object val is Table
        fun box name(): String => "bar"

        fun box columns(): Array[Column val] val => [
          id
          int
        ]
      end

    let select1 = recover val Select(cols) .> from_table(table_foo) end
    h.assert_eq[String val](SqliteQueryResolver.select(select1, corrector), "SELECT id, int FROM foo")

    let select2 = recover val Select(cols, true) .> from_table(table_foo) end
    h.assert_eq[String val](SqliteQueryResolver.select(select2, corrector), "SELECT DISTINCT id, int FROM foo")

    let select3 = recover val Select(cols) .> from_subquery(select2) end
    h.assert_eq[String val](SqliteQueryResolver.select(select3, corrector), "SELECT id, int FROM (SELECT DISTINCT id, int FROM foo)")

    let join: JoinClause val = (TableOrSubquery(table_foo), [(Join, TableOrSubquery(table_bar), (On, GreaterThanExpression(id, I64(0))))])
    let select4 = recover val Select(cols, false) .> from_table(table_foo) .> join(TableOrSubquery(table_bar), (On, GreaterThanExpression(id, I64(0)))) end
    h.assert_eq[String val](SqliteQueryResolver.select(select4, corrector), "SELECT id, int FROM foo JOIN bar ON id > 0")

    let select5 = recover val Select(cols) .> from_table(table_foo) .> where_filter(GreaterThanExpression(id, I64(0))) end
    h.assert_eq[String val](SqliteQueryResolver.select(select5, corrector), "SELECT id, int FROM foo WHERE id > 0")

    let select6 = recover val
      Select(cols) .>
      from_table(table_foo) .>
      where_filter(AndExpression(GreaterThanExpression(id, I64(0)), GreaterThanExpression(int, I64(0))))
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select6, corrector), "SELECT id, int FROM foo WHERE (id > 0) AND (int > 0)")

    let select7 = recover val
      Select(cols) .>
      from_table(table_foo) .>
      where_filter(OrExpression(GreaterThanExpression(id, I64(0)), GreaterThanExpression(int, I64(0))))
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select7, corrector), "SELECT id, int FROM foo WHERE (id > 0) OR (int > 0)")

    let select8 = recover val
      Select(cols) .>
      from_table(table_foo) .>
      where_filter(GreaterThanExpression(id, I64(0))) .>
      group_by([int])
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select8, corrector), "SELECT id, int FROM foo WHERE id > 0 GROUP BY int")

    let select9 = recover val
      Select(cols) .>
      from_table(table_foo) .>
      where_filter(GreaterThanExpression(id, I64(0))) .>
      group_by([int]) .>
      having(GreaterThanExpression(ApplyExpression("count", [int]), I64(2)))
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select9, corrector), "SELECT id, int FROM foo WHERE id > 0 GROUP BY int HAVING count(int) > 2")

    let select10 = recover val
      Select(cols) .>
      from_table(table_foo) .>
      where_filter(GreaterThanExpression(id, I64(0))) .>
      group_by([int]) .>
      having(GreaterThanExpression(ApplyExpression("count", [int]), I64(2))) .>
      order_by([int])
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select10, corrector), "SELECT id, int FROM foo WHERE id > 0 GROUP BY int HAVING count(int) > 2 ORDER BY int")

    let select11 = recover val
      Select(cols) .>
      from_table(table_foo) .>
      where_filter(GreaterThanExpression(id, I64(0))) .>
      group_by([int]) .>
      having(GreaterThanExpression(ApplyExpression("count", [int]), I64(2))) .>
      order_by([int]) .>
      limit(10)
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select11, corrector), "SELECT id, int FROM foo WHERE id > 0 GROUP BY int HAVING count(int) > 2 ORDER BY int LIMIT 10")

    let select12 = recover val
      Select(cols) .>
      from_table(table_foo) .>
      where_filter(GreaterThanExpression(id, I64(0))) .>
      group_by([int]) .>
      having(GreaterThanExpression(ApplyExpression("count", [int]), I64(2))) .>
      order_by([int]) .>
      limit(10) .>
      offset(1)
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select12, corrector), "SELECT id, int FROM foo WHERE id > 0 GROUP BY int HAVING count(int) > 2 ORDER BY int LIMIT 10 OFFSET 1")

    let cols13: Array[ResultColumn] val = [
      CountCall(id)
    ]
    let select13 = recover val
      Select(cols13) .>
      from_table(table_foo) .>
      where_filter(GreaterThanExpression(id, I64(0)))
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select13, corrector), "SELECT COUNT(id) FROM foo WHERE id > 0")

    let cols14: Array[ResultColumn] val = [
      CountCall(id, "abort")
    ]
    let select14 = recover val
      Select(cols14) .>
      from_table(table_foo) .>
      where_filter(GreaterThanExpression(id, I64(0)))
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select14, corrector), "SELECT COUNT(id) AS 'abort' FROM foo WHERE id > 0")

    let cols15: Array[ResultColumn] val = [
      MinCall(id)
    ]
    let select15 = recover val
      Select(cols15) .>
      from_table(table_foo) .>
      where_filter(GreaterThanExpression(id, I64(0)))
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select15, corrector), "SELECT MIN(id) FROM foo WHERE id > 0")

    let cols16: Array[ResultColumn] val = [
      MinCall(id, "abort")
    ]
    let select16 = recover val
      Select(cols16) .>
      from_table(table_foo) .>
      where_filter(GreaterThanExpression(id, I64(0)))
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select16, corrector), "SELECT MIN(id) AS 'abort' FROM foo WHERE id > 0")

    let cols17: Array[ResultColumn] val = [
      MaxCall(id)
    ]
    let select17 = recover val
      Select(cols17) .>
      from_table(table_foo) .>
      where_filter(GreaterThanExpression(id, I64(0)))
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select17, corrector), "SELECT MAX(id) FROM foo WHERE id > 0")

    let cols18: Array[ResultColumn] val = [
      MaxCall(id, "abort")
    ]
    let select18 = recover val
      Select(cols18) .>
      from_table(table_foo) .>
      where_filter(GreaterThanExpression(id, I64(0)))
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select18, corrector), "SELECT MAX(id) AS 'abort' FROM foo WHERE id > 0")

    let cols19: Array[ResultColumn] val = [
      AvgCall(id)
    ]
    let select19 = recover val
      Select(cols19) .>
      from_table(table_foo) .>
      where_filter(GreaterThanExpression(id, I64(0)))
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select19, corrector), "SELECT AVG(id) FROM foo WHERE id > 0")

    let cols20: Array[ResultColumn] val = [
      AvgCall(id, "abort")
    ]
    let select20 = recover val
      Select(cols20) .>
      from_table(table_foo) .>
      where_filter(GreaterThanExpression(id, I64(0)))
    end
    h.assert_eq[String val](SqliteQueryResolver.select(select20, corrector), "SELECT AVG(id) AS 'abort' FROM foo WHERE id > 0")

  fun _insert(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let id = recover val Column.increments("id") end
    let int = recover val Column.integer("int") .> nullable() end
    let cols: Array[ResultColumn] val = [
      id
      int
    ]
    let table_foo: Table val =
      object val is Table
        fun box name(): String => "foo"

        fun box columns(): Array[Column val] val => [
          id
          int
        ]
      end
    let insert1 = recover val Insert(table_foo, [int]) .> add_value([I64(1)]) end
    h.assert_eq[String val](SqliteQueryResolver.insert(insert1, corrector), "INSERT INTO foo(int) VALUES (1)")
    let insert2 = recover val Insert(table_foo, [int]) .> add_value([Placeholder]) .> add_value([Placeholder]) end
    h.assert_eq[String val](SqliteQueryResolver.insert(insert2, corrector), "INSERT INTO foo(int) VALUES (?), (?)")

  fun _update(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let id = recover val Column.increments("id") end
    let int = recover val Column.integer("int") .> nullable() end
    let cols: Array[ResultColumn] val = [
      id
      int
    ]
    let table_foo: Table val =
      object val is Table
        fun box name(): String => "foo"

        fun box columns(): Array[Column val] val => [
          id
          int
        ]
      end

    let update1 = recover val Update(table_foo) .> add_assignment(AssignmentBuilder(int, I64(1))) end
    h.assert_eq[String val](SqliteQueryResolver.update(update1, corrector), "UPDATE foo SET int = 1")
    let update2 = recover val
      Update(table_foo) .>
      add_assignment(AssignmentBuilder(int, I64(1))) .>
      where_filter(EqualsToExpression(id, I64(0)))
    end
    h.assert_eq[String val](SqliteQueryResolver.update(update2, corrector), "UPDATE foo SET int = 1 WHERE id = 0")

  fun _delete(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let id = recover val Column.increments("id") end
    let int = recover val Column.integer("int") .> nullable() end
    let cols: Array[ResultColumn] val = [
      id
      int
    ]
    let table_foo: Table val =
      object val is Table
        fun box name(): String => "foo"

        fun box columns(): Array[Column val] val => [
          id
          int
        ]
      end

    let delete1 = recover val Delete(table_foo) end
    h.assert_eq[String val](SqliteQueryResolver.delete(delete1, corrector), "DELETE FROM foo")
    let delete2 = recover val Delete(table_foo) .> where_filter(EqualsToExpression(id, I64(0))) end
    h.assert_eq[String val](SqliteQueryResolver.delete(delete2, corrector), "DELETE FROM foo WHERE id = 0")
