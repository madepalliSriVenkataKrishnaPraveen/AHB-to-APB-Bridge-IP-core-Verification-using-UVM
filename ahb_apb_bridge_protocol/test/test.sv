class base_test extends uvm_test;

	`uvm_component_utils(base_test)

	environment envh;
	env_config m_cfg;
	ahb_agent_config ahb_cfg;
	apb_agent_config apb_cfg;

	bit has_ahb_agent=1;
	bit has_apb_agent=1;
	
	function new(string name="base_test",uvm_component parent);
		super.new(name,parent);	
	endfunction

	function void test_config();
		if(has_ahb_agent)
		begin
			ahb_cfg=ahb_agent_config::type_id::create("ahb_cfg");
			if(!uvm_config_db#(virtual ahb_if)::get(this,"","ahb_if",ahb_cfg.vif))
				`uvm_fatal(get_type_name(),"interface not getting")
			ahb_cfg.is_active=UVM_ACTIVE;
			m_cfg.ahb_config=ahb_cfg;
		end
		if(has_apb_agent)
		begin
			apb_cfg=apb_agent_config::type_id::create("apb_cfg");
			if(!uvm_config_db#(virtual apb_if)::get(this,"","apb_if",apb_cfg.vif))
				`uvm_fatal(get_type_name(),"interface not getting")
			apb_cfg.is_active=UVM_ACTIVE;
			m_cfg.apb_config=apb_cfg;
		end
		m_cfg.has_ahb_agent=has_ahb_agent;
		m_cfg.has_apb_agent=has_apb_agent;
	endfunction			
		
	function void build_phase(uvm_phase phase);
		m_cfg=env_config::type_id::create("m_cfg");
		test_config();
		uvm_config_db#(env_config)::set(this,"*","env_config",m_cfg);
		super.build_phase(phase);
		envh=environment::type_id::create("envh",this);
	endfunction
	
	function void end_of_elaboration_phase(uvm_phase phase);	
		uvm_top.print_topology;
	endfunction

endclass

// class seq_lib_test extends base_test;
	
// 	`uvm_component_utils(seq_lib_test)
	
// 	function new(string name="seq_lib_test", uvm_component parent);
// 		super.new(name,parent);
// 	endfunction
	
// 	function void build_phase(uvm_phase phase);
// 		super.build_phase(phase);
// 	endfunction
	
// 	task run_phase(uvm_phase phase);
// 		//super.run_phase(phase);
// 		ahb_vseq_lib vseq_libh;
		
// 		vseq_libh=ahb_vseq_lib::type_id::create("vseq_libh");
// 		phase.raise_objection(this);
// 		assert(vseq_libh.randomize());
// 		vseq_libh.start(envh.v_seqrh);
// 		#200;
// 		phase.drop_objection(this);
// 	endtask
// endclass
		
//--------------------single write test------------------
class single_wr_test extends base_test;

	`uvm_component_utils(single_wr_test)
	
	single_write_vseq m_seqs;
	
	function new(string name="single_wr_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
		//super.run_phase(phase);
		phase.raise_objection(this);
		m_seqs=single_write_vseq::type_id::create("m_seqs");
		m_seqs.start(envh.v_seqrh);
		#61;
		phase.drop_objection(this);
	endtask
endclass

//--------------------unspecified read test------------------
class unspecified_rd_test extends base_test;

	`uvm_component_utils(unspecified_rd_test)
	
	unspecified_read_vseq m_seqs;
	
	function new(string name="unspecified_rd_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
		//super.run_phase(phase);
		phase.raise_objection(this);
		m_seqs=unspecified_read_vseq::type_id::create("m_seqs");
		m_seqs.start(envh.v_seqrh);
		#20;
		phase.drop_objection(this);
	endtask
endclass

//--------------------Increment-4 write test------------------
class incr4_wr_test extends base_test;

	`uvm_component_utils(incr4_wr_test)
	
	inc4_write_vseq m_seqs;
	
	function new(string name="inc4_wr_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
		//super.run_phase(phase);
		phase.raise_objection(this);
		m_seqs=inc4_write_vseq::type_id::create("m_seqs");
		m_seqs.start(envh.v_seqrh);
		#45;
		phase.drop_objection(this);
	endtask
endclass

//--------------------Increment-8 write test------------------
class incr8_wr_test extends base_test;

	`uvm_component_utils(incr8_wr_test)
	
	inc8_write_vseq m_seqs;
	
	function new(string name="inc8_wr_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
		//super.run_phase(phase);
		phase.raise_objection(this);
		m_seqs=inc8_write_vseq::type_id::create("m_seqs");
		m_seqs.start(envh.v_seqrh);
		#45;
		phase.drop_objection(this);
	endtask
endclass

//--------------------Increment-16 write test------------------
class incr16_wr_test extends base_test;

	`uvm_component_utils(incr16_wr_test)
	
	inc16_write_vseq m_seqs;
	
	function new(string name="inc16_wr_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
		//super.run_phase(phase);
		phase.raise_objection(this);
		m_seqs=inc16_write_vseq::type_id::create("m_seqs");
		m_seqs.start(envh.v_seqrh);
		#45;
		phase.drop_objection(this);
	endtask
endclass

//--------------------Wrap-4 write test------------------
class wrap4_wr_test extends base_test;

	`uvm_component_utils(wrap4_wr_test)
	
	wrap4_write_vseq m_seqs;
	
	function new(string name="wrap4_wr_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
		//super.run_phase(phase);
		phase.raise_objection(this);
		m_seqs=wrap4_write_vseq::type_id::create("m_seqs");
		m_seqs.start(envh.v_seqrh);
		#20;
		phase.drop_objection(this);
	endtask
endclass

//--------------------Wrap-8 write test------------------
class wrap8_wr_test extends base_test;

	`uvm_component_utils(wrap8_wr_test)
	
	wrap8_write_vseq m_seqs;
	
	function new(string name="wrap8_wr_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
		//super.run_phase(phase);
		phase.raise_objection(this);
		m_seqs=wrap8_write_vseq::type_id::create("m_seqs");
		m_seqs.start(envh.v_seqrh);
		#20;
		phase.drop_objection(this);
	endtask
endclass

//--------------------Wrap-16 write test------------------
class wrap16_wr_test extends base_test;

	`uvm_component_utils(wrap16_wr_test)
	
	wrap16_write_vseq m_seqs;
	
	function new(string name="wrap16_wr_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
		//super.run_phase(phase);
		phase.raise_objection(this);
		m_seqs=wrap16_write_vseq::type_id::create("m_seqs");
		m_seqs.start(envh.v_seqrh);
		#20;
		phase.drop_objection(this);
	endtask
endclass
