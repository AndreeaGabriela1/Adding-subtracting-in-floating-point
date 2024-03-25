@echo off
set xv_path=D:\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto d10b2d1d2bba42f79490e791db695d5d -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot AS_NumereVM_tb_behav xil_defaultlib.AS_NumereVM_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
