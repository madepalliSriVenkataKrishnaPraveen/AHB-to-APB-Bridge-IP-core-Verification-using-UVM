class apb_agent extends uvm_agent;

	`uvm_component_utils(apb_agent)
	
	apb_drv apb_drvh;
	apb_mon apb_monh;
	apb_seqr apb_seqrh;
	apb_agent_config m_cfg;
	
	function new(string name="apb_agent",uvm_component parent);
		super.new(name,parent);
	endfunction 
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",m_cfg))
			`uvm_fatal(get_type_name(),"config getting failed")
		apb_monh=apb_mon::type_id::create("apb_monh",this);
		if(m_cfg.is_active==UVM_ACTIVE)
		begin
			apb_drvh=apb_drv::type_id::create("apb_drvh",this);
			apb_seqrh=apb_seqr::type_id::create("apb_seqrh",this);
		end
	endfunction
endclass
