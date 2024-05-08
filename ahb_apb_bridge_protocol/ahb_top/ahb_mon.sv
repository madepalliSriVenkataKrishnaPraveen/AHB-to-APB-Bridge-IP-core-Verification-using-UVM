class ahb_mon extends uvm_monitor;

	`uvm_component_utils(ahb_mon)
	
	uvm_analysis_port#(ahb_trans) mon_port;

	ahb_agent_config m_cfg;
	
	virtual ahb_if.AHB_MON_MP vif;
	
	function new(string name="ahb_mon",uvm_component parent);
		super.new(name,parent);
	endfunction 
	
	function void build_phase(uvm_phase phase);	
		super.build_phase(phase);
		if(!uvm_config_db#(ahb_agent_config)::get(this,"","ahb_agent_config",m_cfg))
			`uvm_fatal(get_type_name(),"interface not getting ")
		mon_port=new("mon_port",this);
	endfunction
	
	task run_phase(uvm_phase phase);
		while(vif.ahb_mon_cb.Hreadyout===0)
			@(vif.ahb_mon_cb);
		forever
			collect_data();
	endtask
		
	task collect_data();
		ahb_trans xtn;
		xtn=ahb_trans::type_id::create("xtn");
		while(vif.ahb_mon_cb.Htrans==2'b00 || vif.ahb_mon_cb.Htrans==2'b01)
			@(vif.ahb_mon_cb);
		xtn.Haddr=vif.ahb_mon_cb.Haddr;
		xtn.Hready=vif.ahb_mon_cb.Hreadyout;
		xtn.Hwrite=vif.ahb_mon_cb.Hwrite;
		xtn.Htrans=vif.ahb_mon_cb.Htrans;
		xtn.Hsize=vif.ahb_mon_cb.Hsize;
		@(vif.ahb_mon_cb);
		while(vif.ahb_mon_cb.Hreadyout===0)
			@(vif.ahb_mon_cb);
		if(vif.ahb_mon_cb.Hwrite==='1)
			xtn.Hwdata=vif.ahb_mon_cb.Hwdata;
		else
			xtn.Hrdata=vif.ahb_mon_cb.Hrdata;
		mon_port.write(xtn);
		`uvm_info("AHB_MONITOR",$sformatf(xtn.sprint()),UVM_LOW)
	endtask
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=m_cfg.vif;
	endfunction	
endclass
