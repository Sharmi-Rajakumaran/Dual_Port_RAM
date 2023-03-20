
[1] Do not carry any storage devices like Memory stick, CD, Floppy etc.

[2] Do not touch the LCD screen/Monitor - Handle the laptops/desktops carefully

[3] Do not upload/download anything onto/from website

[4] Do not copy anything from the laptops/desktops using your storage devices

[5] Do not change the OS/Software settings and install any new software 

-----------------------------------------------------------------------------
 MAVEN SILICON CONFIDENTIAL: All the presentations, books, 
documents [hard copies and softcopies] and projects that 
you are using and developing as part of this training course are 
the proprietary work of Maven Silicon Softech Pvt Ltd, Bangalore,
and are fully protected under the copyright and trade secret laws. 
You may not view, use, disclose, copy, or distribute the materials 
or any information except pursuant to a valid written license 
from Maven Silicon, Bangalore
-----------------------------------------------------------------------------

[SharmiR@mavenserver-RH2 ~]$ clear

[SharmiR@mavenserver-RH2 ~]$ ls
Bridge_rtl  Router_top.cr.mti  Tessent_labs_elective  lincomm       transcript
Linux_labs  Router_top.mpf     VLSI_RN                modelsim.ini  work
Router1x3   Tesse              assignment1_1.sv       mux4
[SharmiR@mavenserver-RH2 ~]$ cd VLSI_RN
[SharmiR@mavenserver-RH2 VLSI_RN]$ cd SV_LABS
[SharmiR@mavenserver-RH2 SV_LABS]$ ls
Assignment  Lab02  Lab04  Lab06  Lab08  Lab10            Practice
Lab01       Lab03  Lab05  Lab07  Lab09  Lodable_Counter
[SharmiR@mavenserver-RH2 SV_LABS]$ cd Lab10
[SharmiR@mavenserver-RH2 Lab10]$ ls
env  env_lib  rtl  sim  solution  test
[SharmiR@mavenserver-RH2 Lab10]$ cd env_lib/
[SharmiR@mavenserver-RH2 env_lib]$ ls
ram_gen.sv    ram_read_bfm.sv  ram_trans.sv
ram_if.sv     ram_read_mon.sv  ram_write_bfm.sv
ram_model.sv  ram_sb.sv        ram_write_mon.sv
[SharmiR@mavenserver-RH2 env_lib]$ vi ram_write_mon.sv 






        //Instantiate virtual interface instance wrmon_if of type ram_if with WR_MON modport
        virtual ram_if.WR_MON wrmon_if;

        //Declare a handle 'data2rm' of class type ram_trans
        ram_trans data2rm;

        //Declare a mailbox 'mon2rm' parameterized by type ram_trans
        mailbox #(ram_trans) mon2rm;

        //In constructor
        //Pass the following properties as the input arguments 

        //pass the virtual interface and the mailbox as arguments

        //make the connections and allocate memory for 'data2rm' 

        function new(virtual ram_if.WR_MON wrmon_if,
                                mailbox #(ram_trans) mon2rm);
                this.wrmon_if=wrmon_if;
                this.mon2rm=mon2rm;
                this.data2rm=new;
        endfunction: new


        task monitor();
                @(wrmon_if.wr_mon_cb)
                wait(wrmon_if.wr_mon_cb.write==1)
        @(wrmon_if.wr_mon_cb);
                begin
                        data2rm.write= wrmon_if.wr_mon_cb.write;
                        data2rm.wr_address =  wrmon_if.wr_mon_cb.wr_address;
                        data2rm.data= wrmon_if.wr_mon_cb.data_in;
                        //call the display of the ram_trans to display the monitor data
                        data2rm.display("DATA FROM WRITE MONITOR");

                end
        endtask


        //In start task

        task start();
        //within fork-join_none

        //In forever loop
                fork
                        forever
                                begin
        //Call the monitor task
        //Understand the provided monitor task
        //Monitor task samples the interface signals 
        //according to the protocol and convert to transaction items 
                                        monitor();
        //Put the transaction item into the mailbox mon2rm
                                        mon2rm.put(data2rm);
                                end
                join_none
        endtask: start

endclass:ram_write_mon
