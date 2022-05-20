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

class Column
  var name: String val
  var datatype: DataType
  var mask: U8 = U8(0)
  var default_boolean_value: Bool = false
  var default_integer_value: I64 = I64(0)
  var default_float_value: F64 = F64(0)
  var default_string_value: (String val | None) = None
  var default_json_value: (JsonDoc val | None) = None
  var foreign_on_delete: ForeignOnDelete = NoAction
  var meta: (Map[String val, (I64 | String val | Array[String val] val)] val | None) = None

  new create(
    name': String val,
    datatype': DataType)
  =>
    name = name'
    datatype = datatype'

  fun ref index()
  =>
    """
    Mark column as an index
    """
    mask = mask or _Index()

  fun ref nullable()
  =>
    """
    Mark column as nullable
    """
    mask = mask or _Nullable()

  fun ref unique()
  =>
    """
    Mark column as unique
    """
    mask = mask or _Unique()

  fun ref unsigned()
  =>
    """
    Mark column as unsigned
    """
    mask = mask or _Unsigned()

  /////////
  // int //
  /////////
  new increments(
    name': String val)
  =>
    name = name'
    datatype = DataTypeIncrements

  new integer(
    name': String val,
    default: (I64 | None) = None)
  =>
    name = name'
    datatype = DataTypeInteger
    match default
    | let default': I64 =>
      mask = _Default()
      default_integer_value = default'
    end

  new small_integer(
    name': String val,
    default: (I64 | None) = None)
  =>
    name = name'
    datatype = DataTypeSmallInteger
    match default
    | let default': I64 =>
      mask = _Default()
      default_integer_value = default'
    end

  new medium_integer(
    name': String val,
    default: (I64 | None) = None)
  =>
    name = name'
    datatype = DataTypeMediumInteger
    match default
    | let default': I64 =>
      mask = _Default()
      default_integer_value = default'
    end

  new big_integer(
    name': String val,
    default: (I64 | None) = None)
  =>
    name = name'
    datatype = DataTypeBigInteger
    match default
    | let default': I64 =>
      mask = _Default()
      default_integer_value = default'
    end

  ///////////
  // float //
  ///////////
  new decimal(
    name': String val,
    maximum: USize,
    digit: USize,
    default: (F64 | None) = None)
  =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    meta'("maximum") = maximum.i64()
    meta'("digit") = digit.i64()
    meta = consume meta'
    name = name'
    datatype = DataTypeDecimal
    match default
    | let default': F64 =>
      mask = _Default()
      default_float_value = default'
    end

  new double(
    name': String val,
    maximum: USize,
    digit: USize,
    default: (F64 | None) = None)
  =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    meta'("maximum") = maximum.i64()
    meta'("digit") = digit.i64()
    meta = consume meta'
    name = name'
    datatype = DataTypeDouble
    match default
    | let default': F64 =>
      mask = _Default()
      default_float_value = default'
    end

  new float(
    name': String val,
    default: (F64 | None) = None)
  =>
    name = name'
    datatype = DataTypeFloat
    match default
    | let default': F64 =>
      mask = _Default()
      default_float_value = default'
    end

  //////////
  // char //
  //////////
  new char(
    name': String val,
    max_length: USize,
    default: (String val | None) = None)
  =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    meta'("max-length") = max_length.i64()
    meta = consume meta'
    name = name'
    datatype = DataTypeChar
    if not (default is None) then
      mask = _Default()
      default_string_value = default
    end

  new string(
    name': String val,
    max_length: USize = 255,
    default: (String val | None) = None)
  =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    meta'("max-length") = max_length.i64()
    meta = consume meta'
    name = name'
    datatype = DataTypeString
    if not (default is None) then
      mask = _Default()
      default_string_value = default
    end

  new uuid(
    name': String val)
  =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    meta'("max-length") = I64(255)
    meta = consume meta'
    name = name'
    datatype = DataTypeString
    mask = _Unique() or _Index()

  new text(
    name': String val,
    default: (String val | None) = None)
  =>
    name = name'
    datatype = DataTypeText
    if not (default is None) then
      mask = _Default()
      default_string_value = default
    end

  new medium_text(
    name': String val,
    default: (String val | None) = None)
  =>
    name = name'
    datatype = DataTypeMediumText
    if not (default is None) then
      mask = _Default()
      default_string_value = default
    end

  new long_text(
    name': String val,
    default: (String val | None) = None)
  =>
    name = name'
    datatype = DataTypeLongText
    if not (default is None) then
      mask = _Default()
      default_string_value = default
    end

  //////////
  // date //
  //////////
  new date(
    name': String val,
    default: Bool = false)
  =>
    name = name'
    datatype = DataTypeDate
    if default then
      mask = _Default()
    end

  new datetime(
    name': String val,
    default: Bool = false)
  =>
    name = name'
    datatype = DataTypeDateTime
    if default then
      mask = _Default()
    end

  new time(
    name': String val,
    default: Bool = false)
  =>
    name = name'
    datatype = DataTypeTime
    if default then
      mask = _Default()
    end

  new timestamp(
    name': String val,
    default: Bool = false)
  =>
    name = name'
    datatype = DataTypeTimestamp
    if default then
      mask = _Default()
    end

  new timestamps()
  =>
    name = ""
    datatype = DataTypeTimestamps

  new soft_delete()
  =>
    name = ""
    datatype = DataTypeSoftDelete

  ////////////
  // others //
  ////////////
  new binary(
    name': String val,
    default: (String val | None) = None)
  =>
    name = name'
    datatype = DataTypeBinary
    if not (default is None) then
      mask = _Default()
      default_string_value = default
    end

  new boolean(
    name': String val,
    default: (Bool | None) = None)
  =>
    name = name'
    datatype = DataTypeBoolean
    match default
    | let default': Bool =>
      mask = _Default()
      default_boolean_value = default'
    end

  new enum(
    name': String val,
    options: Set[String val] val,
    default: (String val | None) = None)
  =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    let array: Array[String val] iso = recover iso Array[String val](options.size()) end
    for opt in options.values() do
      array.push(opt)
    end
    meta'("options") = consume array
    meta = consume meta'
    name = name'
    datatype = DataTypeEnum
    if not (default is None) then
      mask = _Default()
      default_string_value = default
    end

  new json(
    name': String val,
    default: (JsonDoc val | None) = None)
  =>
    name = name'
    datatype = DataTypeJson
    if not (default is None) then
      mask = _Default()
      default_json_value = default
    end

  /////////////
  // foreign //
  /////////////
  new foreign(
    name': String val,
    default: (I64 | None) = None)
  =>
    name = name'
    datatype = DataTypeForeign
    match default
    | let default': I64 =>
      mask = _Index() or _Default()
      default_integer_value = default'
    else
      mask = _Index()
    end

  new string_foreign(
    name': String val,
    length: USize = 255,
    default: (String val | None))
  =>
    let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
    meta'("max-length") = length.i64()
    meta = consume meta'
    name = name'
    datatype = DataTypeStringForeign
    if default is None then
      mask = _Index()
    else
      mask = _Index() or _Default()
      default_string_value = default
    end

  fun ref reference(
    column: Column val)
  =>
    let newmeta: Map[String val, (I64 | String val | Array[String val] val)] trn =
      match meta
      | let meta': Map[String val, (I64 | String val | Array[String val] val)] val =>
        let meta'': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
        for (k, v) in meta'.pairs() do
          meta''(k) = v
        end
        meta''("column") = column.name
        consume meta''
      else
        let meta': Map[String val, (I64 | String val | Array[String val] val)] trn = recover trn Map[String val, (I64 | String val | Array[String val] val)] end
        meta'("column") = column.name
        consume meta'
      end
    meta = consume newmeta

  fun ref on(
    table: Table val)
  =>
    let newmeta: Map[String val, (I64 | String val | Array[String val] val)] trn =
      match meta
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
    meta = consume newmeta

  fun ref on_delete(
    delete: ForeignOnDelete)
  =>
    foreign_on_delete = delete
