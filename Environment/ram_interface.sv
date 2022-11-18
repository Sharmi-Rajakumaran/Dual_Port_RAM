// Definition of an interface block ram_if with clock as an input

interface ram_if(input bit clock);
        // Declare the interface signals:               
                logic [63:0]data_in,data_out;

        // data_in, data_out(logic type , size 64)
                logic read, write;
        // read, write (logic type, size 1)
                logic [11:0] rd_address, wr_address;
        // rd_address, wr_address (logic type, size 12)

        // Add clocking block wr_drv_cb for write driver that is triggered at posedge of clock
                clocking wr_drv_cb@(posedge clock);
                // define the input skew as #1 & output skew as #1
                        default input #1 output #2;
                // Define the direction of the signals as:
                        output data_in;
                        output wr_address;
                        output write;
        // output: data_in, wr_address, write
                endclocking:wr_drv_cb
        // Add clocking block rd_drv_cb for read driver that is triggered at posedge of clock
                clocking rd_drv_cb @(posedge clock);
                // define the input skew as #1 & output skew as #1
                        default input #1 output #2;
                        output read, rd_address;
                // Define the direction of the signals as:
                endclocking: rd_drv_cb
        // output:  rd_address, read

        // Add monitor clocking block wr_mon_cb for write monitor that is triggered at the posedge of clock
                clocking wr_mon_cb@(posedge clock);
                // define the input skew as #1 & output skew as #1
                        default input #1 output #2;
                // Define the direction of the signals as:
                                input data_in, wr_address, write;
                // input: data_in, wr_address, write
                endclocking: wr_mon_cb
        // Add monitor clocking block rd_mon_cb for read monitor that is triggered at the posedge of clock
                clocking        rd_mon_cb@(posedge clock);
                // define the input skew as #1 & output skew as #1
                        default input #1 output #1;
                // Define the direction of the signals as:
                                input read, rd_address, data_out;
        // input: rd_address,read, data_out
                endclocking: rd_mon_cb
                                                                                                                                                                                          19,0-1        54

        // Add write driver modport WR_BFM with driver clocking block(wr_drv_cb) as the input argument
                modport WR_BFM(clocking wr_drv_cb);
        // Add read driver modport RD_BFM with driver clocking block(rd_drv_cb) as the input argument
                modport RD_BFM(clocking rd_drv_cb);
        // Add write monitor modport WR_MON with monitor clocking block (wr_mon_cb) as the input argument
                modport WR_MON(clocking wr_mon_cb);
        // Add read monitor modport RD_MON with monitor clocking block(rd_mon_cb) as the input argument
                modport RD_MON(clocking rd_mon_cb);
endinterface: ram_if
