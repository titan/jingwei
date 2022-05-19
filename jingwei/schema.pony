trait SchemaResolver

  fun val create_table(
    table: Table val,
    corrector: IdentifierCorrector val)
  : String val

  fun val create_index(
    table: Table val,
    column: Column,
    corrector: IdentifierCorrector val)
  : String val

primitive Schema
  fun apply(
    resolver: SchemaResolver val,
    corrector: IdentifierCorrector val,
    tables: Array[Table val] val)
  : (Array[String val] val, Array[String val] val) =>
    let table_stmts: Array[String val] iso = recover iso Array[String val](tables.size()) end
    let index_stmts: Array[String val] iso = recover iso Array[String val](tables.size()) end
    for table in tables.values() do
      table_stmts.push(resolver.create_table(table, corrector))
      for column in table.columns().values() do
        if (_Column.mask(column) and _Index()) == _Index() then
          index_stmts.push(resolver.create_index(table, column, corrector))
        end
      end
    end
    (consume table_stmts, consume index_stmts)
