quit -sim

vlib work
vmap work work

vcom state_basic.vhd
vcom tb_state_basic.vhd


vsim tb_state_basic

view wave

add wave -noupdate -divider testbench
add wave tb_state_basic/clk_ena
add wave tb_state_basic/clk


add wave -noupdate -divider MOORE
add wave tb_state_basic/DUT_MOORE/state_moore
add wave tb_state_basic/output_moore

add wave -noupdate -divider MEALY
add wave tb_state_basic/DUT_MEALY/state_mealy
add wave tb_state_basic/output_mealy

configure wave -namecolwidth 300
configure wave -valuecolwidth 100
configure wave -timelineunits ns
update

run -all

wave zoom full
