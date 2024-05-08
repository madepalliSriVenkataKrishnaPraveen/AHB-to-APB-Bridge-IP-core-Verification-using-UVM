class vbase_seq extends uvm_sequence#(uvm_sequence_item);
	
	`uvm_object_utils(vbase_seq)

	ahb_seqr ahb_seqrh;
	apb_seqr apb_seqrh;

	virtual_sequencer v_seqrh;
	
	env_config m_cfg;
	
	ahb_single_wseq ahb_sw_vseq;
	ahb_single_rseq ahb_sr_vseq;
	ahb_us_wseq ahb_uw_vseq;
	ahb_us_rseq ahb_ur_vseq;
	
	ahb_inc4_wseq ahb_i4w_vseq;
	ahb_inc4_rseq ahb_i4r_vseq;
	ahb_inc8_wseq ahb_i8w_vseq;
	ahb_inc8_rseq ahb_18r_vseq;
	ahb_inc16_wseq ahb_i16w_vseq;
	ahb_inc16_rseq ahb_i16r_vseq;
	
	ahb_wrap4_wseq ahb_w4w_vseq;
	ahb_wrap4_rseq ahb_w4r_vseq;
	ahb_wrap8_wseq ahb_w8w_vseq;
	ahb_wrap8_rseq ahb_w8r_vseq;
	ahb_wrap16_wseq ahb_w16w_vseq;
	ahb_wrap16_rseq ahb_w16r_vseq;
	

	
	function new(string name="vbase_seq");
		super.new(name);
	endfunction

	task body();
		if(!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",m_cfg))
			`uvm_fatal(get_type_name(),"config getting failed")
		assert($cast(v_seqrh,m_sequencer))
		else
			`uvm_error(get_type_name(),"casting of m_sequencer is failed")
		ahb_seqrh=v_seqrh.ahb_seqrh;
		apb_seqrh=v_seqrh.apb_seqrh;
	endtask

endclass



//-----------------singe write vseq-------------------
class single_write_vseq extends vbase_seq;

	`uvm_object_utils(single_write_vseq)
	
	function new(string name="single_write_vseq");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		ahb_sw_vseq=ahb_single_wseq::type_id::create("ahb_sw_vseq");
		fork
			if(m_cfg.has_ahb_agent)
				ahb_sw_vseq.start(ahb_seqrh);
		join
	endtask
endclass

//-----------------unspecified length read vseq-------------------
class unspecified_read_vseq extends vbase_seq;

	`uvm_object_utils(unspecified_read_vseq)
	
	function new(string name="unspecified_read_vseq");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		ahb_ur_vseq=ahb_us_rseq::type_id::create("ahb_ur_vseq");
		fork
			if(m_cfg.has_ahb_agent)
				ahb_ur_vseq.start(ahb_seqrh);
		join
	endtask
endclass


//-----------------Increment-4 write vseq-------------------
class inc4_write_vseq extends vbase_seq;

	`uvm_object_utils(inc4_write_vseq)
	
	function new(string name="inc4_write_vseq");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		ahb_i4w_vseq=ahb_inc4_wseq::type_id::create("ahb_i4w_vseq");
		fork
			if(m_cfg.has_ahb_agent)
				ahb_i4w_vseq.start(ahb_seqrh);
		join
	endtask
endclass

//-----------------Increment-8 write vseq-------------------
class inc8_write_vseq extends vbase_seq;

	`uvm_object_utils(inc8_write_vseq)
	
	function new(string name="inc8_write_vseq");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		ahb_i8w_vseq=ahb_inc8_wseq::type_id::create("ahb_i8w_vseq");
		fork
			if(m_cfg.has_ahb_agent)
				ahb_i8w_vseq.start(ahb_seqrh);
		join
	endtask
endclass

//-----------------Increment-16 write vseq-------------------
class inc16_write_vseq extends vbase_seq;

	`uvm_object_utils(inc16_write_vseq)
	
	function new(string name="inc16_write_vseq");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		ahb_i16w_vseq=ahb_inc16_wseq::type_id::create("ahb_i16w_vseq");
		fork
			if(m_cfg.has_ahb_agent)
				ahb_i16w_vseq.start(ahb_seqrh);
		join
	endtask
endclass

//-----------------Wrap-4 write vseq-------------------
class wrap4_write_vseq extends vbase_seq;

	`uvm_object_utils(wrap4_write_vseq)
	
	function new(string name="wrap4_write_vseq");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		ahb_w4w_vseq=ahb_wrap4_wseq::type_id::create("ahb_w4w_vseq");
		fork
			if(m_cfg.has_ahb_agent)
				ahb_w4w_vseq.start(ahb_seqrh);
		join
	endtask
endclass

//-----------------Wrap-8 write vseq-------------------
class wrap8_write_vseq extends vbase_seq;

	`uvm_object_utils(wrap8_write_vseq)
	
	function new(string name="wrap8_write_vseq");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		ahb_w8w_vseq=ahb_wrap8_wseq::type_id::create("ahb_w8w_vseq");
		fork
			if(m_cfg.has_ahb_agent)
				ahb_w8w_vseq.start(ahb_seqrh);
		join
	endtask
endclass

//-----------------Wrap-16 write vseq-------------------
class wrap16_write_vseq extends vbase_seq;

	`uvm_object_utils(wrap16_write_vseq)
	
	function new(string name="wrap16_write_vseq");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		ahb_w16w_vseq=ahb_wrap16_wseq::type_id::create("ahb_w16w_vseq");
		fork
			if(m_cfg.has_ahb_agent)
				ahb_w16w_vseq.start(ahb_seqrh);
		join
	endtask
endclass
