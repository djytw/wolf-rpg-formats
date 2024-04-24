meta:
  id: database_project
  endian: le
enums:
  special_function_type:
    0: 'disabled'
    1: 'load_from_file'
    2: 'load_from_database'
    3: 'manual'
types:
  vstr:
    seq:
      - id: len
        type: u4
      - id: str
        type: strz
        size: len
        encoding: 'UTF-8'
  vstr_array:
    seq:
      - id: len
        type: u4
      - id: str
        type: vstr
        repeat: expr
        repeat-expr: len
  vu4array:
    seq:
      - id: len
        type: u4
      - id: data
        type: u4
        repeat: expr
        repeat-expr: len
  vtype:
    seq:
      - id: name
        type: vstr
      - id: property_count
        type: u4
      - id: properties
        type: vstr
        repeat: expr
        repeat-expr: property_count
      - id: data_count
        type: u4
      - id: data_title
        type: vstr
        repeat: expr
        repeat-expr: data_count
      - id: type_memo
        type: vstr
      - id: special_function_types_length
        type: u4
        valid: 100
      - id: special_function_types
        type: u1
        enum: special_function_type
        repeat: expr
        repeat-expr: special_function_types_length
      - id: some_string_table
        type: vstr_array
      - id: special_function_strings_length
        type: u4
        valid: property_count
      - id: special_function_strings
        type: vstr_array
        repeat: expr
        repeat-expr: special_function_strings_length
      - id: special_function_values_length
        type: u4
        valid: property_count
      - id: special_function_values
        type: vu4array
        repeat: expr
        repeat-expr: special_function_values_length
      - id: default_value_length
        type: u4
        valid: property_count
      - id: default_value
        type: s4
        repeat: expr
        repeat-expr: default_value_length
seq:
  - id: type_count
    type: u4
  - id: types
    type: vtype
    repeat: expr
    repeat-expr: type_count
