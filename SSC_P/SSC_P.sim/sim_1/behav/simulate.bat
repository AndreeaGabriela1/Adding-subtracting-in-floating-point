@echo off
set xv_path=D:\\Vivado\\2016.4\\bin
call %xv_path%/xsim AS_NumereVM_tb_behav -key {Behavioral:sim_1:Functional:AS_NumereVM_tb} -tclbatch AS_NumereVM_tb.tcl -view D:/Adunarea-si-scaderea-numerelor-in-virgula-mobila-main/SSC_P/SSC_P/AS_NumereVM_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
