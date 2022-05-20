use "collections"
use "itertools"
use "json"
use "pony_test"

class \nodoc\ _TestSqliteSchema is UnitTest
  fun name(): String => "Sqlite Schema"

  fun apply(
    h: TestHelper)
  =>
    let corrector = recover val SqliteIdentifierCorrector end
    _int(h, corrector)
    _decimal(h, corrector)
    _float(h, corrector)
    _char(h, corrector)
    _string(h, corrector)
    _text(h, corrector)
    _date(h, corrector)
    _datetime(h, corrector)
    _time(h, corrector)
    _timestamp(h, corrector)
    _timestamps(h, corrector)
    _soft_delete(h, corrector)
    _binary(h, corrector)
    _bool(h, corrector)
    _enum(h, corrector)
    _json(h, corrector)
    _foreign(h, corrector)
    _index(h, corrector)

  fun _int(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.integer("int") end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, int INTEGER NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.integer("int") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, int INTEGER)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.integer("int") .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, int INTEGER UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.integer("int", I64(0)) .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, int INTEGER DEFAULT 0)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.integer("int") .> nullable() .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, int INTEGER CHECK (int > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.integer("int") .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, int INTEGER NOT NULL CHECK (int > 0))")

  fun _decimal(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.decimal("decimal", 5, 3) end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, decimal DECIMAL(5,3) NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.decimal("decimal", 5, 3) .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, decimal DECIMAL(5,3))")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.decimal("decimal", 5, 3) .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, decimal DECIMAL(5,3) UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.decimal("decimal", 5, 3, 0.0) .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, decimal DECIMAL(5,3) DEFAULT 0)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.decimal("decimal", 5, 3) .> nullable() .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, decimal DECIMAL(5,3) CHECK (decimal > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.decimal("decimal", 5, 3) .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, decimal DECIMAL(5,3) NOT NULL CHECK (decimal > 0))")

  fun _float(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.float("float") end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, float REAL NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.float("float") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, float REAL)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.float("float") .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, float REAL UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.float("float", 0.0) .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, float REAL DEFAULT 0)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.float("float") .> nullable() .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, float REAL CHECK (float > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.float("float") .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, float REAL NOT NULL CHECK (float > 0))")

  fun _char(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.char("char", 255) end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, char VARCHAR NOT NULL CHECK (length(char) <= 255))")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.char("char", 255) .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, char VARCHAR CHECK (length(char) <= 255))")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.char("char", 255) .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, char VARCHAR UNIQUE CHECK (length(char) <= 255))")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.char("char", 255, "") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, char VARCHAR DEFAULT '' CHECK (length(char) <= 255))")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.char("char", 255) .> nullable() .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, char VARCHAR CHECK (char > 0) CHECK (length(char) <= 255))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.char("char", 255) .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, char VARCHAR NOT NULL CHECK (char > 0) CHECK (length(char) <= 255))")

  fun _string(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.string("string", 255) end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, string VARCHAR NOT NULL CHECK (length(string) <= 255))")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.string("string", 255) .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, string VARCHAR CHECK (length(string) <= 255))")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.string("string", 255) .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, string VARCHAR UNIQUE CHECK (length(string) <= 255))")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.string("string", 255, "") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, string VARCHAR DEFAULT '' CHECK (length(string) <= 255))")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.string("string", 255) .> nullable() .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, string VARCHAR CHECK (string > 0) CHECK (length(string) <= 255))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.string("string", 255) .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, string VARCHAR NOT NULL CHECK (string > 0) CHECK (length(string) <= 255))")

  fun _text(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.text("text") end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.text("text") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.text("text") .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.text("text", "") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT DEFAULT '')")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.text("text") .> nullable() .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT CHECK (text > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.text("text") .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT NOT NULL CHECK (text > 0))")

  fun _date(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.date("date") end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.date("date") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.date("date") .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.date("date", true) .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE DEFAULT CURRENT_TIMESTAMP)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.date("date") .> nullable() .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE CHECK (date > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.date("date") .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE NOT NULL CHECK (date > 0))")

  fun _datetime(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.datetime("datetime") end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, datetime DATETIME NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.datetime("datetime") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, datetime DATETIME)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.datetime("datetime") .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, datetime DATETIME UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.datetime("datetime", true) .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, datetime DATETIME DEFAULT CURRENT_TIMESTAMP)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.datetime("datetime") .> nullable() .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, datetime DATETIME CHECK (datetime > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.datetime("datetime") .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, datetime DATETIME NOT NULL CHECK (datetime > 0))")

  fun _time(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.time("time") end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, time TIME NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.time("time") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, time TIME)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.time("time") .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, time TIME UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.time("time", true) .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, time TIME DEFAULT CURRENT_TIMESTAMP)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.time("time") .> nullable() .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, time TIME CHECK (time > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.time("time") .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, time TIME NOT NULL CHECK (time > 0))")

  fun _timestamp(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.timestamp("timestamp") end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp DATETIME NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.timestamp("timestamp") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp DATETIME)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.timestamp("timestamp") .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp DATETIME UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.timestamp("timestamp", true) .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.timestamp("timestamp") .> nullable() .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp DATETIME CHECK (timestamp > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.timestamp("timestamp") .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp DATETIME NOT NULL CHECK (timestamp > 0))")

  fun _timestamps(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.timestamps() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP)")

  fun _soft_delete(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.soft_delete() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, deleted_at DATETIME)")

  fun _binary(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.binary("binary") end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, binary BLOB NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.binary("binary") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, binary BLOB)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.binary("binary") .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, binary BLOB UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.binary("binary", "") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, binary BLOB DEFAULT '')")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.binary("binary") .> nullable() .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, binary BLOB CHECK (binary > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.binary("binary") .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, binary BLOB NOT NULL CHECK (binary > 0))")

  fun _bool(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.boolean("boolean") end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, boolean BOOLEAN NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.boolean("boolean") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, boolean BOOLEAN)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.boolean("boolean") .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, boolean BOOLEAN UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.boolean("boolean", true) .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, boolean BOOLEAN DEFAULT true)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.boolean("boolean", false) .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, boolean BOOLEAN DEFAULT false)")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.boolean("boolean") .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, boolean BOOLEAN NOT NULL CHECK (boolean > 0))")

  fun _enum(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let enum: Set[String val] trn = recover trn Set[String val](3) end
    enum.set("a")
    enum.set("b")
    enum.set("c")
    let enum_array: Array[String val] iso = recover iso Array[String val](3) end
    for item in enum.values() do
      enum_array.push(item)
    end
    let enum': Set[String val] val = consume enum
    let enum_array': Array[String val] val = consume enum_array

    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.enum("enum", enum') end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, enum VARCHAR NOT NULL CHECK (" + " OR ".join(Iter[String val](enum_array'.values()).map[String val]({(x: String val): String val => "enum = '" + x + "'"})) + "))")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.enum("enum", enum') .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, enum VARCHAR CHECK (" + " OR ".join(Iter[String val](enum_array'.values()).map[String val]({(x: String val): String val => "enum = '" + x + "'"})) + "))")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.enum("enum", enum') .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, enum VARCHAR UNIQUE CHECK (" + " OR ".join(Iter[String val](enum_array'.values()).map[String val]({(x: String val): String val => "enum = '" + x + "'"})) + "))")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.enum("enum", enum', "a") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, enum VARCHAR DEFAULT 'a' CHECK (" + " OR ".join(Iter[String val](enum_array'.values()).map[String val]({(x: String val): String val => "enum = '" + x + "'"})) + "))")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.enum("enum", enum') .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, enum VARCHAR NOT NULL CHECK (enum > 0) CHECK (" + " OR ".join(Iter[String val](enum_array'.values()).map[String val]({(x: String val): String val => "enum = '" + x + "'"})) + "))")

  fun _json(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.json("json") end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, json TEXT NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.json("json") .> nullable() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, json TEXT)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.json("json") .> nullable() .> unique() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, json TEXT UNIQUE)")

    try
      let json: JsonDoc val = recover val JsonDoc .> parse("{\"key\":\"value\"}")? end
      let table4: Table val =
        object val is Table
          fun box name(): String => "test"

          fun box columns(): Array[Column val] val =>
            [
              recover val Column.increments("id") end
              recover val Column.json("json", json) .> nullable() end
            ]
        end
      h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, json TEXT DEFAULT '{\"key\":\"value\"}')")
    else
      h.fail("Failed to parse json string")
    end

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.json("json") .> nullable() .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, json TEXT CHECK (json > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.json("json") .> unsigned() end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, json TEXT NOT NULL CHECK (json > 0))")

  fun _foreign(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let foreign_primary_key: Column val = recover val Column.increments("id") end
    let foreign_table: Table val =
      object val is Table
        fun box name(): String => "foreign"

        fun box columns(): Array[Column val] val =>
          [
            foreign_primary_key
          ]
      end

    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.foreign("foreign") .> reference(foreign_primary_key) .> on(foreign_table) .> on_delete(Cascade) end
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 'foreign' INTEGER NOT NULL, FOREIGN KEY('foreign') REFERENCES 'foreign'(id) ON DELETE CASCADE)")

  fun _index(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>

    let table: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column val] val =>
          [
            recover val Column.increments("id") end
            recover val Column.integer("idx") .> index() end
          ]
      end

    let stmts: Array[String val] = Array[String val]

    for column in table.columns().values() do
      if (column.mask and _Index()) == _Index() then
        stmts.push(SqliteSchemaResolver.create_index(table, column, corrector))
      end
    end
    h.assert_eq[USize](stmts.size(), 1)
    try
      h.assert_eq[String val](stmts(0)?, "CREATE INDEX test_idx_index ON test(idx)")
    else
      h.fail("Expect at least one index statement")
    end
