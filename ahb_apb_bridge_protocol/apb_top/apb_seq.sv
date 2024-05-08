class apb_base_seq extends uvm_sequence#(apb_trans);

	`uvm_object_utils(apb_base_seq)
	
	function new(string name="apb_base_seq");
		super.new(name);
	endfunction
	
endclass