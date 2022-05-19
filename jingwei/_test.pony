use "pony_test"

actor \nodoc\ Main is TestList
  new create(
    env: Env)
  =>
    PonyTest(env, this)

  fun tag tests(
    test: PonyTest)
  =>
    test(_TestColumn)
    test(_TestSqliteSchema)
    test(_TestSqliteQuery)
