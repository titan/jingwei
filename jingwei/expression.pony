class val AddExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val SubExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val MulExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val DivExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val RemExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val AndExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val OrExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val NotExpression
  let expr: Expression val

  new val create(
    expr': Expression val)
  =>
    expr = expr'

class val NotEqualsToExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val EqualsToExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val LessThanExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val LessThanOrEqualsToExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val GreaterThanExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val GreaterThanOrEqualsToExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val IsExpression
  let left: Expression val
  let right: Expression val

  new val create(
    left': Expression val,
    right': Expression val)
  =>
    left = left'
    right = right'

class val IsNullExpression
  let expr: Expression val

  new val create(
    expr': Expression val)
  =>
    expr = expr'

class val NotNullExpression
  let expr: Expression val

  new val create(
    expr': Expression val)
  =>
    expr = expr'

class val InExpression
  let left: Expression val
  let right: (Array[Expression val] val | Select val | None)

  new val create(
    left': Expression val,
    right': (Array[Expression val] val | Select val | None))
  =>
    left = left'
    right = right'

class val BetweenExpression
  let expr: Expression val
  let infimum: Expression val
  let supremum: Expression val

  new val create(
    expr': Expression val,
    infimum': Expression val,
    supremum': Expression val)
  =>
    expr = expr'
    infimum = infimum'
    supremum = supremum'

class val NotBetweenExpression
  let expr: Expression val
  let infimum: Expression val
  let supremum: Expression val

  new val create(
    expr': Expression val,
    infimum': Expression val,
    supremum': Expression val)
  =>
    expr = expr'
    infimum = infimum'
    supremum = supremum'

class val ExistsExpression
  let subquery: Select val

  new val create(
    subquery': Select val)
  =>
    subquery = subquery'

type BoolExpression is
  ( AndExpression val
  | OrExpression val
  | NotExpression val
  | NotEqualsToExpression val
  | EqualsToExpression val
  | LessThanExpression val
  | LessThanOrEqualsToExpression val
  | GreaterThanExpression val
  | GreaterThanOrEqualsToExpression val
  | IsExpression val
  | IsNullExpression val
  | NotNullExpression val
  | InExpression val
  | BetweenExpression val
  | NotBetweenExpression val
  | ExistsExpression val
  )

primitive Placeholder

class val ApplyExpression
  let name: String val
  let arguments: Array[Expression val] val
  let return_type: DataType

  new val create(
    name': String val,
    arguments': Array[Expression val] val,
    return_type': DataType)
  =>
    name = name'
    arguments = arguments'
    return_type = return_type'

type Expression is
  ( I64
  | F64
  | String val
  | Placeholder
  | Column val
  | Table val
  | (Table val, Column val)
  | BoolExpression
  | AddExpression val
  | SubExpression val
  | MulExpression val
  | DivExpression val
  | RemExpression val
  | ApplyExpression val
  )

type Assignment is
  ( Column val
  , Expression
  )

primitive AssignmentBuilder
  fun val apply(
    column: Column val,
    expression: Expression)
  : Assignment =>
    (column, expression)

primitive ExpressionDataTypeEvaluator
  fun val apply(
    expr: Expression)
  : (DataType | None) =>
    match expr
    | let _: I64 =>
      DataTypeInteger
    | let _: F64 =>
      DataTypeFloat
    | let _: String val =>
      DataTypeString
    | let x: Column val =>
      x.datatype
    | let _: BoolExpression =>
      DataTypeBoolean
    | let expr': AddExpression val =>
      match ExpressionDataTypeEvaluator(expr'.left)
      | let dt: DataType =>
        dt
      else
        ExpressionDataTypeEvaluator(expr'.right)
      end
    | let expr': SubExpression val =>
      match ExpressionDataTypeEvaluator(expr'.left)
      | let dt: DataType =>
        dt
      else
        ExpressionDataTypeEvaluator(expr'.right)
      end
    | let expr': MulExpression val =>
      match ExpressionDataTypeEvaluator(expr'.left)
      | let dt: DataType =>
        dt
      else
        ExpressionDataTypeEvaluator(expr'.right)
      end
    | let expr': DivExpression val =>
      match ExpressionDataTypeEvaluator(expr'.left)
      | let dt: DataType =>
        dt
      else
        ExpressionDataTypeEvaluator(expr'.right)
      end
    | let expr': RemExpression val =>
      match ExpressionDataTypeEvaluator(expr'.left)
      | let dt: DataType =>
        dt
      else
        ExpressionDataTypeEvaluator(expr'.right)
      end
    | let expr': ApplyExpression val =>
      expr'.return_type
    else
      None
    end
