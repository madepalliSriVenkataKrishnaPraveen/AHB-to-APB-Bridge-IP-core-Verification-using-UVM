class env_config extends uvm_object;

	`uvm_object_utils(env_config)

	function new(string name="env_config");
		super.new(name);
	endfunction

	bit has_scoreboard=1;
	
	bit has_ahb_agent=1;
	bit has_apb_agent=1;

	bit has_virtual_sequencer=1;

	apb_agent_config apb_config;
	ahb_agent_config ahb_config;

endclass
