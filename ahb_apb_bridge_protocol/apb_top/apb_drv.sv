class apb_drv extends uvm_driver#(apb_trans);
	
	`uvm_component_utils(apb_drv)
	
	apb_agent_config m_cfg;
	
	virtual apb_if.APB_DRV_MP vif;
	
	function new(string name="apb_drv",uvm_component parent);
		super.new(name,parent);
	endfunction 
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",m_cfg))
			`uvm_fatal(get_type_name(),"getting interface failed")
	endfunction
	
	task run_phase(uvm_phase phase);
		forever
			drive_item();
	endtask
	
	task drive_item();
		while(vif.apb_drv_cb.Pselx===4'b0000)
			@(vif.apb_drv_cb);
		if(vif.apb_drv_cb.Pwrite==='0)
			vif.apb_drv_cb.Prdata<=$random;
		//repeat(2)
		@(vif.apb_drv_cb);
		//vif.apb_drv_cb.Prdata<='0;
		@(vif.apb_drv_cb);
	endtask
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=m_cfg.vif;
	endfunction

endclass
