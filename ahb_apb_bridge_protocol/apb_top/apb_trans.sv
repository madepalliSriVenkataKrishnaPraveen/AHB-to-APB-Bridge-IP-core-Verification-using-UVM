class apb_trans extends uvm_sequence_item;	
	
	`uvm_object_utils(apb_trans)
	
	bit Penable;
	bit Pwrite;
	bit [31:0]Pwdata;
	bit [31:0]Prdata;
	bit [31:0]Paddr;
	bit [3:0]Pselx;

	function new(string name="apb_trans");
		super.new(name);
	endfunction
	
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("Penable",this.Penable,1,UVM_BIN);
		printer.print_field("Pwrite",this.Pwrite,1,UVM_BIN);
		printer.print_field("Pselx",this.Pselx,4,UVM_BIN);
		printer.print_field("Paddr",this.Paddr,32,UVM_HEX);
		printer.print_field("Pwdata",this.Pwdata,32,UVM_HEX);
		printer.print_field("Prdata",this.Prdata,32,UVM_HEX);
	endfunction

endclass
