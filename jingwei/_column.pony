use "collections"
use "pony_test"

class \nodoc\ _TestColumn is UnitTest
  fun name(): String => "Column"

  fun apply(
    h: TestHelper)
  =>
    let col1: Column val = recover val Column.boolean("test", true) end
    h.assert_eq[String](col1.name, "test")
    h.assert_eq[U8]((col1.mask and _Default()), _Default())
    h.assert_eq[Bool](col1.default_boolean_value, true)

    let col2: Column val = recover val Column.integer("test", I64(3)) end
    h.assert_eq[String](col2.name, "test")
    h.assert_eq[U8]((col2.mask and _Default()), _Default())
    h.assert_eq[I64](col2.default_integer_value, I64(3))

    let col3: Column val = recover val Column.float("test", F64(3.14)) end
    h.assert_eq[String](col3.name, "test")
    h.assert_eq[U8]((col3.mask and _Default()), _Default())
    h.assert_eq[F64](col3.default_float_value, F64(3.14))

    let col4: Column val = recover val Column.string("test", 255, "string") end
    h.assert_eq[String](col4.name, "test")
    h.assert_eq[U8]((col4.mask and _Default()), _Default())
    h.assert_eq[String](try col4.default_string_value as String else "" end, "string")

    let col5: Column val = recover val Column.decimal("test", 5, 2, F64(3.14)) end
    h.assert_eq[String](col5.name, "test")
    h.assert_eq[U8]((col5.mask and _Default()), _Default())
    h.assert_eq[F64](col5.default_float_value, F64(3.14))
    h.assert_eq[I64](try (col5.meta as Map[String val, (I64 | String val | Array[String val] val)] val)("maximum")? as I64 else I64(0) end, I64(5))
    h.assert_eq[I64](try (col5.meta as Map[String val, (I64 | String val | Array[String val] val)] val)("digit")? as I64 else I64(0) end, I64(2))

    let col6: Column val = recover val Column.integer("test") .> nullable() end
    h.assert_eq[String](col6.name, "test")
    h.assert_eq[U8]((col6.mask and _Nullable()), _Nullable())

    let col7: Column val = recover val Column.integer("test") .> unsigned() end
    h.assert_eq[String](col7.name, "test")
    h.assert_eq[U8]((col7.mask and _Unsigned()), _Unsigned())

    let col8: Column val = recover val Column.integer("test") .> unique() end
    h.assert_eq[String](col8.name, "test")
    h.assert_eq[U8]((col8.mask and _Unique()), _Unique())

    let col9: Column val = recover val Column.integer("test") .> index() end
    h.assert_eq[String](col9.name, "test")
    h.assert_eq[U8]((col9.mask and _Index()), _Index())

    let col10: Column val = recover val Column.increments("test") end
    h.assert_eq[String](col10.name, "test")
    h.assert_eq[DataType](col10.datatype, DataTypeIncrements)

    let col11: Column val = recover val Column.integer("test") end
    h.assert_eq[String](col11.name, "test")
    h.assert_eq[DataType](col11.datatype, DataTypeInteger)

    let col12: Column val = recover val Column.small_integer("test") end
    h.assert_eq[String](col12.name, "test")
    h.assert_eq[DataType](col12.datatype, DataTypeSmallInteger)

    let col13: Column val = recover val Column.medium_integer("test") end
    h.assert_eq[String](col13.name, "test")
    h.assert_eq[DataType](col13.datatype, DataTypeMediumInteger)

    let col14: Column val = recover val Column.big_integer("test") end
    h.assert_eq[String](col14.name, "test")
    h.assert_eq[DataType](col14.datatype, DataTypeBigInteger)

    let col15: Column val = recover val Column.decimal("test", 5, 2) end
    h.assert_eq[String](col15.name, "test")
    h.assert_eq[DataType](col15.datatype, DataTypeDecimal)
    h.assert_eq[I64](try (col15.meta as Map[String val, (I64 | String val | Array[String val] val)] val)("maximum")? as I64 else I64(0) end, I64(5))
    h.assert_eq[I64](try (col15.meta as Map[String val, (I64 | String val | Array[String val] val)] val)("digit")? as I64 else I64(0) end, I64(2))

    let col16: Column val = recover val Column.double("test", 5, 2) end
    h.assert_eq[String](col16.name, "test")
    h.assert_eq[DataType](col16.datatype, DataTypeDouble)
    h.assert_eq[I64](try (col16.meta as Map[String val, (I64 | String val | Array[String val] val)] val)("maximum")? as I64 else I64(0) end, I64(5))
    h.assert_eq[I64](try (col16.meta as Map[String val, (I64 | String val | Array[String val] val)] val)("digit")? as I64 else I64(0) end, I64(2))

    let col17: Column val = recover val Column.float("test") end
    h.assert_eq[String](col17.name, "test")
    h.assert_eq[DataType](col17.datatype, DataTypeFloat)

    let col18: Column val = recover val Column.char("test", 10) end
    h.assert_eq[String](col18.name, "test")
    h.assert_eq[DataType](col18.datatype, DataTypeChar)
    h.assert_eq[I64](try (col18.meta as Map[String val, (I64 | String val | Array[String val] val)] val)("max-length")? as I64 else I64(0) end, I64(10))

    let col19: Column val = recover val Column.string("test", 100) end
    h.assert_eq[String](col19.name, "test")
    h.assert_eq[DataType](col19.datatype, DataTypeString)
    h.assert_eq[I64](try (col19.meta as Map[String val, (I64 | String val | Array[String val] val)] val)("max-length")? as I64 else I64(0) end, I64(100))

    let col20: Column val = recover val Column.uuid("test") end
    h.assert_eq[String](col20.name, "test")
    h.assert_eq[DataType](col20.datatype, DataTypeString)
    h.assert_eq[I64](try (col20.meta as Map[String val, (I64 | String val | Array[String val] val)] val)("max-length")? as I64 else I64(0) end, I64(255))

    let col21: Column val = recover val Column.text("test") end
    h.assert_eq[String](col21.name, "test")
    h.assert_eq[DataType](col21.datatype, DataTypeText)

    let col22: Column val = recover val Column.medium_text("test") end
    h.assert_eq[String](col22.name, "test")
    h.assert_eq[DataType](col22.datatype, DataTypeMediumText)

    let col23: Column val = recover val Column.long_text("test") end
    h.assert_eq[String](col23.name, "test")
    h.assert_eq[DataType](col23.datatype, DataTypeLongText)

    let col24: Column val = recover val Column.date("test") end
    h.assert_eq[String](col24.name, "test")
    h.assert_eq[DataType](col24.datatype, DataTypeDate)

    let col25: Column val = recover val Column.datetime("test") end
    h.assert_eq[String](col25.name, "test")
    h.assert_eq[DataType](col25.datatype, DataTypeDateTime)

    let col26: Column val = recover val Column.time("test") end
    h.assert_eq[String](col26.name, "test")
    h.assert_eq[DataType](col26.datatype, DataTypeTime)

    let col27: Column val = recover val Column.timestamp("test") end
    h.assert_eq[String](col27.name, "test")
    h.assert_eq[DataType](col27.datatype, DataTypeTimestamp)

    let col28: Column val = recover val Column.timestamps() end
    h.assert_eq[DataType](col28.datatype, DataTypeTimestamps)

    let col29: Column val = recover val Column.soft_delete() end
    h.assert_eq[DataType](col29.datatype, DataTypeSoftDelete)

    let col30: Column val = recover val Column.binary("test") end
    h.assert_eq[String](col30.name, "test")
    h.assert_eq[DataType](col30.datatype, DataTypeBinary)

    let col31: Column val = recover val Column.boolean("test") end
    h.assert_eq[String](col31.name, "test")
    h.assert_eq[DataType](col31.datatype, DataTypeBoolean)

    let enum: Set[String val] trn = recover trn Set[String val](3) end
    enum.set("a")
    enum.set("b")
    enum.set("c")
    let enum_array: Array[String val] iso = recover iso Array[String val](3) end
    for item in enum.values() do
      enum_array.push(item)
    end
    let enum': Set[String val] val = consume enum
    let col32: Column val = recover val Column.enum("test", enum') end
    h.assert_eq[String](col32.name, "test")
    h.assert_eq[DataType](col32.datatype, DataTypeEnum)
    h.assert_array_eq[String val](try (col32.meta as Map[String val, (I64 | String val | Array[String val] val)] val)("options")? as Array[String val] val else [as String val:] end, consume enum_array)

    let col33: Column val = recover val Column.json("test") end
    h.assert_eq[String](col33.name, "test")
    h.assert_eq[DataType](col33.datatype, DataTypeJson)

    let col34': Column val = recover val Column.integer("id") end
    let table: Table val =
      object val is Table
        fun box name(): String val => "other"

        fun box columns(): Array[Column val] val => [ col34' ]
      end
    let col34: Column val = recover val Column.foreign("test") .> reference(col34') .> on(table) .> on_delete(SetNull) end
    h.assert_eq[String](col34.name, "test")
    h.assert_eq[DataType](col34.datatype, DataTypeForeign)
    h.assert_eq[String](try (col34.meta as Map[String val, (I64 | String val | Array[String val] val)] val)("column")? as String else "" end, "id")
    h.assert_eq[String](try (col34.meta as Map[String val, (I64 | String val | Array[String val] val)] val)("table")? as String val else "" end, "other")
    h.assert_eq[ForeignOnDelete ](col34.foreign_on_delete, SetNull)
