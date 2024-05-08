class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);
	
	`uvm_component_utils(virtual_sequencer)

	ahb_seqr ahb_seqrh;
	apb_seqr apb_seqrh;

	function new(string name="virtual_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

endclass	
