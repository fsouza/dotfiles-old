(function_declaration
  body: (block) @function.inner) @function.outer

(for_statement
  body: (block) @loop.inner) @loop.outer
