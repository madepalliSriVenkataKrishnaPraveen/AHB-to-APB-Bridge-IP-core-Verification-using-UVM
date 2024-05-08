class ahb_agent_config extends uvm_object;
	
	`uvm_object_utils(ahb_agent_config)
	
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	
	virtual ahb_if vif;
	
	function new(string name="ahb_agent_config");
		super.new(name);
	endfunction
	
endclass