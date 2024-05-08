class environment extends uvm_env;

	`uvm_component_utils(environment)

	ahb_agent_top ahb_toph;
	apb_agent_top apb_toph;
	scoreboard sb;
	env_config m_cfg;
	virtual_sequencer v_seqrh;

	function new(string name="environment",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))	
			`uvm_fatal(get_type_name(),"getting on env_config is failed")
		if(m_cfg.has_ahb_agent)
			ahb_toph=ahb_agent_top::type_id::create("ahb_toph",this);
		if(m_cfg.has_apb_agent)
			apb_toph=apb_agent_top::type_id::create("apb_toph",this);
		if(m_cfg.has_scoreboard)
			sb=scoreboard::type_id::create("sb",this);
		if(m_cfg.has_virtual_sequencer)
			v_seqrh=virtual_sequencer::type_id::create("v_seqrh",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(m_cfg.has_virtual_sequencer)
		begin
			if(m_cfg.has_ahb_agent)
				v_seqrh.ahb_seqrh=ahb_toph.ahb_agnth.ahb_seqrh;
			if(m_cfg.has_apb_agent)
				v_seqrh.apb_seqrh=apb_toph.apb_agnth.apb_seqrh;
		end
		if(m_cfg.has_scoreboard)
		begin
			ahb_toph.ahb_agnth.ahb_monh.mon_port.connect(sb.ahb_porth.analysis_export);
			apb_toph.apb_agnth.apb_monh.mon_port.connect(sb.apb_porth.analysis_export);
		end
	endfunction
endclass
