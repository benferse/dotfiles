[
  (list)
  (tuple)
  (dictionary)
  (set)

  (if_statement)
  (for_statement)
  (while_statement)
  (with_statement)
  (try_statement)
  (import_from_statement)

  (parenthesized_expression)
  (generator_expression)
  (list_comprehension)
  (set_comprehension)
  (dictionary_comprehension)

  (tuple_pattern)
  (list_pattern)
  (argument_list)
  (parameters)
  (binary_operator)

  (function_definition)
  (class_definition)
] @indent

[
  ")"
  "]"
  "}"
  (elif_clause)
  (else_clause)
  (except_clause)
  (finally_clause)
] @branch

[
  (return_statement)
  (pass_statement)
  (raise_statement)
] @return

[
  (string)
] @ignore
