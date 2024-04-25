meta:
  id: tilesetdata_dat
  endian: le
  imports:
  - common
types:
  tile_passable:
    seq:
    - id: counter_enabled
      type: b1
    - id: square
      type: b1
    - id: quarter_tile
      type: b1
    - id: star
      type: b1
    - id: top_left_passable
      type: b1
      if: quarter_tile
    - id: upwards_not_passable
      type: b1
      if: quarter_tile == false
    - id: top_right_passable
      type: b1
      if: quarter_tile
    - id: rightwards_not_passable
      type: b1
      if: quarter_tile == false
    - id: bottom_left_passable
      type: b1
      if: quarter_tile
    - id: leftwards_not_passable
      type: b1
      if: quarter_tile == false
    - id: bottom_right_passable
      type: b1
      if: quarter_tile
    - id: downwards_not_passable
      type: b1
      if: quarter_tile == false
    - id: na2
      type: b6
      valid: 0
    - id: downarrow
      type: b1
    - id: triangle
      type: b1
    - id: na3
      type: u2
      valid: 0
  tileset_210:
    seq:
    - id: title
      type: common::t_str
    - id: base_tileset_file
      type: common::t_str
    - id: auto_tile_files
      type: common::t_str
      repeat: expr
      repeat-expr: 31
    - id: separator1
      type: u1
      valid: 0xff
    - id: tag_number_count
      type: u4
    - id: tag_numbers
      type: u1
      repeat: expr
      repeat-expr: tag_number_count
    - id: separator2
      type: u1
      valid: 0xff
    - id: tile_passable_count
      type: u4
    - id: tile_passable
      type: tile_passable
      repeat: expr
      repeat-expr: tile_passable_count
  tileset_209:
    seq:
    - id: title
      type: common::t_str_sjis
    - id: base_tileset_file
      type: common::t_str_sjis
    - id: auto_tile_files
      type: common::t_str_sjis
      repeat: expr
      repeat-expr: 15
    - id: separator1
      type: u1
      valid: 0xff
    - id: tag_number_count
      type: u4
    - id: tag_numbers
      type: u1
      repeat: expr
      repeat-expr: tag_number_count
    - id: separator2
      type: u1
      valid: 0xff
    - id: tile_passable_count
      type: u4
    - id: tile_passable
      type: tile_passable
      repeat: expr
      repeat-expr: tile_passable_count
seq:
  - id: magic
    contents: [0, 'W', 0, 0, 'O', 'L']
  - id: version_header
    type: u1
    enum: common::version_header
  - id: magic2
    contents: ['F', 'M', 0]
  - id: version
    type: u1
  - id: length
    type: u4
  - id: tileset
    type:
      switch-on: version
      cases:
        210: tileset_210
        209: tileset_209
    repeat: expr
    repeat-expr: length
  - id: footer
    type: u1
    valid: 0xcf
