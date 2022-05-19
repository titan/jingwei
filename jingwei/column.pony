use "collections"
use "json"

primitive _DefaultSafeIdentifier
  fun val keep_safe(
    identifier: String val)
  : String val =>
    identifier

interface val _DataType is (Equatable[_DataType] & Stringable)

primitive DataTypeIncrements is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeIncrements".clone()

primitive DataTypeInteger is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeInteger".clone()

primitive DataTypeSmallInteger is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeSmallInteger".clone()

primitive DataTypeMediumInteger is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeMediumInteger".clone()

primitive DataTypeBigInteger is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeBigInteger".clone()

primitive DataTypeDecimal is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeDecimal".clone()

primitive DataTypeDouble is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeDouble".clone()

primitive DataTypeFloat is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeFloat".clone()

primitive DataTypeChar is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeChar".clone()

primitive DataTypeString is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeString".clone()

primitive DataTypeText is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeText".clone()

primitive DataTypeMediumText is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeMediumText".clone()

primitive DataTypeLongText is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeLongText".clone()

primitive DataTypeDate is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeDate".clone()

primitive DataTypeDateTime is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeDateTime".clone()

primitive DataTypeTime is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeTime".clone()

primitive DataTypeTimestamp is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeTimestamp".clone()

primitive DataTypeTimestamps is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeTimestamps".clone()

primitive DataTypeSoftDelete is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeSoftDelete".clone()

primitive DataTypeBinary is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeBinary".clone()

primitive DataTypeBoolean is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeBoolean".clone()

primitive DataTypeEnum is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeEnumField".clone()

primitive DataTypeJson is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeJson".clone()

primitive DataTypeForeign is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeForeign".clone()

primitive DataTypeStringForeign is _DataType
  fun eq(
    o: _DataType)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "DataTypeStringForeign".clone()

type DataType is
  ( ( DataTypeIncrements
    | DataTypeInteger
    | DataTypeSmallInteger
    | DataTypeMediumInteger
    | DataTypeBigInteger
    | DataTypeDecimal
    | DataTypeDouble
    | DataTypeFloat
    | DataTypeChar
    | DataTypeString
    | DataTypeText
    | DataTypeMediumText
    | DataTypeLongText
    | DataTypeDate
    | DataTypeDateTime
    | DataTypeTime
    | DataTypeTimestamp
    | DataTypeTimestamps
    | DataTypeSoftDelete
    | DataTypeBinary
    | DataTypeBoolean
    | DataTypeEnum
    | DataTypeJson
    | DataTypeForeign
    | DataTypeStringForeign
    )
  & _DataType
  )

interface val _ForeignOnDelete is (Equatable[_ForeignOnDelete] & Stringable)

primitive Restrict is _ForeignOnDelete
  fun eq(
    o: _ForeignOnDelete)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "Restrict".clone()

primitive Cascade is _ForeignOnDelete
  fun eq(
    o: _ForeignOnDelete)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "Cascade".clone()

primitive SetNull is _ForeignOnDelete
  fun eq(
    o: _ForeignOnDelete)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "SetNull".clone()

primitive NoAction is _ForeignOnDelete
  fun eq(
    o: _ForeignOnDelete)
  : Bool =>
    o is this

  fun string()
  : String iso^ =>
    "NoAction".clone()

type ForeignOnDelete is
  ( ( Restrict
    | Cascade
    | SetNull
    | NoAction
    )
  & _ForeignOnDelete
  )

primitive _Index
  fun apply(): U8 => 0x01

primitive _Nullable
  fun apply(): U8 => 0x02

primitive _Unsigned
  fun apply(): U8 => 0x04

primitive _Default
  fun apply(): U8 => 0x08

primitive _Unique
  fun apply(): U8 => 0x10

type Column is
  ( String val // name
  , DataType // type
  , U8 // bit mask: index / nullable | unsigned | default | unique
  , Bool // default bool value
  , I64 // default int value
  , F64 // default float value
  , (String val | None) // default string value
  , (JsonDoc val | None)// default json value
  , ForeignOnDelete
  , (Map[String val, (I64 | String val | Array[String val] val)] val | None) // meta information
  )

