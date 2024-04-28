meta:
  id: commonevent_dat
  endian: le
  title: WolfRPG CommonEvent.dat file
  application: WolfRPG
  file-extension: dat
  license: MIT
  imports:
  - common
  - event_command

enums:
  run_condition:
    0: 'call_only'
    1: 'auto_start'
    2: 'parallel_process'
    3: 'parallel_process_always'
  argument_special_specification_type:
    0: 'no_special_specification'
    1: 'database_reference'
    2: 'manual_options'
  color:
    0: 'black'
    1: 'red'
    2: 'blue'
    3: 'green'
    4: 'magenta'
    5: 'yellow'
    6: 'gray'

types:
  argument_special_specification:
    seq:
    - id: argument_special_specification
      type: u1
      enum: argument_special_specification_type
      valid: 
        any-of:
        - argument_special_specification_type::no_special_specification
        - argument_special_specification_type::database_reference
        - argument_special_specification_type::manual_options

  common_event:
    seq:
    - id: header
      type: u1
      valid: 0x8E
    - id: common_event_id
      type: u4
    - id: condition_operator
      type: b4
      enum: common::operator
    - id: run_condition
      type: b4
      enum: run_condition
    - id: condition_variable
      type: common::magic_number
    - id: condition_value
      type: u4
    - id: argument_number_count
      type: u1
    - id: argument_string_count
      type: u1
    - id: title
      type: common::t_str
    - id: lines_count
      type: u4
    - id: lines
      type: event_command
      repeat: expr
      repeat-expr: lines_count
    - id: unknown4
      contents: [1, 0, 0, 0, 0]
    - id: memo
      type: common::t_str
    - id: separator1
      contents: [0x8f]
    - id: argument_names
      type: common::t_str_array
    - id: argument_special_specification_mode_pagecount
      type: u4
    - id: argument_special_specification_mode
      type: argument_special_specification
      repeat: expr
      repeat-expr: argument_special_specification_mode_pagecount
    - id: argument_special_specification_manual_option_string_pagecount
      doc: |
        one string table per page.
        If mode == manual_option, here stores the display string of the options
        if mode == database_reference, string table length is always 3 and stores the '-1', '-2', '-3' options 
      type: u4
    - id: argument_special_specification_manual_option_string
      type: common::t_str_array
      repeat: expr
      repeat-expr: argument_special_specification_manual_option_string_pagecount
    - id: argument_special_specification_manual_option_value_pagecount
      doc: |
        one number table per page.
        If mode == manual_option, here stores the value of the options
        if mode == database_reference, number table length is always 3 and stores:
          1st number: database type: system_db=0, user_db=1, variable_db=2
          2nd number: database id
          3rd number: not=0 or add -1,-2,-3 options=1
      type: u4
    - id: argument_special_specification_manual_option_value
      type: common::t_u4_array
      repeat: expr
      repeat-expr: argument_special_specification_manual_option_value_pagecount
    - id: argument_number_default_value
      type: common::t_s4_array
    - id: separator2
      contents: [0x90]
    - id: color
      enum: color
      type: u4
    - id: cself_var_names
      type: common::t_str
      repeat: expr
      repeat-expr: 100
    - id: separator3
      contents: [0x91]
    - id: unknown5
      contents: [1, 0, 0, 0, 0]
    - id: separator4
      contents: [0x92]
    - id: return_name
      type: common::t_str
    - id: return_value_id
      type: u4
    - id: separator5
      contents: [0x92]
seq:
  - id: magic
    contents: [0, 'W', 0, 0, 'O', 'L']
  - id: version_header
    type: u1
    enum: common::version_header
  - id: magic2
    contents: ['F', 'C', 0]
  - id: version
    type: u1
  - id: count
    type: u4
  - id: common_event
    type: common_event
    repeat: expr
    repeat-expr: count
  - id: footer
    type: u1
    valid:
      any-of: [0x8f, 0x90, 0x91]
  