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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.integer("int")
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, int INTEGER NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.integer("int"))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, int INTEGER)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.integer("int")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, int INTEGER UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.integer("int", I64(0)))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, int INTEGER DEFAULT 0)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.nullable(ColumnBuilder.integer("int")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, int INTEGER CHECK (int > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.integer("int"))
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.decimal("decimal", 5, 3)
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, decimal DECIMAL(5,3) NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.decimal("decimal", 5, 3))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, decimal DECIMAL(5,3))")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.decimal("decimal", 5, 3)))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, decimal DECIMAL(5,3) UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.decimal("decimal", 5, 3, 0.0))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, decimal DECIMAL(5,3) DEFAULT 0)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.nullable(ColumnBuilder.decimal("decimal", 5, 3)))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, decimal DECIMAL(5,3) CHECK (decimal > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.decimal("decimal", 5, 3))
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.float("float")
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, float REAL NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.float("float"))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, float REAL)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.float("float")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, float REAL UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.float("float", 0.0))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, float REAL DEFAULT 0)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.nullable(ColumnBuilder.float("float")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, float REAL CHECK (float > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.float("float"))
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.char("char", 255)
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, char VARCHAR NOT NULL CHECK (length(char) <= 255))")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.char("char", 255))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, char VARCHAR CHECK (length(char) <= 255))")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.char("char", 255)))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, char VARCHAR UNIQUE CHECK (length(char) <= 255))")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.char("char", 255, ""))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, char VARCHAR DEFAULT '' CHECK (length(char) <= 255))")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.nullable(ColumnBuilder.char("char", 255)))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, char VARCHAR CHECK (char > 0) CHECK (length(char) <= 255))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.char("char", 255))
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.string("string", 255)
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, string VARCHAR NOT NULL CHECK (length(string) <= 255))")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.string("string", 255))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, string VARCHAR CHECK (length(string) <= 255))")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.string("string", 255)))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, string VARCHAR UNIQUE CHECK (length(string) <= 255))")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.string("string", 255, ""))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, string VARCHAR DEFAULT '' CHECK (length(string) <= 255))")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.nullable(ColumnBuilder.string("string", 255)))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, string VARCHAR CHECK (string > 0) CHECK (length(string) <= 255))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.string("string", 255))
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.text("text")
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.text("text"))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.text("text")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.text("text", ""))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT DEFAULT '')")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.nullable(ColumnBuilder.text("text")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT CHECK (text > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.text("text"))
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.date("date")
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.date("date"))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.date("date")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.date("date", true))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE DEFAULT CURRENT_TIMESTAMP)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.nullable(ColumnBuilder.date("date")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE CHECK (date > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.date("date"))
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.datetime("datetime")
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, datetime DATETIME NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.datetime("datetime"))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, datetime DATETIME)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.datetime("datetime")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, datetime DATETIME UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.datetime("datetime", true))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, datetime DATETIME DEFAULT CURRENT_TIMESTAMP)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.nullable(ColumnBuilder.datetime("datetime")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, datetime DATETIME CHECK (datetime > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.datetime("datetime"))
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.time("time")
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, time TIME NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.time("time"))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, time TIME)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.time("time")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, time TIME UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.time("time", true))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, time TIME DEFAULT CURRENT_TIMESTAMP)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.nullable(ColumnBuilder.time("time")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, time TIME CHECK (time > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.time("time"))
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.timestamp("timestamp")
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp DATETIME NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.timestamp("timestamp"))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp DATETIME)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.timestamp("timestamp")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp DATETIME UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.timestamp("timestamp", true))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.nullable(ColumnBuilder.timestamp("timestamp")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp DATETIME CHECK (timestamp > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.timestamp("timestamp"))
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.timestamps()
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.soft_delete()
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.binary("binary")
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, binary BLOB NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.binary("binary"))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, binary BLOB)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.binary("binary")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, binary BLOB UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.binary("binary", ""))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, binary BLOB DEFAULT '')")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.nullable(ColumnBuilder.binary("binary")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, binary BLOB CHECK (binary > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.binary("binary"))
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.boolean("boolean")
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, boolean BOOLEAN NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.boolean("boolean"))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, boolean BOOLEAN)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.boolean("boolean")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, boolean BOOLEAN UNIQUE)")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.boolean("boolean", true))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, boolean BOOLEAN DEFAULT true)")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.boolean("boolean", false))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, boolean BOOLEAN DEFAULT false)")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.boolean("boolean"))
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.enum("enum", enum')
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, enum VARCHAR NOT NULL CHECK (" + " OR ".join(Iter[String val](enum_array'.values()).map[String val]({(x: String val): String val => "enum = '" + x + "'"})) + "))")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.enum("enum", enum'))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, enum VARCHAR CHECK (" + " OR ".join(Iter[String val](enum_array'.values()).map[String val]({(x: String val): String val => "enum = '" + x + "'"})) + "))")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.enum("enum", enum')))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, enum VARCHAR UNIQUE CHECK (" + " OR ".join(Iter[String val](enum_array'.values()).map[String val]({(x: String val): String val => "enum = '" + x + "'"})) + "))")

    let table4: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.enum("enum", enum', "a"))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, enum VARCHAR DEFAULT 'a' CHECK (" + " OR ".join(Iter[String val](enum_array'.values()).map[String val]({(x: String val): String val => "enum = '" + x + "'"})) + "))")

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.enum("enum", enum'))
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.json("json")
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table1, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, json TEXT NOT NULL)")

    let table2: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.nullable(ColumnBuilder.json("json"))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table2, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, json TEXT)")

    let table3: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unique(ColumnBuilder.nullable(ColumnBuilder.json("json")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table3, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, json TEXT UNIQUE)")

    try
      let json: JsonDoc val = recover val JsonDoc .> parse("{\"key\":\"value\"}")? end
      let table4: Table val =
        object val is Table
          fun box name(): String => "test"

          fun box columns(): Array[Column] val =>
            [
              ColumnBuilder.increments("id")
              ColumnBuilder.nullable(ColumnBuilder.json("json", json))
            ]
        end
      h.assert_eq[String val](SqliteSchemaResolver.create_table(table4, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, json TEXT DEFAULT '{\"key\":\"value\"}')")
    else
      h.fail("Failed to parse json string")
    end

    let table5: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.nullable(ColumnBuilder.json("json")))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table5, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, json TEXT CHECK (json > 0))")

    let table6: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.unsigned(ColumnBuilder.json("json"))
          ]
      end
    h.assert_eq[String val](SqliteSchemaResolver.create_table(table6, corrector), "CREATE TABLE test (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, json TEXT NOT NULL CHECK (json > 0))")

  fun _foreign(
    h: TestHelper,
    corrector: IdentifierCorrector val)
  =>
    let foreign_primary_key: Column = ColumnBuilder.increments("id")
    let foreign_table: Table val =
      object val is Table
        fun box name(): String => "foreign"

        fun box columns(): Array[Column] val =>
          [
            foreign_primary_key
          ]
      end

    let table1: Table val =
      object val is Table
        fun box name(): String => "test"

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.on_delete(ColumnBuilder.on(ColumnBuilder.reference(ColumnBuilder.foreign("foreign"), foreign_primary_key), foreign_table), Cascade)
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

        fun box columns(): Array[Column] val =>
          [
            ColumnBuilder.increments("id")
            ColumnBuilder.index(ColumnBuilder.integer("idx"))
          ]
      end

    let stmts: Array[String val] = Array[String val]

    for column in table.columns().values() do
      if (_Column.mask(column) and _Index()) == _Index() then
        stmts.push(SqliteSchemaResolver.create_index(table, column, corrector))
      end
    end
    h.assert_eq[USize](stmts.size(), 1)
    try
      h.assert_eq[String val](stmts(0)?, "CREATE INDEX test_idx_index ON test(idx)")
    else
      h.fail("Expect at least one index statement")
    end
