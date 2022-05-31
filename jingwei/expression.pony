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
  let right: (Expression val | Select val | None)

  new val create(
    left': Expression val,
    right': (Expression val | Select val | None))
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

  new val create(
    name': String val,
    arguments': Array[Expression val] val)
  =>
    name = name'
    arguments = arguments'

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

class val CountCall
  let expr: (String val | Column val)
  let alias: (String val | None)

  new val create(
    expr': (String val | Column val),
    alias': (String val | None) = None)
  =>
    expr = expr'
    alias = alias'

class val MinCall
  let expr: (String val | Column val)
  let alias: (String val | None)

  new val create(
    expr': (String val | Column val),
    alias': (String val | None) = None)
  =>
    expr = expr'
    alias = alias'

class val MaxCall
  let expr: (String val | Column val)
  let alias: (String val | None)

  new val create(
    expr': (String val | Column val),
    alias': (String val | None) = None)
  =>
    expr = expr'
    alias = alias'

class val AvgCall
  let expr: (String val | Column val)
  let alias: (String val | None)

  new val create(
    expr': (String val | Column val),
    alias': (String val | None) = None)
  =>
    expr = expr'
    alias = alias'
