use "collections"
use "itertools"
use "json"

primitive SqliteSchemaResolver is SchemaResolver

  fun val create_table(
    table: Table val,
    corrector: IdentifierCorrector val)
  : String val =>
    let field_stmts: Array[String val] iso = recover iso Array[String val](table.columns().size()) end
    let foreign_stmts: Array[String val] iso = recover iso Array[String val](table.columns().size()) end
    for column in table.columns().values() do
      let colname = corrector.correct(column.name)
      let mask = column.mask
      let nullable = (mask and _Nullable()) == _Nullable()
      let unique = (mask and _Unique()) == _Unique()
      let unsigned = (mask and _Unsigned()) == _Unsigned()
      let default = (mask and _Default()) == _Default()
      let meta = column.meta
      match column.datatype
      | DataTypeIncrements =>
        field_stmts.push(_increments(colname))
      | DataTypeInteger =>
        let value: I64 = column.default_integer_value
        field_stmts.push(_integer(colname, nullable, unique, unsigned, default, value))
      | DataTypeSmallInteger =>
        let value: I64 = column.default_integer_value
        field_stmts.push(_integer(colname, nullable, unique, unsigned, default, value))
      | DataTypeMediumInteger =>
        let value: I64 = column.default_integer_value
        field_stmts.push(_integer(colname, nullable, unique, unsigned, default, value))
      | DataTypeBigInteger =>
        let value: I64 = column.default_integer_value
        field_stmts.push(_integer(colname, nullable, unique, unsigned, default, value))
      | DataTypeDecimal =>
        let value: F64 = column.default_float_value
        field_stmts.push(_decimal(colname, nullable, unique, unsigned, default, value, meta))
      | DataTypeDouble =>
        let value: F64 = column.default_float_value
        field_stmts.push(_float(colname, nullable, unique, unsigned, default, value))
      | DataTypeFloat =>
        let value: F64 = column.default_float_value
        field_stmts.push(_float(colname, nullable, unique, unsigned, default, value))
      | DataTypeChar =>
        let value: (String val | None) = column.default_string_value
        field_stmts.push(_char(colname, nullable, unique, unsigned, default, value, meta))
      | DataTypeString =>
        let value: (String val | None) = column.default_string_value
        field_stmts.push(_varchar(colname, nullable, unique, unsigned, default, value, meta))
      | DataTypeText =>
        let value: (String val | None) = column.default_string_value
        field_stmts.push(_text(colname, nullable, unique, unsigned, default, value))
      | DataTypeMediumText =>
        let value: (String val | None) = column.default_string_value
        field_stmts.push(_text(colname, nullable, unique, unsigned, default, value))
      | DataTypeLongText =>
        let value: (String val | None) = column.default_string_value
        field_stmts.push(_text(colname, nullable, unique, unsigned, default, value))
      | DataTypeDate =>
        field_stmts.push(_date(colname, nullable, unique, unsigned, default))
      | DataTypeDateTime =>
        field_stmts.push(_datetime(colname, nullable, unique, unsigned, default))
      | DataTypeTime =>
        field_stmts.push(_time(colname, nullable, unique, unsigned, default))
      | DataTypeTimestamp =>
        field_stmts.push(_timestamp(colname, nullable, unique, unsigned, default))
      | DataTypeTimestamps =>
        field_stmts.push(_timestamps())
      | DataTypeSoftDelete =>
        field_stmts.push(_soft_delete())
      | DataTypeBinary =>
        let value: (String val | None) = column.default_string_value
        field_stmts.push(_blob(colname, nullable, unique, unsigned, default, value))
      | DataTypeBoolean =>
        let value: Bool = column.default_boolean_value
        field_stmts.push(_bool(colname, nullable, unique, unsigned, default, value))
      | DataTypeEnum =>
        let value: (String val | None) = column.default_string_value
        field_stmts.push(_enum(colname, nullable, unique, unsigned, default, value, meta))
      | DataTypeJson =>
        let value: (JsonDoc val | None) = column.default_json_value
        field_stmts.push(_json(colname, nullable, unique, unsigned, default, value))
      | DataTypeForeign =>
        let value: I64 = column.default_integer_value
        field_stmts.push(_foreign(colname, nullable, unique, unsigned, default, value))
        foreign_stmts.push(_foreign_key(column, corrector))
      | DataTypeStringForeign =>
        let value: (String val | None) = column.default_string_value
        field_stmts.push(_string_foreign(colname, nullable, unique, unsigned, default, value))
        foreign_stmts.push(_foreign_key(column, corrector))
      end
    end
    let fields: String val = ", ".join((consume field_stmts).values())
    let foreigns: String val = ", ".join((consume foreign_stmts).values())
    let name: String val = corrector.correct(table.name())
    let result: String iso = recover iso String("CREATE TABLE IF NOT EXISTS  (, )".size() + name.size() + fields.size() + foreigns.size()) end
    if foreigns.size() > 0 then
      (consume result) .> append("CREATE TABLE IF NOT EXISTS ") .> append(name) .> append(" (") .> append(fields) .> append(", ") .> append(foreigns) .> append(")")
    else
      (consume result) .> append("CREATE TABLE IF NOT EXISTS ") .> append(name) .> append(" (") .> append(fields) .> append(")")
    end

  fun val create_index(
    table: Table val,
    column: Column val,
    corrector: IdentifierCorrector val)
  : String val =>
    let name = corrector.correct(table.name())
    let lower_name: String val = name.lower()
    let col: String val = corrector.correct(column.name)
    let lower_col: String val = col.lower()
    let result: String iso = recover iso String("CREATE INDEX IF NOT EXISTS __index ON ()".size() + (name.size() << 1) + (col.size() << 1)) end
    (consume result) .> append("CREATE INDEX IF NOT EXISTS ") .> append(lower_name) .> append("_") .> append(lower_col) .> append("_index ON ") .> append(name) .> append("(") .> append(col) .> append(")")

  fun val _increments(
    name: String val)
  : String val =>
    let def: String val = " INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT"
    let result: String iso = recover iso String(def.size() + name.size()) end
    (consume result) .> append(name) .> append(def)

  fun val _integer(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool,
    default_value: I64)
  : String val =>
    _template(name, " INTEGER", nullable, unique, unsigned, default, default_value.string())

  fun val _decimal(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool,
    default_value: F64,
    meta: (Map[String val, (I64 | String val | Array[String val] val)] val | None))
  : String val =>
    let maximum: String val = try ((meta as Map[String val, (I64 | String val | Array[String val] val)] val)("maximum")? as I64).string() else "10" end
    let digit: String val = try ((meta as Map[String val, (I64 | String val | Array[String val] val)] val)("digit")? as I64).string() else "5" end
    let tipe: String iso = recover iso String(" DECIMAL(,)".size() + maximum.size() + digit.size()) end
    _template(name, (consume tipe) .> append(" DECIMAL(") .> append(maximum) .> append(",") .> append(digit) .> append(")"), nullable, unique, unsigned, default, default_value.string())

  fun val _float(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool,
    default_value: F64)
  : String val =>
    _template(name, " REAL", nullable, unique, unsigned, default, default_value.string())

  fun val _char(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool,
    default_value: (String val | None),
    meta: (Map[String val, (I64 | String val | Array[String val] val)] val | None))
  : String val =>
    let max_length: String val =
      match meta
      | let meta': Map[String val, (I64 | String val | Array[String val] val)] val =>
        try
          match meta'("max-length")?
          | let x: I64 =>
            x.string()
          else
            "0"
          end
        else
          "0"
        end
      else
        "0"
      end
    let length_check: String iso = recover iso String(" CHECK (length() <= )".size() + name.size() + max_length.size()) end
    match default_value
    | let x: String val =>
      let value: String iso = recover iso String(" DEFAULT ''".size() + x.size()) end
      _template(name, " VARCHAR", nullable, unique, unsigned, default,
        (consume value) .> append("'") .> append(x) .> append("'"),
        (consume length_check) .> append(" CHECK (length(") .> append(name) .> append(") <= ") .> append(max_length) .> append(")"))
    else
      _template(name, " VARCHAR", nullable, unique, unsigned, false, "",
        (consume length_check) .> append(" CHECK (length(") .> append(name) .> append(") <= ") .> append(max_length) .> append(")"))
    end

  fun val _varchar(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool,
    default_value: (String val | None),
    meta: (Map[String val, (I64 | String val | Array[String val] val)] val | None))
  : String val =>
    let max_length: String val =
      match meta
      | let meta': Map[String val, (I64 | String val | Array[String val] val)] val =>
        try
          match meta'("max-length")?
          | let x: I64 =>
            x.string()
          else
            "0"
          end
        else
          "0"
        end
      else
        "0"
      end
    let length_check: String iso = recover iso String(" CHECK (length() <= )".size() + name.size() + max_length.size()) end
    match default_value
    | let x: String val =>
      let value: String iso = recover iso String(" DEFAULT ''".size() + x.size()) end
      _template(name, " VARCHAR", nullable, unique, unsigned, default,
        (consume value) .> append("'") .> append(x) .> append("'"),
        (consume length_check) .> append(" CHECK (length(") .> append(name) .> append(") <= ") .> append(max_length) .> append(")"))
    else
      _template(name, " VARCHAR", nullable, unique, unsigned, false, "",
        (consume length_check) .> append(" CHECK (length(") .> append(name) .> append(") <= ") .> append(max_length) .> append(")"))
    end

  fun val _text(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool,
    default_value: (String val | None))
  : String val =>
    match default_value
    | let x: String val =>
      let value: String iso = recover iso String(" DEFAULT ''".size() + x.size()) end
      _template(name, " TEXT", nullable, unique, unsigned, default,
        (consume value) .> append("'") .> append(x) .> append("'"))
    else
      _template(name, " TEXT", nullable, unique, unsigned, false, "")
    end

  fun val _date(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool)
  : String val =>
    _template(name, " DATE", nullable, unique, unsigned, default, "CURRENT_TIMESTAMP")

  fun val _datetime(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool)
  : String val =>
    _template(name, " DATETIME", nullable, unique, unsigned, default, "CURRENT_TIMESTAMP")

  fun val _time(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool)
  : String val =>
    _template(name, " TIME", nullable, unique, unsigned, default, "CURRENT_TIMESTAMP")

  fun val _timestamp(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool)
  : String val =>
    _template(name, " DATETIME", nullable, unique, unsigned, default, "CURRENT_TIMESTAMP")

  fun val _timestamps()
  : String val =>
    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP"

  fun val _soft_delete()
  : String val =>
    "deleted_at DATETIME"

  fun val _blob(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool,
    default_value: (String val | None))
  : String val =>
    match default_value
    | let value: String val =>
      let value': String iso = recover iso String(value.size() + 2) end
      _template(name, " BLOB", nullable, unique, unsigned, default, (consume value') .> append("'") .> append(value) .> append("'"))
    else
      _template(name, " BLOB", nullable, unique, unsigned, false, "")
    end

  fun val _bool(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool,
    default_value: Bool)
  : String val =>
    _template(name, " BOOLEAN", nullable, unique, unsigned, default, default_value.string())

  fun val _enum(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool,
    default_value: (String val | None),
    meta: (Map[String val, (I64 | String val | Array[String val] val)] val | None))
  : String val =>
    let options: Array[String val] val =
      match meta
      | let meta': Map[String val, (I64 | String val | Array[String val] val)] val =>
        try
          match meta'("options")?
          | let x: Array[String val] val =>
            x
          else
            [as String val:]
          end
        else
          [as String val:]
        end
      else
        [as String val:]
      end
    let enum_check_expression: String iso = recover iso String(Iter[String val](options.values()).fold[USize](0, {(acc: USize, x: String val) => acc + x.size() + name.size() + 5}) + " CHECK ()".size()) end
    enum_check_expression.append(" CHECK (")
    for (idx, x) in options.pairs() do
      if idx != 0 then
        enum_check_expression.append(" OR ")
      end
      enum_check_expression.append(name)
      enum_check_expression.append(" = '")
      enum_check_expression.append(x)
      enum_check_expression.append("'")
    end
    enum_check_expression.append(")")

    match default_value
    | let x: String val =>
      let value : String iso = recover iso String(2 + x.size()) end
      _template(name, " VARCHAR", nullable, unique, unsigned, default,
        (consume value) .> append("'") .> append(x) .> append("'"),
        consume enum_check_expression)
    else
      _template(name, " VARCHAR", nullable, unique, unsigned, false, "", consume enum_check_expression)
    end

  fun val _json(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool,
    default_value: (JsonDoc val | None))
  : String val =>
    match default_value
    | let doc: JsonDoc val =>
      let x: String val = doc.string()
      let value : String iso = recover iso String(2 + x.size()) end
      _template(name, " TEXT", nullable, unique, unsigned, default,
        (consume value) .> append("'") .> append(x) .> append("'"))
    else
      _template(name, " TEXT", nullable, unique, unsigned, false, "")
    end

  fun val _foreign(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool,
    default_value: I64)
  : String val =>
    let value: String val = default_value.string()
      _template(name, " INTEGER", nullable, unique, unsigned, default, value)

  fun val _string_foreign(
    name: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool,
    default_value: (String val | None))
  : String val =>
    match default_value
    | let value: String val =>
      _template(name, " VARCHAR", nullable, unique, unsigned, default, value)
    else
      _template(name, " VARCHAR", nullable, unique, unsigned, false, "")
    end

  fun val _foreign_key(
    column: Column val,
    corrector: IdentifierCorrector val)
  : String val =>
    if (column.datatype is DataTypeForeign) or
      (column.datatype is DataTypeStringForeign) then
      let meta: (Map[String val, (I64 | String val | Array[String val] val)] val | None) = column.meta
      let name: String val = corrector.correct(column.name)
      let table: String val =
        match meta
        | let meta': Map[String val, (I64 | String val | Array[String val] val)] val =>
          try
            match meta'("table")?
            | let x: String val =>
              corrector.correct(x)
            else
              "error table name"
            end
          else
            "missing table name"
          end
        else
            "missing table name"
        end
      let col: String val =
        match meta
        | let meta': Map[String val, (I64 | String val | Array[String val] val)] val =>
          try
            match meta'("column")?
            | let x: String val =>
              corrector.correct(x)
            else
              "error column name"
            end
          else
            "missing column name"
          end
        else
            "missing column name"
        end
      let delete: String val =
        match column.foreign_on_delete
        | Restrict => "RESTRICT"
        | Cascade => "CASCADE"
        | SetNull => "SET NULL"
        | NoAction => "NO ACTION"
        else
          "NO ACTION"
        end
      let result: String iso = recover iso String("FOREIGN KEY() REFERENCES () ON DELETE ".size() + name.size() + table.size() + col.size() + delete.size()) end
      (consume result) .> append("FOREIGN KEY(") .> append(name) .> append(") REFERENCES ") .> append(table) .> append("(") .> append(col) .> append(") ON DELETE ") .> append(delete)
    else
      ""
    end

  fun val _template(
    name: String val,
    tipe: String val,
    nullable: Bool,
    unique: Bool,
    unsigned: Bool,
    default: Bool,
    default_value: String val,
    more_check: (String val | None) = None)
  : String val =>
    let result: String iso =
      recover iso
        String(
          name.size() + tipe.size() +
          if not nullable then " NOT NULL".size() else 0 end +
          if unique then " UNIQUE".size() else 0 end +
          if unsigned then " CHECK ( > 0)".size() + name.size() else 0 end +
          if default then " DEFAULT ".size() + default_value.size() else 0 end +
          match more_check
          | let check: String val =>
            check.size()
          else
            0
          end
        )
      end
    result.append(name)
    result.append(tipe)
    if not nullable then
      result.append(" NOT NULL")
    end
    if unique then
      result.append(" UNIQUE")
    end
    if default then
      result.append(" DEFAULT ")
      result.append(default_value)
    end
    if unsigned then
      result.append(" CHECK (")
      result.append(name)
      result.append(" > 0)")
    end
    match more_check
    | let check: String val =>
      result.append(check)
    end
    consume result
