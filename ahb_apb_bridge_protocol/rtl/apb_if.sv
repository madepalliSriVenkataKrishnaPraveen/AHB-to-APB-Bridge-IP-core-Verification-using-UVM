interface apb_if(input bit Hclk);

	bit [31:0]Prdata;
	bit [3:0]Pselx;
	bit Pwrite;
	bit Penable;
	bit [31:0]Paddr;
	bit [31:0]Pwdata;
	
	clocking apb_drv_cb@(posedge Hclk);
		default  input #1 output #1;
		output Prdata;
		input Pselx;
		input Pwrite;
		input Penable;
		input Paddr;
		input Pwdata;
	endclocking

	clocking apb_mon_cb@(posedge Hclk);
		default input #1 output #1;
		input Prdata;
		input Pselx;
		input Pwrite;
		input Paddr;
		input Penable;
		input Pwdata;
	endclocking 

	modport APB_DRV_MP(clocking apb_drv_cb);
	modport APB_MON_MP(clocking apb_mon_cb);
	
endinterface
