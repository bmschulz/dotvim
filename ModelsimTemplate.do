# HOW TO USE =============================================================== {{{

# If you've just created run.do from the vim ModelsimScript command,
#  Add simulation models as required
#  Add and reorder simulation sources as required
#  Choose correct libraries
#  Set run duration

# To run this script,
#  type got to launch terminal at the current working directory
#  type vsim<CR> in the terminal to launch Modelsim
#  do run.do from the modelsim terminal

# }}}

# DELETE AND RECREATE WORK LIBRARY ========================================= {{{
vlib work
rmdir /q /s work
vlib work
# }}}

# LOG THE SIMULATION ======================================================= {{{
transcript file log.txt
echo "--- Simulation Starts ---"
# }}}

# SIMULATION MODELS ======================================================== {{{

# }}}

# SIMULATION SOURCE ======================================================== {{{

# }}}

# INITIATE SIMULATION ====================================================== {{{
#set IgnoreWarning 1
#vsim -L work -L altera -L altera_mf -L altera_ver -L altera_mf_ver -t ps work.
vsim -L work -L unisim -L unisim_ver -L xilinx_corelib -L xilinx_corelib_ver -t ps work.
#run 50 ps
#set IgnoreWarning 0
radix -hex
view wave
add wave -r /*
# }}}

# RUN SIMULATION =========================================================== {{{
#run -all
run 170 us
# }}}

# RELOAD PREVIOUSLY SAVED SIGNAL SET ======================================= {{{
delete wave *
do wave.do
# }}}

# TO RUN THIS FROM COMMAND LINE USE FOLLOWING: ============================= {{{
#when -label done_sim {done_sim=='1'} {echo "--- End of simulation reached. ---";quit -sim;}
# }}}
