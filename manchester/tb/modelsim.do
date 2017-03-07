# Creo la libreria y lo mapeo
vlib work
vmap work work

# Compilo los archivos
vlog -reportprogress 300 -work work ../man_mod.v
vcom -reportprogress 300 -work work ../tb_man_mod.vhd

# Empiezo la simulacion
vsim work.tb_man_mod


# Agrego las signals para ver las ondas
add wave -position insertpoint  \
sim/:tb_man_mod:clk \
sim/:tb_man_mod:in_enable \
sim/:tb_man_mod:in_data \
sim/:tb_man_mod:out_data \
sim/:tb_man_mod:clk_period

run -all