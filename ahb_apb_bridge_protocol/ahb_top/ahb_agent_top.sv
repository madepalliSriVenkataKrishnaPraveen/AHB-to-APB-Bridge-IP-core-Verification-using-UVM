class ahb_agent_top extends uvm_env;

	`uvm_component_utils(ahb_agent_top)
	
	ahb_agent ahb_agnth;

	env_config m_cfg;
	
	function new(string name="ahb_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
			`uvm_fatal(get_type_name(),"not getting the env_config")
		uvm_config_db#(ahb_agent_config)::set(this,"ahb_agnth*","ahb_agent_config",m_cfg.ahb_config);
		ahb_agnth=ahb_agent::type_id::create("ahb_agnth",this);
	endfunction

endclass

