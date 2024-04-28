meta:
  id: route
  title: WolfRPG route-related structures, not used for file parsing
  application: WolfRPG
  license: MIT
  endian: le
  imports: 
  - common
enums:
  move_route_mode:
    0: 'dont_move'
    1: 'custom'
    2: 'random'
    3: 'toward_hero'
  route_type:
    0x00: 'move_down'
    0x01: 'move_left'
    0x02: 'move_right'
    0x03: 'move_up'
    0x04: 'move_down_left'
    0x05: 'move_down_right'
    0x06: 'move_up_left'
    0x07: 'move_up_right'
    0x08: 'facing_down'
    0x09: 'facing_left'
    0x0a: 'facing_right'
    0x0b: 'facing_up'
    0x0c: 'facing_down_left'
    0x0d: 'facing_down_right'
    0x0e: 'facing_up_left'
    0x0f: 'facing_up_right'
    0x10: 'move_random'
    0x11: 'move_towards_hero'
    0x12: 'move_away_from_hero'
    0x13: 'move_step_forward'
    0x14: 'move_step_backward'
    0x15: 'jump'
    0x16: 'turn_right'
    0x17: 'turn_left'
    0x18: 'turn_right_left_random'
    0x19: 'facing_random'
    0x1a: 'facing_towards_hero'
    0x1b: 'facing_away_from_hero'
    0x1c: 'assign_to_variable'
    0x1d: 'set_move_speed'
    0x1e: 'set_move_frequency'
    0x1f: 'set_animation_frequency'
    0x20: 'idle_animation_on'
    0x21: 'idle_animation_off'
    0x22: 'move_animation_on'
    0x23: 'move_animation_off'
    0x24: 'fixed_direction_on'
    0x25: 'fixed_direction_off'
    0x26: 'slip_through_on'
    0x27: 'slip_through_off'
    0x28: 'always_on_top_on'
    0x29: 'always_on_top_off'
    0x2c: 'set_graphic'
    0x2d: 'set_opacity'
    0x2e: 'set_sound'
    0x2f: 'wait_x_frames'
    0x30: 'half_tile_movement'
    0x31: 'full_tile_movement'
    0x32: 'pattern_1'
    0x33: 'pattern_2'
    0x34: 'pattern_3'
    0x35: 'move_approach_event'
    0x36: 'move_approach_position'
    0x37: 'add_to_variable'
    0x38: 'pattern_4'
    0x39: 'pattern_5'
    0x3a: 'set_height'
