--------------------------------- FILE HEADER -------------------------------{{{
--
-- File:			[:VIM_EVAL:]expand("%:t")[:END_EVAL:]
-- Last Modified:	26 Sep 2014  01:19PM
--
-- Module Description
--
--
-----------------------------------------------------------------------------}}}

----------------------------- LIBRARY DECLARATION ------------------------{{{{{{
library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--------------------------------------------------------------------------}}}}}}

------------------------------------ ENTITY ---------------------------------{{{
entity [:VIM_EVAL:]expand("%:t:r")[:END_EVAL:] is
--	generic (
--		width : integer := 2
--	);
	port (
		o_module_date		: out	std_logic_vector(31 downto 0) := x"0404_2014"	;
		o_module_time		: out	std_logic_vector(31 downto 0) := x"1451_5900"	;
		i_reset				: in	std_logic										;
		i_clk				: in	std_logic
	);
end entity [:VIM_EVAL:]expand("%:t:r")[:END_EVAL:];
-----------------------------------------------------------------------------}}}

architecture behavioral of [:VIM_EVAL:]expand("%:t:r")[:END_EVAL:] is
------------------------------ COMPONENT DECLARATION ------------------------{{{
-----------------------------------------------------------------------------}}}

------------------------------ SIGNAL DECLARATION ---------------------------{{{
--type state_type is (IDLE, RUN);
--signal NEXT_STATE		: state_type := IDLE;
--signal STATE			: state_type := IDLE;
-----------------------------------------------------------------------------}}}

begin



end architecture behavioral;
