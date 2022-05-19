use "collections"
use "pony_test"

class \nodoc\ _TestColumn is UnitTest
  fun name(): String => "Column"

  fun apply(
    h: TestHelper)
  =>
    let col1: Column = ColumnBuilder.boolean("test", true)
    h.assert_eq[String](_Column.name(col1), "test")
    h.assert_eq[U8]((_Column.mask(col1) and _Default()), _Default())
    h.assert_eq[Bool](_Column.default_boolean_value(col1), true)

    let col2: Column = ColumnBuilder.integer("test", I64(3))
    h.assert_eq[String](_Column.name(col2), "test")
    h.assert_eq[U8]((_Column.mask(col2) and _Default()), _Default())
    h.assert_eq[I64](_Column.default_integer_value(col2), I64(3))

    let col3: Column = ColumnBuilder.float("test", F64(3.14))
    h.assert_eq[String](_Column.name(col3), "test")
    h.assert_eq[U8]((_Column.mask(col3) and _Default()), _Default())
    h.assert_eq[F64](_Column.default_float_value(col3), F64(3.14))

    let col4: Column = ColumnBuilder.string("test", 255, "string")
    h.assert_eq[String](_Column.name(col4), "test")
    h.assert_eq[U8]((_Column.mask(col4) and _Default()), _Default())
    h.assert_eq[String](try _Column.default_string_value(col4) as String else "" end, "string")

    let col5: Column = ColumnBuilder.decimal("test", 5, 2, F64(3.14))
    h.assert_eq[String](_Column.name(col5), "test")
    h.assert_eq[U8]((_Column.mask(col5) and _Default()), _Default())
    h.assert_eq[F64](_Column.default_float_value(col5), F64(3.14))
    h.assert_eq[I64](try (_Column.meta(col5) as Map[String val, (I64 | String val | Array[String val] val)] val)("maximum")? as I64 else I64(0) end, I64(5))
    h.assert_eq[I64](try (_Column.meta(col5) as Map[String val, (I64 | String val | Array[String val] val)] val)("digit")? as I64 else I64(0) end, I64(2))

    let col6: Column = ColumnBuilder.nullable(ColumnBuilder.integer("test"))
    h.assert_eq[String](_Column.name(col6), "test")
    h.assert_eq[U8]((_Column.mask(col6) and _Nullable()), _Nullable())

    let col7: Column = ColumnBuilder.unsigned(ColumnBuilder.integer("test"))
    h.assert_eq[String](_Column.name(col7), "test")
    h.assert_eq[U8]((_Column.mask(col7) and _Unsigned()), _Unsigned())

    let col8: Column = ColumnBuilder.unique(ColumnBuilder.integer("test"))
    h.assert_eq[String](_Column.name(col8), "test")
    h.assert_eq[U8]((_Column.mask(col8) and _Unique()), _Unique())

    let col9: Column = ColumnBuilder.index(ColumnBuilder.integer("test"))
    h.assert_eq[String](_Column.name(col9), "test")
    h.assert_eq[U8]((_Column.mask(col9) and _Index()), _Index())

    let col10: Column = ColumnBuilder.increments("test")
    h.assert_eq[String](_Column.name(col10), "test")
    h.assert_eq[DataType](_Column.datatype(col10), DataTypeIncrements)

    let col11: Column = ColumnBuilder.integer("test")
    h.assert_eq[String](_Column.name(col11), "test")
    h.assert_eq[DataType](_Column.datatype(col11), DataTypeInteger)

    let col12: Column = ColumnBuilder.small_integer("test")
    h.assert_eq[String](_Column.name(col12), "test")
    h.assert_eq[DataType](_Column.datatype(col12), DataTypeSmallInteger)

    let col13: Column = ColumnBuilder.medium_integer("test")
    h.assert_eq[String](_Column.name(col13), "test")
    h.assert_eq[DataType](_Column.datatype(col13), DataTypeMediumInteger)

    let col14: Column = ColumnBuilder.big_integer("test")
    h.assert_eq[String](_Column.name(col14), "test")
    h.assert_eq[DataType](_Column.datatype(col14), DataTypeBigInteger)

    let col15: Column = ColumnBuilder.decimal("test", 5, 2)
    h.assert_eq[String](_Column.name(col15), "test")
    h.assert_eq[DataType](_Column.datatype(col15), DataTypeDecimal)
    h.assert_eq[I64](try (_Column.meta(col15) as Map[String val, (I64 | String val | Array[String val] val)] val)("maximum")? as I64 else I64(0) end, I64(5))
    h.assert_eq[I64](try (_Column.meta(col15) as Map[String val, (I64 | String val | Array[String val] val)] val)("digit")? as I64 else I64(0) end, I64(2))

    let col16: Column = ColumnBuilder.double("test", 5, 2)
    h.assert_eq[String](_Column.name(col16), "test")
    h.assert_eq[DataType](_Column.datatype(col16), DataTypeDouble)
    h.assert_eq[I64](try (_Column.meta(col16) as Map[String val, (I64 | String val | Array[String val] val)] val)("maximum")? as I64 else I64(0) end, I64(5))
    h.assert_eq[I64](try (_Column.meta(col16) as Map[String val, (I64 | String val | Array[String val] val)] val)("digit")? as I64 else I64(0) end, I64(2))

    let col17: Column = ColumnBuilder.float("test")
    h.assert_eq[String](_Column.name(col17), "test")
    h.assert_eq[DataType](_Column.datatype(col17), DataTypeFloat)

    let col18: Column = ColumnBuilder.char("test", 10)
    h.assert_eq[String](_Column.name(col18), "test")
    h.assert_eq[DataType](_Column.datatype(col18), DataTypeChar)
    h.assert_eq[I64](try (_Column.meta(col18) as Map[String val, (I64 | String val | Array[String val] val)] val)("max-length")? as I64 else I64(0) end, I64(10))

    let col19: Column = ColumnBuilder.string("test", 100)
    h.assert_eq[String](_Column.name(col19), "test")
    h.assert_eq[DataType](_Column.datatype(col19), DataTypeString)
    h.assert_eq[I64](try (_Column.meta(col19) as Map[String val, (I64 | String val | Array[String val] val)] val)("max-length")? as I64 else I64(0) end, I64(100))

    let col20: Column = ColumnBuilder.uuid("test")
    h.assert_eq[String](_Column.name(col20), "test")
    h.assert_eq[DataType](_Column.datatype(col20), DataTypeString)
    h.assert_eq[I64](try (_Column.meta(col20) as Map[String val, (I64 | String val | Array[String val] val)] val)("max-length")? as I64 else I64(0) end, I64(255))

    let col21: Column = ColumnBuilder.text("test")
    h.assert_eq[String](_Column.name(col21), "test")
    h.assert_eq[DataType](_Column.datatype(col21), DataTypeText)

    let col22: Column = ColumnBuilder.medium_text("test")
    h.assert_eq[String](_Column.name(col22), "test")
    h.assert_eq[DataType](_Column.datatype(col22), DataTypeMediumText)

    let col23: Column = ColumnBuilder.long_text("test")
    h.assert_eq[String](_Column.name(col23), "test")
    h.assert_eq[DataType](_Column.datatype(col23), DataTypeLongText)

    let col24: Column = ColumnBuilder.date("test")
    h.assert_eq[String](_Column.name(col24), "test")
    h.assert_eq[DataType](_Column.datatype(col24), DataTypeDate)

    let col25: Column = ColumnBuilder.datetime("test")
    h.assert_eq[String](_Column.name(col25), "test")
    h.assert_eq[DataType](_Column.datatype(col25), DataTypeDateTime)

    let col26: Column = ColumnBuilder.time("test")
    h.assert_eq[String](_Column.name(col26), "test")
    h.assert_eq[DataType](_Column.datatype(col26), DataTypeTime)

    let col27: Column = ColumnBuilder.timestamp("test")
    h.assert_eq[String](_Column.name(col27), "test")
    h.assert_eq[DataType](_Column.datatype(col27), DataTypeTimestamp)

    let col28: Column = ColumnBuilder.timestamps()
    h.assert_eq[DataType](_Column.datatype(col28), DataTypeTimestamps)

    let col29: Column = ColumnBuilder.soft_delete()
    h.assert_eq[DataType](_Column.datatype(col29), DataTypeSoftDelete)

    let col30: Column = ColumnBuilder.binary("test")
    h.assert_eq[String](_Column.name(col30), "test")
    h.assert_eq[DataType](_Column.datatype(col30), DataTypeBinary)

    let col31: Column = ColumnBuilder.boolean("test")
    h.assert_eq[String](_Column.name(col31), "test")
    h.assert_eq[DataType](_Column.datatype(col31), DataTypeBoolean)

    let enum: Set[String val] trn = recover trn Set[String val](3) end
    enum.set("a")
    enum.set("b")
    enum.set("c")
    let enum_array: Array[String val] iso = recover iso Array[String val](3) end
    for item in enum.values() do
      enum_array.push(item)
    end
    let col32: Column = ColumnBuilder.enum("test", consume enum)
    h.assert_eq[String](_Column.name(col32), "test")
    h.assert_eq[DataType](_Column.datatype(col32), DataTypeEnum)
    h.assert_array_eq[String val](try (_Column.meta(col32) as Map[String val, (I64 | String val | Array[String val] val)] val)("options")? as Array[String val] val else [as String val:] end, consume enum_array)

    let col33: Column = ColumnBuilder.json("test")
    h.assert_eq[String](_Column.name(col33), "test")
    h.assert_eq[DataType](_Column.datatype(col33), DataTypeJson)

    let col34': Column = ColumnBuilder.integer("id")
    let table: Table val =
      object val is Table
        fun box name(): String val => "other"

        fun box columns(): Array[Column] val => [ col34' ]
      end
    let col34: Column = ColumnBuilder.on_delete(ColumnBuilder.on(ColumnBuilder.reference(ColumnBuilder.foreign("test"), col34'), table), SetNull)
    h.assert_eq[String](_Column.name(col34), "test")
    h.assert_eq[DataType](_Column.datatype(col34), DataTypeForeign)
    h.assert_eq[String](try (_Column.meta(col34) as Map[String val, (I64 | String val | Array[String val] val)] val)("column")? as String else "" end, "id")
    h.assert_eq[String](try (_Column.meta(col34) as Map[String val, (I64 | String val | Array[String val] val)] val)("table")? as String val else "" end, "other")
    h.assert_eq[ForeignOnDelete ](_Column.foreign_on_delete(col34), SetNull)
