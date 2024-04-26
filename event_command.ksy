meta:
  id: event_command
  endian: le
  imports: 
  - common
  - route

enums:
  # TODO: finish this
  command_type:
    101: show_message_show_text
    103: show_message_comment
    106: show_message_debug
    111: condition_number
    210: call_event
    211: call_event_reserve
    240: chip_management_change_map_chip_settings
    241: chip_management_switch_chipset
    242: chip_management_overwrite_map_chips
    300: call_common_by_name
    401: branch
    499: branch_end

types:
  param_status:
    seq:
    - id: raw
      type: u4
    instances:
      string_1_enabled:
        value: (raw >> 12) & 1
      string_2_enabled:
        value: (raw >> 13) & 1
      string_3_enabled:
        value: (raw >> 14) & 1
      string_4_enabled:
        value: (raw >> 15) & 1
      string_5_enabled:
        value: (raw >> 16) & 1
      string_count:
        value: (raw >> 4) & 0xf
      number_count:
        value: (raw >> 0) & 0xf
      count:
        value: (string_count + number_count)
  call_common_by_name:
    seq: 
    - id: na
      type: u4
      valid: 0
    - id: param_status
      type: param_status 
    - id: param_numbers
      type: s4
      repeat: expr
      repeat-expr: param_status.count
  call_event:
    seq: 
    - id: event_id
      type: u4
    # if it's common event
    - id: param_status
      type: param_status
      if: event_id >= 500000 and event_id <= 599999
    - id: param_numbers
      type: s4
      repeat: expr
      repeat-expr: param_status.count
      if: event_id >= 500000 and event_id <= 599999
    # or other event, here is page-1
    - id: page
      type: u4
      if: event_id < 500000 or event_id > 599999
  condition_number__condition:
    seq:
    - id: variable
      type: common::magic_number
    - id: value
      type: s4
    - id: operator
      type: u4
      enum: common::operator
  condition_number:
    seq:
    - id: use_else_branch
      type: b4
      valid:
        any-of: [0,1]
    - id: condition_count
      type: b4
    - id: conditions
      type: condition_number__condition
      repeat: expr
      repeat-expr: condition_count
  branch:
    seq:
    - id: condition_id
      type: u4
  branch_end:
    seq: []
  show_message:
    seq: []
  chip_management_change_map_chip_settings:
    seq:
      - id: chipset_id
        type: s4
      - id: counter
        type: b1
      - id: square
        type: b1
      - id: na
        type: b1
        valid: false
      - id: star
        type: b1
      - id: not_up
        type: b1
      - id: not_right
        type: b1
      - id: not_left
        type: b1
      - id: not_down
        type: b1
      - id: x
        type: b6
      - id: downarrow
        type: b1
      - id: triangle
        type: b1
      - id: na2
        type: u2
    instances:
      is_reset:
        value: chipset_id == -1000000
  chip_management_switch_chipset:
    seq:
      - id: chipset_id
        type: u4
  chip_management_overwrite_map_chips:
    seq:
      - id: map_layer
        type: u4
      - id: map_x
        type: u4
      - id: map_y
        type: u4
      - id: width
        type: u4
      - id: height
        type: u4
      - id: chip_id
        type: u4

seq:
  - id: param_count
    type: u1
  - id: command_type
    type: u4
    enum: command_type
    if: param_count > 0
  - id: param
    if: param_count > 0
    size: param_count * 4 - 4
    type:
      switch-on: command_type
      cases:
        command_type::show_message_show_text: show_message
        command_type::show_message_comment: show_message
        command_type::show_message_debug: show_message
        command_type::condition_number: condition_number
        command_type::call_event: call_event
        command_type::call_event_reserve: call_event
        command_type::chip_management_change_map_chip_settings: chip_management_change_map_chip_settings
        command_type::chip_management_switch_chipset: chip_management_switch_chipset
        command_type::chip_management_overwrite_map_chips: chip_management_overwrite_map_chips
        command_type::call_common_by_name: call_common_by_name
        command_type::branch: branch
        command_type::branch_end: branch_end
  - id: branch_depth
    if: param_count > 0
    type: u1
  - id: string_count
    if: param_count > 0
    type: u1
  - id: strings
    if: param_count > 0
    type: common::t_str
    repeat: expr
    repeat-expr: string_count
  - id: have_route
    if: param_count > 0
    type: u1
  - id: route_info
    type: route
    if: have_route != 0
