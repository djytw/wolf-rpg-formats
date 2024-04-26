meta:
  id: msp
  endian: le
  imports: 
  - common
  - route
  - event_command
enums:
  event_trigger_condition:
    0: 'confirm_key'
    1: 'autorun'
    2: 'parallel_process'
    3: 'player_touch'
    4: 'event_touch'
types:
  event_trigger_switch:
    seq:
    - id: operator
      type: b4
      enum: common::operator
    - id: enabled
      type: b4
      valid:
        any-of: [0, 1]
  mappixel:
    seq:
    - id: raw
      type: u4
    instances:
      autotile_id:
        value: 'raw / 100000'
      autotile_enabled:
        value: 'autotile_id > 0'
      autotile_mode_top_left:
        if: autotile_enabled
        value: 'raw % 10000 / 1000'
      autotile_mode_top_right:
        if: autotile_enabled
        value: 'raw % 1000 / 100'
      autotile_mode_bottom_left:
        if: autotile_enabled
        value: 'raw % 100 / 10'
      autotile_mode_bottom_right:
        if: autotile_enabled
        value: 'raw % 10'
      basetile:
        if: autotile_enabled == false
        value: raw
  page:
    seq:
    - id: header
      type: u1
      valid: 0x79
    - id: event_graphic_chipid
      type: u4
    - id: event_graphic_filename
      type: common::t_str
    - id: event_graphic_row_in_tileset
      type: u1
    - id: event_graphic_col_in_tileset
      type: u1
    - id: event_graphic_opacity
      type: u1
    - id: event_graphic_display_type
      type: u1
      enum: common::graphic_render_mode
    - id: event_trigger_condition
      type: u1
      enum: event_trigger_condition
    - id: event_trigger_switch
      type: event_trigger_switch
      repeat: expr
      repeat-expr: 4
    - id: event_trigger_variable
      type: common::magic_number
      repeat: expr
      repeat-expr: 4
    - id: event_trigger_value
      type: s4
      repeat: expr
      repeat-expr: 4
    - id: route_info
      type: route
    - id: event_command_count
      type: u4
    - id: event_commands
      type: event_command
      repeat: expr
      repeat-expr: event_command_count
    - id: unknown3
      type: u4
      valid: 3
    - id: shadow_graphic_id
      doc: "id refer to sysdb9"
      type: u1
    - id: range_extension_x
      type: u1
      doc: "max 250"
    - id: range_extension_y
      type: u1
      doc: "max 250"
    - id: footer
      type: u1
      valid: 0x7a

  event:
    seq:
    - id: header
      type: u1
      valid: 0x6f
    - id: header2
      type: u4
      valid: 0x3039
    - id: event_id
      type: u4
    - id: title
      type: common::t_str
    - id: map_x
      type: u4
    - id: map_y
      type: u4
    - id: page_count
      type: u4
    - id: separator
      type: u4
      valid: 0
    - id: pages
      type: page
      repeat: expr
      repeat-expr: page_count
    - id: footer
      type: u1
      valid: 0x70
  # workaround
  # map not exists if first byte of map is 0xffffffff
  mapdata_block:
    params:
    - id: width
      type: u4
    - id: height
      type: u4
    - id: pos
      type: u4
    seq:
    - id: first_pixel
      type: u4
    - id: skip
      size: width*height*12 - 4
      if: first_pixel != 0xffffffff
    instances:
      mapdata:
        pos: pos
        type: mappixel
        repeat: expr
        repeat-expr: width*height*3

seq:
  - id: magic
    contents: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'WOLFM', 0]
  - id: version_header
    type: u1
    enum: common::version_header
  - id: magic2
    contents: [0, 0, 0]
  - id: unknown1
    type: u4
    valid: 0x64
  - id: version
    type: u1
    valid:
      # v2, v3
      any-of: [0x65, 0x66]
  - id: title
    type: common::t_str
  - id: tileset
    type: u4
  - id: width
    type: u4
  - id: height
    type: u4
  - id: event_count
    type: u4
  - id: mapdata
    type: mapdata_block(width, height, _io.pos)
  - id: events
    type: event
    repeat: expr
    repeat-expr: event_count
  - id: footer
    type: u1
    valid: 0x66
