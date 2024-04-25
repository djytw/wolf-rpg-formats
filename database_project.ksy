meta:
  id: database_project
  endian: le
  imports: 
  - common
types:
  vtype:
    seq:
      - id: name
        type: common::t_str
      - id: property_count
        type: u4
      - id: properties
        type: common::t_str
        repeat: expr
        repeat-expr: property_count
      - id: data_count
        type: u4
      - id: data_title
        type: common::t_str
        repeat: expr
        repeat-expr: data_count
      - id: type_memo
        type: common::t_str
      - id: special_function_types_length
        type: u4
        valid: 100
      - id: special_function_types
        type: u1
        enum: common::special_function_type
        repeat: expr
        repeat-expr: special_function_types_length
      - id: some_string_table
        type: common::t_str_array
      - id: special_function_strings_length
        type: u4
        valid: property_count
      - id: special_function_strings
        type: common::t_str_array
        repeat: expr
        repeat-expr: special_function_strings_length
      - id: special_function_values_length
        type: u4
        valid: property_count
      - id: special_function_values
        type: common::t_u4_array
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
