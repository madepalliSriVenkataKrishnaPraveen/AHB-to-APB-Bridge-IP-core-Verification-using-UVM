class apb_mon extends uvm_monitor;

	`uvm_component_utils(apb_mon)

	uvm_analysis_port#(apb_trans) mon_port;
	
	apb_agent_config m_cfg;
	
	virtual apb_if.APB_MON_MP vif;
	
	function new(string name="apb_mon",uvm_component parent);
		super.new(name,parent);
	endfunction 
	
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",m_cfg))
			`uvm_fatal(get_type_name(),"interface not getting ")
		mon_port=new("mon_port",this);
	endfunction
	
	task run_phase(uvm_phase phase);
		forever
			collect_data();
	endtask
	
	task collect_data();
		apb_trans xtn;
		xtn=apb_trans::type_id::create("xtn");
		while(vif.apb_mon_cb.Penable===1'b0)
			@(vif.apb_mon_cb);
		xtn.Pselx=vif.apb_mon_cb.Pselx;
		xtn.Pwrite=vif.apb_mon_cb.Pwrite;
		xtn.Penable=vif.apb_mon_cb.Penable;
		xtn.Paddr=vif.apb_mon_cb.Paddr;
		if(vif.apb_mon_cb.Pwrite)
			xtn.Pwdata=vif.apb_mon_cb.Pwdata;
		else
			xtn.Prdata=vif.apb_mon_cb.Prdata;	
		mon_port.write(xtn);
		`uvm_info("APB_MONITOR",$sformatf(xtn.sprint),UVM_LOW)
		@(vif.apb_mon_cb);
	endtask

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=m_cfg.vif;
	endfunction
endclass
