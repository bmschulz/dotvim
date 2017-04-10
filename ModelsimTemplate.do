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

quit -sim
quietly set recompile_source 1

# DELETE AND RECREATE WORK LIBRARY ========================================= {{{
if {$recompile_source} {
    vlib work
    rmdir /q /s work
    vlib work
}
# }}}

# LOG THE SIMULATION ======================================================= {{{
transcript file log.txt
echo "--- Simulation Starts ---"
# }}}

# SIMULATION MODELS ======================================================== {{{

# }}}

# SIMULATION SOURCE ======================================================== {{{

# }}}

# CHOOSE TESTCASE ========================================================== {{{
echo "Choose testcase to run \n" \
		"1: case 1 \n" \
		"2: case 2 \n" \

quietly set choice_invalid 1

while {$choice_invalid == 1} {
	set testcase [read stdin 1]
	switch $testcase {
		1 {
			set stimulus_file "case1.txt"
			set choice_invalid 0
		}
		2 {
			set stimulus_file "case2.txt"
			set choice_invalid 0
		}
		default {
			echo "Make a valid selection 1-2 and press <enter>"
		}
	}
}
# }}}
#
# INITIATE SIMULATION ====================================================== {{{
#set IgnoreWarning 1
#vsim -L work -L altera -L altera_mf -L altera_ver -L altera_mf_ver -t ps work.
vsim -novopt -L work -L unisim -L unisim_ver -L xilinx_corelib -L xilinx_corelib_ver -msgmode both -gSTIMULUS_FILE=$stimulus_file -t ps work.
radix -hex
view wave
add wave -noupdate -r /*
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
