# Creo la libreria y lo mapeo
vlib work
vmap work work

# Compilo los archivos
vlog -reportprogress 300 -work work ../miller_demod.v
vcom -reportprogress 300 -work work ../tb_miller_demod.vhd

# Empiezo la simulacion
vopt +acc=f work.tb_miller_demod -o tb_miller
vsim -coverage -fsmdebug tb_miller

# Agrego las signals para ver las ondas
add wave -position insertpoint  \
sim/:tb_miller_demod:clk \
sim/:tb_miller_demod:in_enable \
sim/:tb_miller_demod:in_data \
sim/:tb_miller_demod:out_data \
sim/:tb_miller_demod:clk_period

run -all