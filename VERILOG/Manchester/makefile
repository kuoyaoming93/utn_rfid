###############################################################################
# Comandos del MAKEFILE
#	"make compilar" - compila
#	"make simular" - compila el testbench y simula
#	"make mostrar" - compila, simula y muestra el resultado
###############################################################################
#Archivos

FUENTE = manch_mod.v
TESTBENCH = tb_manch_mod.v
SALIDA = manch_mod.out
###############################################################################
#Herramientas
COMPILADOR = iverilog
SIMULADOR = vvp
VISUALIZADOR = gtkwave
#TOOL OPTIONS
COMP_FLAGS = -o
COMP_OUT = compilador.out
SIM_OUT = man_mod_tb.vcd	#VER tb_manch_mod.v ---> linea 9 'module man_mod_tb;'
###############################################################################
#DIRECTIVAS

.PHONY: all

all:
	limpiar compilar simular mostrar

.PHONY: limpiar

limpiar: 
	-rm -f *.out *.vcd

compilar : $(TESTBENCH) $(FUENTE)
	$(COMPILADOR) $(TESTBENCH) $(FUENTE) $(COMP_FLAGS) $(SALIDA)

simular: $(SALIDA)
	$(SIMULADOR) $(SALIDA)

mostrar: $(SALIDA)
	$(VISUALIZADOR) $(SIM_OUT) & 

$(SALIDA): $(COMP_OUT)
	$(SIMULADOR) $(SALIDA) 
$(COMP_OUT): $(TESTBENCH) $(FUENTE)
	$(COMPILADOR) $(TESTBENCH) $(FUENTE) $(COMP_FLAGS) $(SALIDA) 
