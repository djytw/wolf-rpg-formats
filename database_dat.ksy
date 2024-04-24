meta:
  id: database_dat
  endian: le

enums:
  data_id_method:
    0: 'manual'
    1: 'same_as_first_string_data'
    2: 'same_as_preceding_type_data_id'
    10000: 'from_type_in_db'
  
types:
  vstr:
    seq:
      - id: len
        type: u4
      - id: str
        type: strz
        size: len
        encoding: 'UTF-8'
  vdata:
    params:
    - id: property_block1_count
      type: u4
    - id: property_block2_count
      type: u4
    seq:
    - id: number_block
      type: s4
      repeat: expr
      repeat-expr: property_block1_count
    - id: string_block
      type: vstr
      repeat: expr
      repeat-expr: property_block2_count
# used for pretty print the data, very laggy. 
# results will stored in _root.type_data[type_id].vdata[data_id].output[property_id]
# vvv comment out the following section for performance
    - id: output
      type: property_output(_index)
      repeat: expr
      repeat-expr: _parent.property_count
  property_output:
    params:
    - id: i
      type: u4
    instances:
      type:
        value: '_parent._parent.property_position[i].block == 1 ? "number" : "string"'
      value_number:
        value: 'type == "number" ? _parent.number_block[_parent._parent.property_position[i].pos] : 0'
      value_string:
        value: 'type == "string" ? _parent.string_block[_parent._parent.property_position[i].pos].str : ""'
# ^^^ comment out the section above for performance
  type_data:
    seq:
    - id: sub_header
      contents: [0xfe, 0xff, 0xff, 0xff]
    - id: data_id_method
      type: u4
      enum: data_id_method
    - id: property_count
      type: u4
    - id: property_position
      type: property_position(_index)
      repeat: expr
      repeat-expr: property_count
    - id: size2
      type: u4
    - id: vdata
      type: vdata(property_block1_count, property_block2_count)
      repeat: expr
      repeat-expr: size2
    instances:
      property_block1_count:
        value: 'property_count == 0 ? 0 : property_position[property_count -1].sum_block1'
      property_block2_count:
        value: 'property_count - property_block1_count'
  property_position:
    params:
    - id: i
      type: u4
    seq:
    - id: raw
      type: u4
    instances:
      block:
        value: raw / 1000
      pos:
        value: raw % 1000
      sum_block1:
        value: '(i == 0 ? (block == 1 ? 1 : 0) : (block == 1 ? _parent.property_position[i - 1].sum_block1 + 1 : _parent.property_position[i - 1].sum_block1)).as<u4>'
seq:
  - id: magic
    contents: [0, 'W', 0, 0, 'O', 'L', 'U', 'F', 'M', 0]
  - id: version
    type: u1
  - id: length
    type: u4
  - id: type_data
    type: type_data
    repeat: expr
    repeat-expr: length
  - id: footer
    type: u1
