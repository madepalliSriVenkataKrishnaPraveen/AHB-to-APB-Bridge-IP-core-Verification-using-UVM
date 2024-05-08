class ahb_trans extends uvm_sequence_item;
	
	`uvm_object_utils(ahb_trans)
	
	rand bit [2:0]Hsize;
	rand bit Hwrite;
	rand bit [2:0]Hburst;
	rand bit [1:0]Htrans;
	rand bit [31:0]Haddr;
	rand bit [31:0]Hwdata;
	rand bit [7:0]length;

	bit [31:0]Hrdata;
	bit [1:0]Hresp;
	bit Hready;

	constraint HSIZE{Hsize inside {0,1,2};}

	constraint HADDR{Haddr inside {[32'h8000_0000:32'h8000_03ff],
					[32'h8400_0000:32'h8400_03ff],
					[32'h8800_0000:32'h8800_03ff],
					[32'h8c00_0000:32'h8c00_03ff]};}  // phepheral memory mapping
	constraint C1{Haddr%1024+length*(3'b1<<Hsize)<1024;}  // length of wrap or increment. And size 1kb boundary.
	constraint HADDR1{Hsize==1 -> Haddr%2==0;
			 Hsize==2 -> Haddr%4==0;}
			 
	function new(string name="ahb_trans");
		super.new(name);
	endfunction

	/*function void do_copy(uvm_object rhs);
		ahb_trans rhs_;
		if(!$cast(rhs_,rhs))
			`uvm_fatal(get_type_name(),"do_copy casting failed")
		super.do_copy(rhs);
		Hsize=rhs_.Hsize;
		Hwrite=rhs_.Hwrite;
		Hburst=rhs_.Hburst;
		Htrans=rhs_.Htrans;
		Haddr=rhs_.Haddr;
		Hwdata=rhs_.Hwdata;
		Hrdata=rhs_.Hrdata;
		Hresp=rhs_.Hresp;
		Hready=rhs_.Hready;
	endfunction*/

	function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("Hsize",this.Hsize,3,UVM_DEC);
		printer.print_field("Hwrite",this.Hwrite,1,UVM_BIN);
		printer.print_field("Hburst",this.Hburst,3,UVM_BIN);
		printer.print_field("Htrans",this.Htrans,2,UVM_BIN);
		printer.print_field("Haddr",this.Haddr,32,UVM_HEX);
		printer.print_field("Hwdata",this.Hwdata,32,UVM_HEX);
		printer.print_field("Hrdata",this.Hrdata,32,UVM_HEX);
		printer.print_field("Hresp",this.Hresp,2,UVM_BIN);
		printer.print_field("Hready",this.Hready,1,UVM_BIN);
	endfunction
	
endclass