types:
  behavior_options:
    seq:
    - id: half_step_left
      type: b1
    - id: half_step_up
      type: b1
    - id: square_hitbox
      type: b1
    - id: above_hero
      type: b1
    - id: slip_through
      type: b1
    - id: fixed_direction
      type: b1
    - id: move_animation
      type: b1
    - id: idle_animation
      type: b1
  route_options:
    seq:
    - id: na
      type: b5
      valid: 0b00000
    - id: wait_until_done
      type: b1
    - id: skip_impossible_moves
      type: b1
    - id: repeat_actions
      type: b1
  route_data:
    seq:
    - id: type
      type: u1
      enum: route_type
    - id: data
      type:
        switch-on: type
        cases:
          route_type::move_down: general_no_param
          route_type::move_left: general_no_param
          route_type::move_right: general_no_param
          route_type::move_up: general_no_param
          route_type::move_down_left: general_no_param
          route_type::move_down_right: general_no_param
          route_type::move_up_left: general_no_param
          route_type::move_up_right: general_no_param
          route_type::facing_down: general_no_param
          route_type::facing_left: general_no_param
          route_type::facing_right: general_no_param
          route_type::facing_up: general_no_param
          route_type::facing_down_left: general_no_param
          route_type::facing_down_right: general_no_param
          route_type::facing_up_left: general_no_param
          route_type::facing_up_right: general_no_param
          route_type::move_random: general_no_param
          route_type::move_towards_hero: general_no_param
          route_type::move_away_from_hero: general_no_param
          route_type::move_step_forward: general_no_param
          route_type::move_step_backward: general_no_param
          route_type::jump: jump
          route_type::turn_right: general_no_param
          route_type::turn_left: general_no_param
          route_type::turn_right_left_random: general_no_param
          route_type::facing_random: general_no_param
          route_type::facing_towards_hero: general_no_param
          route_type::facing_away_from_hero: general_no_param
          route_type::assign_to_variable: assign_to_variable
          route_type::set_move_speed: set_move_speed
          route_type::set_move_frequency: set_move_frequency
          route_type::set_animation_frequency: set_animation_frequency
          route_type::idle_animation_on: general_no_param
          route_type::idle_animation_off: general_no_param
          route_type::move_animation_on: general_no_param
          route_type::move_animation_off: general_no_param
          route_type::fixed_direction_on: general_no_param
          route_type::fixed_direction_off: general_no_param
          route_type::slip_through_on: general_no_param
          route_type::slip_through_off: general_no_param
          route_type::always_on_top_on: general_no_param
          route_type::always_on_top_off: general_no_param
          route_type::set_graphic: set_graphic
          route_type::set_opacity: set_opacity
          route_type::set_sound: set_sound
          route_type::wait_x_frames: wait_x_frames
          route_type::half_tile_movement: general_no_param
          route_type::full_tile_movement: general_no_param
          route_type::pattern_1: general_no_param
          route_type::pattern_2: general_no_param
          route_type::pattern_3: general_no_param
          route_type::move_approach_event: move_approach_event
          route_type::move_approach_position: move_approach_position
          route_type::add_to_variable: add_to_variable
          route_type::pattern_4: general_no_param
          route_type::pattern_5: general_no_param
          route_type::set_height: set_height
          _: general
  general:
    seq:
    - id: u4_arg_len
      type: u1
    - id: u4_arg
      type: u4
      repeat: expr
      repeat-expr: u4_arg_len
    - id: u1_arg_len
      type: u1
    - id: u1_arg
      type: u1
      repeat: expr
      repeat-expr: u1_arg_len
  jump:
    seq:
    - id: u4_arg_len
      type: u1
      valid: 2
    - id: right
      type: s4
    - id: down
      type: s4
    - id: u1_arg_len
      type: u1
      valid: 1
    - id: u1_arg
      type: u1
      valid: 0
  assign_to_variable:
    seq:
    - id: u4_arg_len
      type: u1
      valid: 2
    - id: variable
      type: common::magic_number
    - id: value
      type: s4
    - id: u1_arg_len
      type: u1
      valid: 1
    - id: u1_arg
      type: u1
      valid: 0
  add_to_variable:
    seq:
    - id: u4_arg_len
      type: u1
      valid: 2
    - id: variable
      type: common::magic_number
    - id: value
      type: s4
    - id: u1_arg_len
      type: u1
      valid: 1
    - id: u1_arg
      type: u1
      valid: 0
  set_move_speed:
    seq:
    - id: u4_arg_len
      type: u1
      valid: 1
    - id: frames
      type: u4
      enum: common::move_speed
    - id: u1_arg_len
      type: u1
      valid: 1
    - id: u1_arg
      type: u1
      valid: 0
  set_move_frequency:
    seq:
    - id: u4_arg_len
      type: u1
      valid: 1
    - id: frames
      type: u4
      enum: common::frequency
    - id: u1_arg_len
      type: u1
      valid: 1
    - id: u1_arg
      type: u1
      valid: 0
  set_animation_frequency:
    seq:
    - id: u4_arg_len
      type: u1
      valid: 1
    - id: frames
      type: u4
      enum: common::frequency
    - id: u1_arg_len
      type: u1
      valid: 1
    - id: u1_arg
      type: u1
      valid: 0
  wait_x_frames:
    seq:
    - id: u4_arg_len
      type: u1
      valid: 1
    - id: frames
      type: u4
    - id: u1_arg_len
      type: u1
      valid: 1
    - id: u1_arg
      type: u1
      valid: 0
  move_approach_event:
    seq:
    - id: u4_arg_len
      type: u1
      valid: 1
    - id: event_id
      type: u4
    - id: u1_arg_len
      type: u1
      valid: 1
    - id: u1_arg
      type: u1
      valid: 0
  move_approach_position:
    seq:
    - id: u4_arg_len
      type: u1
      valid: 2
    - id: position_x
      type: s4
    - id: position_y
      type: s4
    - id: u1_arg_len
      type: u1
      valid: 1
    - id: u1_arg
      type: u1
      valid: 0
  set_graphic:
    seq:
    - id: u4_arg_len
      type: u1
      valid: 1
    - id: chip_id
      type: u4
    - id: u1_arg_len
      type: u1
      valid: 1
    - id: u1_arg
      type: u1
      valid: 0
  set_opacity:
    seq:
    - id: u4_arg_len
      type: u1
      valid: 1
    - id: opacity
      type: u4
    - id: u1_arg_len
      type: u1
      valid: 1
    - id: u1_arg
      type: u1
      valid: 0
  set_sound:
    seq:
    - id: u4_arg_len
      type: u1
      valid: 1
    - id: sound_id
      type: u4
    - id: u1_arg_len
      type: u1
      valid: 1
    - id: u1_arg
      type: u1
      valid: 0
  set_height:
    seq:
    - id: u4_arg_len
      type: u1
      valid: 1
    - id: height_px
      type: u4
    - id: u1_arg_len
      type: u1
      valid: 1
    - id: u1_arg
      type: u1
      valid: 0
  general_no_param:
    seq:
    - id: raw
      contents: [0, 1, 0]

seq:
  - id: animation_frequency
    type: u1
    enum: common::frequency
  - id: move_speed
    type: u1
    enum: common::move_speed
  - id: move_frequency
    type: u1
    enum: common::frequency
  - id: move_route_mode
    type: u1
    enum: move_route_mode
  - id: behavior_options
    type: behavior_options
  - id: character_move_route_options
    type: route_options
  - id: route_length
    type: u4
  - id: routes
    type: route_data
    repeat: expr
    repeat-expr: route_length
