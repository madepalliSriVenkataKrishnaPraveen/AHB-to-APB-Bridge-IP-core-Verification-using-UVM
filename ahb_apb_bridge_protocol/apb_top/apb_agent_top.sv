class apb_agent_top extends uvm_env;

	`uvm_component_utils(apb_agent_top)
	
	apb_agent apb_agnth;

	env_config m_cfg;
	
	function new(string name="apb_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
			`uvm_fatal(get_type_name(),"not getting the env_config")
		uvm_config_db #(apb_agent_config)::set(this,"apb_agnth*","apb_agent_config",m_cfg.apb_config);
		apb_agnth=apb_agent::type_id::create("apb_agnth",this);
	endfunction

endclass

