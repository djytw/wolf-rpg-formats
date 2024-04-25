meta:
  id: database_project_old
  endian: le
  imports: 
  - common

types:
  vtype_old:
    seq:
    - id: name
      type: common::t_str_sjis
    - id: property_count
      type: u4
    - id: properties
      type: common::t_str_sjis
      repeat: expr
      repeat-expr: property_count
    - id: data_count
      type: u4
    - id: data_title
      type: common::t_str_sjis
      repeat: expr
      repeat-expr: data_count
    - id: type_memo
      type: common::t_str_sjis

seq:
  - id: count
    type: u4
  - id: types
    type: vtype_old
    repeat: expr
    repeat-expr: count
