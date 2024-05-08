class ahb_agent extends uvm_agent;

	`uvm_component_utils(ahb_agent)
	
	ahb_drv ahb_drvh;
	ahb_mon ahb_monh;
	ahb_seqr ahb_seqrh;
	ahb_agent_config m_cfg;
	
	function new(string name="ahb_agent",uvm_component parent);
		super.new(name,parent);
	endfunction 
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(ahb_agent_config)::get(this,"","ahb_agent_config",m_cfg))
			`uvm_fatal(get_type_name(),"config getting failed")
		ahb_monh=ahb_mon::type_id::create("ahb_monh",this);
		if(m_cfg.is_active==UVM_ACTIVE)
		begin
			ahb_drvh=ahb_drv::type_id::create("ahb_drvh",this);
			ahb_seqrh=ahb_seqr::type_id::create("ahb_seqrh",this);
		end
	endfunction
	
	function void connect_phase(uvm_phase phase);	
		super.connect_phase(phase);
		if(m_cfg.is_active==UVM_ACTIVE)
			//$display("kjhk");
				ahb_drvh.seq_item_port.connect(ahb_seqrh.seq_item_export);
	endfunction
endclass
