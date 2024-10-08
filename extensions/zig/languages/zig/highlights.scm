[
  (container_doc_comment)
  (doc_comment)

] @comment.doc

[
    (line_comment)
] @comment

[
  variable: (IDENTIFIER)
  variable_type_function: (IDENTIFIER)
] @variable

;; func parameter
parameter: (IDENTIFIER) @property

[
  field_member: (IDENTIFIER)
  field_access: (IDENTIFIER)
] @property

;; assume TitleCase is a type
(
  [
    variable_type_function: (IDENTIFIER)
    field_access: (IDENTIFIER)
    parameter: (IDENTIFIER)
  ] @type
  (#match? @type "^[A-Z]([a-z]+[A-Za-z0-9]*)+$")
)

;; assume camelCase is a function
(
  [
    variable_type_function: (IDENTIFIER)
    field_access: (IDENTIFIER)
    parameter: (IDENTIFIER)
  ] @function
  (#match? @function "^[a-z]+([A-Z][a-z0-9]*)+$")
)

;; assume all CAPS_1 is a constant
(
  [
    variable_type_function: (IDENTIFIER)
    field_access: (IDENTIFIER)
  ] @constant
  (#match? @constant "^[A-Z][A-Z_0-9]+$")
)

[
  function_call: (IDENTIFIER)
  function: (IDENTIFIER)
] @function

exception: "!" @keyword

(
  (IDENTIFIER) @variable.special
  (#eq? @variable.special "_")
)

(PtrTypeStart "c" @variable.special)

(
  (ContainerDeclType
    [
      (ErrorUnionExpr)
      "enum"
    ]
  )
  (ContainerField (IDENTIFIER) @constant)
)

field_constant: (IDENTIFIER) @constant

(BUILTINIDENTIFIER) @keyword

((BUILTINIDENTIFIER) @function
  (#any-of? @function "@import" "@cImport"))

(INTEGER) @number

(FLOAT) @number

[
  "true"
  "false"
] @boolean

[
  (LINESTRING)
  (STRINGLITERALSINGLE)
] @string

(CHAR_LITERAL) @string.special.symbol
(EscapeSequence) @string.escape
(FormatSequence) @string.special

(BreakLabel (IDENTIFIER) @tag)
(BlockLabel (IDENTIFIER) @tag)

[
  "fn"
  "asm"
  "defer"
  "errdefer"
  "test"
  "struct"
  "union"
  "enum"
  "opaque"
  "error"
  "try"
  "catch"
  "for"
  "while"
  "break"
  "continue"
  "const"
  "var"
  "volatile"
  "allowzero"
  "noalias"
  "addrspace"
  "align"
  "callconv"
  "linksection"
  "comptime"
  "export"
  "extern"
  "inline"
  "noinline"
  "packed"
  "pub"
  "threadlocal"
  "async"
  "await"
  "suspend"
  "nosuspend"
  "resume"
  "and"
  "or"
  "orelse"
  "return"
  "if"
  "else"
  "switch"
] @keyword

[
  "usingnamespace"
] @constant

[
  "anytype"
  "anyframe"
  (BuildinTypeExpr)
] @type

[
  "null"
  "unreachable"
  "undefined"
] @constant

[
  (CompareOp)
  (BitwiseOp)
  (BitShiftOp)
  (AdditionOp)
  (AssignOp)
  (MultiplyOp)
  (PrefixOp)
  "*"
  "**"
  "->"
  ".?"
  ".*"
  "?"
] @operator

[
  ";"
  "."
  ","
  ":"
] @punctuation.delimiter

[
  ".."
  "..."
] @punctuation.special

[
  "["
  "]"
  "("
  ")"
  "{"
  "}"
  (Payload "|")
  (PtrPayload "|")
  (PtrIndexPayload "|")
] @punctuation.bracket

; Error
(ERROR) @error
