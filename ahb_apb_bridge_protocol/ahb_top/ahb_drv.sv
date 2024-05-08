class ahb_drv extends uvm_driver#(ahb_trans);

	`uvm_component_utils(ahb_drv)
	
	ahb_agent_config m_cfg;
	
	virtual ahb_if.AHB_DRV_MP vif;
	
	function new(string name="ahb_drv",uvm_component parent);
		super.new(name,parent);
	endfunction 
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(ahb_agent_config)::get(this,"","ahb_agent_config",m_cfg))
			`uvm_fatal(get_type_name(),"if not getting ")
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=m_cfg.vif;
	endfunction
	
	task run_phase(uvm_phase phase);
		vif.ahb_drv_cb.Hresetn<=0;
		repeat(3) @(vif.ahb_drv_cb);
		vif.ahb_drv_cb.Hresetn<=1;
		forever
		begin
			seq_item_port.get_next_item(req);
			drive_item(req);
			seq_item_port.item_done();
		end
	endtask
	
	task drive_item(ahb_trans xtn);
		//`uvm_info("AHB_DRIVER",$sformatf(xtn.sprint()),UVM_LOW)
		vif.ahb_drv_cb.Haddr<=xtn.Haddr;
		vif.ahb_drv_cb.Hwrite<=xtn.Hwrite;
		vif.ahb_drv_cb.Htrans<=xtn.Htrans;
		vif.ahb_drv_cb.Hsize<=xtn.Hsize;
		vif.ahb_drv_cb.Hreadyin<=1'b1;
		@(vif.ahb_drv_cb);
		while(vif.ahb_drv_cb.Hreadyout===0)
			@(vif.ahb_drv_cb);
		vif.ahb_drv_cb.Hwdata<=xtn.Hwdata;
	endtask	
endclass