primitive _Column
  fun name(
    col: Column,
    keep_safe: {(String val): String val} box = _DefaultSafeIdentifier~keep_safe())
  : String val =>
    """
    Get column name
    """
    keep_safe(col._1)

  fun datatype(
    col: Column)
  : DataType =>
    """
    Get column type
    """
    col._2

  fun mask(
    col: Column)
  : U8 =>
    """
    Get mask
    """
    col._3

  fun default_boolean_value(
    col: Column)
  : Bool =>
    """
    Get default boolean value
    """
    col._4

  fun default_integer_value(
    col: Column)
  : I64 =>
    """
    Get default integer value
    """
    col._5

  fun default_float_value(
    col: Column)
  : F64 =>
    """
    Get default float value
    """
    col._6

  fun default_string_value(
    col: Column)
  : (String val | None) =>
    """
    Get default string value
    """
    col._7

  fun default_json_value(
    col: Column)
  : (JsonDoc val | None) =>
    """
    Get default json value
    """
    col._8

  fun foreign_on_delete(
    col: Column)
  : ForeignOnDelete =>
    """
    Get foreign on delete
    """
    col._9

  fun meta(
    col: Column)
  : (Map[String val, (I64 | String val | Array[String val] val)] val | None) =>
    """
    Get meta information
    """
    col._10

