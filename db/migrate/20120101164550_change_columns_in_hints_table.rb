class ChangeColumnsInHintsTable < ActiveRecord::Migration
  def self.up
  	remove_column :hints,	:direction_straigth_hint
    remove_column :hints,	:direction_fade_hint
    remove_column :hints,	:direction_drow_hint
    remove_column :hints,  :direction_slice_hint
    remove_column :hints,	:direction_hook_hint

    remove_column :hints,	:green_tilt_upward_hint
    remove_column :hints,	:green_tilt_downward_hint
    remove_column :hints,	:green_tilt_very_upward_hint
    remove_column :hints,	:green_tilt_very_downward_hint

	add_column :hints, :trajectory_fade_hint, :string
	add_column :hints, :trajectory_drow_hint, :string
	add_column :hints, :trajectory_slice_hint, :string
	add_column :hints, :trajectory_hook_hint, :string

	add_column :hints,	:green_direction_upward_hint, :string
    add_column :hints,	:green_direction_downward_hint, :string
    add_column :hints,	:green_direction_very_upward_hint, :string
    add_column :hints,	:green_direction_very_downward_hint, :string


  end

  def self.down
  	add_column :hints,	:direction_straigth_hint, :string
    add_column :hints,	:direction_fade_hint, :string
    add_column :hints,	:direction_drow_hint, :string
    add_column :hints,  :direction_slice_hint, :string
    add_column :hints,	:direction_hook_hint, :string


	add_column :hints,	:green_tilt_upward_hint, :string
    add_column :hints,	:green_tilt_downward_hint, :string
    add_column :hints,	:green_tilt_very_upward_hint, :string
    add_column :hints,	:green_tilt_very_downward_hint, :string

	remove_column :hints, :trajectory_fade_hint
	remove_column :hints, :trajectory_drow_hint
	remove_column :hints, :trajectory_slice_hint
	remove_column :hints, :trajectory_hook_hint

	remove_column :hints,	:green_direction_upward_hint
    remove_column :hints,	:green_direction_downward_hint
    remove_column :hints,	:green_direction_very_upward_hint
    remove_column :hints,	:green_direction_very_downward_hint
  end
end
