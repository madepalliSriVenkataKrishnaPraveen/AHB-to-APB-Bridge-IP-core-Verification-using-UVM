interface ahb_if(input bit Hclk);

	bit [2:0]Hsize;
	bit Hwrite;
	//bit [2:0]Hburst;
	bit [1:0]Htrans;
	bit [31:0]Haddr;
	bit [31:0]Hwdata;
	bit Hresetn;
	bit [31:0]Hrdata;
	bit [1:0]Hresp;
	bit Hreadyin;
	bit Hreadyout;

	clocking ahb_drv_cb@(posedge Hclk);
		default input #1 output #1;
		output Hresetn;
		output Htrans;
		output Hwrite;
		output Haddr;
		output Hwdata;
		output Hsize;
		output Hreadyin;
		input Hrdata;
		input Hresp;
		input Hreadyout;
	endclocking

	clocking ahb_mon_cb@(posedge Hclk);
		default input #1 output #1;
		input Htrans;
		input Hwrite;
		input Haddr;
		input Hwdata;
		input Hsize;
		input Hreadyin;
		input Hreadyout;
		input Hresp;
		input Hrdata;
	endclocking 

	modport AHB_DRV_MP(clocking ahb_drv_cb);
	modport AHB_MON_MP(clocking ahb_mon_cb);

endinterface