primitive ColumnBuilder
  fun apply(
    name': String val,
    datatype': DataType,
    mask': U8,
    default_boolean': Bool,
    default_integer': I64,
    default_float': F64,
    default_string': (String val | None),
    default_json': (JsonDoc val | None),
    foreign_on_delete': ForeignOnDelete,
    meta': (Map[String val, (I64 | String val | Array[String val] val)] val | None))
  : Column =>
    ( name'
    , datatype'
    , mask'
    , default_boolean'
    , default_integer'
    , default_float'
    , default_string'
    , default_json'
    , foreign_on_delete'
    , meta'
    )

  fun index(
    col: Column)
  : Column =>
    """
    Mark column as an index
    """
    apply(
      col._1,
      col._2,
      col._3 or _Index(),
      col._4,
      col._5,
      col._6,
      col._7,
      col._8,
      col._9,
      col._10
    )

  fun nullable(
    col: Column)
  : Column =>
    """
    Mark column as nullable
    """
    apply(
      col._1,
      col._2,
      col._3 or _Nullable(),
      col._4,
      col._5,
      col._6,
      col._7,
      col._8,
      col._9,
      col._10
    )

  fun unique(
    col: Column)
  : Column =>
    """
    Mark column as unique
    """
    apply(
      col._1,
      col._2,
      col._3 or _Unique(),
      col._4,
      col._5,
      col._6,
      col._7,
      col._8,
      col._9,
      col._10
    )

  fun unsigned(
    col: Column)
  : Column =>
    """
    Mark column as unsigned
    """
    apply(
      col._1,
      col._2,
      col._3 or _Unsigned(),
      col._4,
      col._5,
      col._6,
      col._7,
      col._8,
      col._9,
      col._10
    )

  /////////
  // int //
  /////////
  fun increments(
    name': String val)
  : Column =>
    apply(
      name',
      DataTypeIncrements,
      0,
      false,
      I64(0),
      F64(0.0),
      None,
      None,
      NoAction,
      None
    )

  fun integer(
    name': String val,
    default: (I64 | None) = None)
  : Column =>
    match default
    | let default': I64 =>
      apply(
        name',
        DataTypeInteger,
        _Default(),
        false,
        default',
        F64(0.0),
        None,
        None,
        NoAction,
        None
      )
    else
      apply(
        name',
        DataTypeInteger,
        0,
        false,
        I64(0),
        F64(0.0),
        None,
        None,
        NoAction,
        None
      )
    end

  fun small_integer(
    name': String val,
    default: (I64 | None) = None)
  : Column =>
    match default
    | let default': I64 =>
      apply(
        name',
        DataTypeSmallInteger,
        _Default(),
        false,
        default',
        F64(0.0),
        None,
        None,
        NoAction,
        None
      )
    else
      apply(
        name',
        DataTypeSmallInteger,
        0,
        false,
        I64(0),
        F64(0.0),
        None,
        None,
        NoAction,
        None
      )
    end

  fun medium_integer(
    name': String val,
    default: (I64 | None) = None)
  : Column =>
    match default
    | let default': I64 =>
      apply(
        name',
        DataTypeMediumInteger,
        _Default(),
        false,
        default',
        F64(0.0),
        None,
        None,
        NoAction,
        None
      )
    else
      apply(
        name',
        DataTypeMediumInteger,
        0,
        false,
        I64(0),
        F64(0.0),
        None,
        None,
        NoAction,
        None
      )
    end

  fun big_integer(
    name': String val,
    default: (I64 | None) = None)
  : Column =>
    match default
    | let default': I64 =>
      apply(
        name',
        DataTypeBigInteger,
        _Default(),
        false,
        default',
        F64(0.0),
        None,
        None,
        NoAction,
        None
      )
    else
      apply(
        name',
        DataTypeBigInteger,
        0,
        false,
        I64(0),
        F64(0.0),
        None,
        None,
        NoAction,
        None
      )
    end

  ///////////
  // float //
  ///////////
  fun decimal(
    name': String val,
    maximum: USize,
    digit: USize,
    default: (F64 | None) = None)
  : Column =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    meta'("maximum") = maximum.i64()
    meta'("digit") = digit.i64()
    match default
    | let default': F64 =>
      apply(
        name',
        DataTypeDecimal,
        _Default(),
        false,
        I64(0),
        default',
        None,
        None,
        NoAction,
        consume meta'
      )
    else
      apply(
        name',
        DataTypeDecimal,
        0,
        false,
        I64(0),
        F64(0.0),
        None,
        None,
        NoAction,
        consume meta'
      )
    end

  fun double(
    name': String val,
    maximum: USize,
    digit: USize,
    default: (F64 | None) = None)
  : Column =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    meta'("maximum") = maximum.i64()
    meta'("digit") = digit.i64()
    match default
    | let default': F64 =>
      apply(
        name',
        DataTypeDouble,
        _Default(),
        false,
        I64(0),
        default',
        None,
        None,
        NoAction,
        consume meta'
      )
    else
      apply(
        name',
        DataTypeDouble,
        0,
        false,
        I64(0),
        F64(0.0),
        None,
        None,
        NoAction,
        consume meta'
      )
    end

  fun float(
    name': String val,
    default: (F64 | None) = None)
  : Column =>
    match default
    | let default': F64 =>
      apply(
        name',
        DataTypeFloat,
        _Default(),
        false,
        I64(0),
        default',
        None,
        None,
        NoAction,
        None
      )
    else
      apply(
        name',
        DataTypeFloat,
        0,
        false,
        I64(0),
        F64(0.0),
        None,
        None,
        NoAction,
        None
      )
    end

  //////////
  // char //
  //////////
  fun char(
    name': String val,
    max_length: USize,
    default: (String val | None) = None)
  : Column =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    meta'("max-length") = max_length.i64()
    apply(
      name',
      DataTypeChar,
      if default is None then 0 else _Default() end,
      false,
      I64(0),
      F64(0.0),
      default,
      None,
      NoAction,
      consume meta'
    )

  fun string(
    name': String val,
    max_length: USize = 255,
    default: (String val | None) = None)
  : Column =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    meta'("max-length") = max_length.i64()
    apply(
      name',
      DataTypeString,
      if default is None then 0 else _Default() end,
      false,
      I64(0),
      F64(0.0),
      default,
      None,
      NoAction,
      consume meta'
    )

  fun uuid(
    name': String val)
  : Column =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    meta'("max-length") = I64(255)
    apply(
      name',
      DataTypeString,
      _Unique() or _Index(),
      false,
      I64(0),
      F64(0.0),
      None,
      None,
      NoAction,
      consume meta'
    )

  fun text(
    name': String val,
    default: (String val | None) = None)
  : Column =>
    apply(
      name',
      DataTypeText,
      if default is None then 0 else _Default() end,
      false,
      I64(0),
      F64(0.0),
      default,
      None,
      NoAction,
      None
    )

  fun medium_text(
    name': String val,
    default: (String val | None) = None)
  : Column =>
    apply(
      name',
      DataTypeMediumText,
      if default is None then 0 else _Default() end,
      false,
      I64(0),
      F64(0.0),
      default,
      None,
      NoAction,
      None
    )

  fun long_text(
    name': String val,
    default: (String val | None) = None)
  : Column =>
    apply(
      name',
      DataTypeLongText,
      if default is None then 0 else _Default() end,
      false,
      I64(0),
      F64(0.0),
      default,
      None,
      NoAction,
      None
    )

  //////////
  // date //
  //////////
  fun date(
    name': String val,
    default: Bool = false)
  : Column =>
    apply(
      name',
      DataTypeDate,
      if default then _Default() else 0 end,
      false,
      I64(0),
      F64(0.0),
      None,
      None,
      NoAction,
      None
    )

  fun datetime(
    name': String val,
    default: Bool = false)
  : Column =>
    apply(
      name',
      DataTypeDateTime,
      if default then _Default() else 0 end,
      false,
      I64(0),
      F64(0.0),
      None,
      None,
      NoAction,
      None
    )

  fun time(
    name': String val,
    default: Bool = false)
  : Column =>
    apply(
      name',
      DataTypeTime,
      if default then _Default() else 0 end,
      false,
      I64(0),
      F64(0.0),
      None,
      None,
      NoAction,
      None
    )

  fun timestamp(
    name': String val,
    default: Bool = false)
  : Column =>
    apply(
      name',
      DataTypeTimestamp,
      if default then _Default() else 0 end,
      false,
      I64(0),
      F64(0.0),
      None,
      None,
      NoAction,
      None
    )

  fun timestamps()
  : Column =>
    apply(
      "",
      DataTypeTimestamps,
      0,
      false,
      I64(0),
      F64(0.0),
      None,
      None,
      NoAction,
      None
    )

  fun soft_delete()
  : Column =>
    apply(
      "",
      DataTypeSoftDelete,
      0,
      false,
      I64(0),
      F64(0.0),
      None,
      None,
      NoAction,
      None
    )

  ////////////
  // others //
  ////////////
  fun binary(
    name': String val,
    default: (String val | None) = None)
  : Column =>
    apply(
      name',
      DataTypeBinary,
      if default is None then 0 else _Default() end,
      false,
      I64(0),
      F64(0.0),
      default,
      None,
      NoAction,
      None
    )

  fun boolean(
    name': String val,
    default: (Bool | None) = None)
  : Column =>
    match default
    | let default': Bool =>
      apply(
        name',
        DataTypeBoolean,
        _Default(),
        default',
        I64(0),
        F64(0.0),
        None,
        None,
        NoAction,
        None
      )
    else
      apply(
        name',
        DataTypeBoolean,
        0,
        false,
        I64(0),
        F64(0.0),
        None,
        None,
        NoAction,
        None
      )
    end

  fun enum(
    name': String val,
    options: Set[String val] val,
    default: (String val | None) = None)
  : Column =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    let array: Array[String val] iso = recover iso Array[String val](options.size()) end
    for opt in options.values() do
      array.push(opt)
    end
    meta'("options") = consume array
    apply(
      name',
      DataTypeEnum,
      if default is None then 0 else _Default() end,
      false,
      I64(0),
      F64(0.0),
      default,
      None,
      NoAction,
      consume meta'
    )

  fun json(
    name': String val,
    default: (JsonDoc val | None) = None)
  : Column =>
    apply(
      name',
      DataTypeJson,
      if default is None then 0 else _Default() end,
      false,
      I64(0),
      F64(0.0),
      None,
      default,
      NoAction,
      None
    )

  /////////////
  // foreign //
  /////////////
  fun foreign(
    name': String val,
    default: (I64 | None) = None)
  : Column =>
    match default
    | let default': I64 =>
      apply(
        name',
        DataTypeForeign,
        _Index() or _Default(),
        false,
        default',
        F64(0.0),
        None,
        None,
        NoAction,
        None
      )
    else
      apply(
        name',
        DataTypeForeign,
        _Index(),
        false,
        I64(0),
        F64(0.0),
        None,
        None,
        NoAction,
        None
      )
    end

  fun string_foreign(
    name': String val,
    length: USize = 255,
    default: (String val | None))
  : Column =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    meta'("max-length") = length.i64()
    apply(
      name',
      DataTypeForeign,
      if default is None then _Index() else _Index() or _Default() end,
      false,
      I64(0),
      F64(0.0),
      default,
      None,
      NoAction,
      consume meta'
    )

  fun reference(
    col: Column,
    column: Column)
  : Column =>
    let newmeta: Map[String val, (I64 | String val | Array[String val] val)] trn =
      match _Column.meta(col)
      | let meta': Map[String val, (I64 | String val | Array[String val] val)] val =>
        let meta'': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
        for (k, v) in meta'.pairs() do
          meta''(k) = v
        end
        meta''("column") = _Column.name(column)
        consume meta''
      else
        let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
        meta'("column") = _Column.name(column)
        consume meta'
      end
    apply(
      col._1,
      col._2,
      col._3,
      col._4,
      col._5,
      col._6,
      col._7,
      col._8,
      col._9,
      consume newmeta
    )

  fun on(
    col: Column,
    table: Table val)
  : Column =>
    let newmeta: Map[String val, (I64 | String val | Array[String val] val)] trn =
      match _Column.meta(col)
      | let meta': Map[String val, (I64 | String val | Array[String val] val)] val =>
        let meta'': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
        for (k, v) in meta'.pairs() do
          meta''(k) = v
        end
        meta''("table") = table.name()
        consume meta''
      else
        let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
        meta'("table") = table.name()
        consume meta'
      end
    apply(
      col._1,
      col._2,
      col._3,
      col._4,
      col._5,
      col._6,
      col._7,
      col._8,
      col._9,
      consume newmeta
    )

  fun on_delete(
    col: Column,
    delete: ForeignOnDelete)
  : Column =>
    apply(
      col._1,
      col._2,
      col._3,
      col._4,
      col._5,
      col._6,
      col._7,
      col._8,
      delete,
      col._10
    )
