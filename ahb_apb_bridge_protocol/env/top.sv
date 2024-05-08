module top;
	
	import uvm_pkg::*;
	import test_pkg::*;
	
	bit Hclk;

	always
		#10 Hclk=~Hclk;
	
	ahb_if ahb_inf(Hclk);	
	apb_if apb_inf(Hclk);

	rtl_top ahb_apb_top(.Hclk(Hclk),.Hresetn(ahb_inf.Hresetn),.Htrans(ahb_inf.Htrans),.Hsize(ahb_inf.Hsize),.Hreadyin(ahb_inf.Hreadyin),.Hwdata(ahb_inf.Hwdata),.Haddr(ahb_inf.Haddr),.Hwrite(ahb_inf.Hwrite),.Prdata(apb_inf.Prdata),.Hrdata(ahb_inf.Hrdata),.Hresp(ahb_inf.Hresp),.Hreadyout(ahb_inf.Hreadyout),.Pselx(apb_inf.Pselx),.Pwrite(apb_inf.Pwrite),.Penable(apb_inf.Penable),.Paddr(apb_inf.Paddr),.Pwdata(apb_inf.Pwdata));

	initial
	begin
		`ifdef VCS
			$fsdbDumpvars(0, top);
        	`endif
		
		uvm_config_db#(virtual ahb_if)::set(null,"*","ahb_if",ahb_inf);
		uvm_config_db#(virtual apb_if)::set(null,"*","apb_if",apb_inf);

		run_test();
	end

endmodule
