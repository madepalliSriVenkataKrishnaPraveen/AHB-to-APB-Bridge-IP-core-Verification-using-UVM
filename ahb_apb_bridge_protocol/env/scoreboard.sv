class scoreboard extends uvm_scoreboard;

	`uvm_component_utils(scoreboard)

	uvm_tlm_analysis_fifo#(ahb_trans) ahb_porth;
	uvm_tlm_analysis_fifo#(apb_trans) apb_porth;

	ahb_trans ahb_data;
	apb_trans apb_data;

	ahb_trans ahb_cov;  // for coverage 
	apb_trans apb_cov;

	env_config m_cfg;



	////////////////////////////////////////////////////////////
	covergroup ahb_cg;
		option.per_instance = 1;
	  
		//RST: coverpoint ahb_cov.Hresetn;
		
		SIZE: coverpoint ahb_cov.Hsize {bins b2[] = {[0:2]} ;}//1,2,4 bytes of data
		
		TRANS: coverpoint ahb_cov.Htrans {bins trans[] = {[2:3]} ;}//NS and S
		
		//BURST: coverpoint ahb_cov.Hburst {bins burst[] = {[0:7]} ;}
		
		ADDR: coverpoint ahb_cov.Haddr {bins first_slave = {[32'h8000_0000:32'h8000_03ff]} ;
				 bins second_slave = {[32'h8400_0000:32'h8400_03ff]};
														   bins third_slave = {[32'h8800_0000:32'h8800_03ff]};
														   bins fourth_slave = {[32'h8C00_0000:32'h8C00_03ff]};}
	  
		DATA_IN: coverpoint ahb_cov.Hwdata {bins low = {[0:32'h0000_ffff]};
															   bins mid1 = {[32'h0001_ffff:32'hffff_ffff]};}
	  
					  DATA_OUT : coverpoint ahb_cov.Hrdata {bins low = {[0:32'h0000_ffff]};
																 bins mid1 = {[32'h0001_ffff:32'hffff_ffff]};}
		WRITE : coverpoint ahb_cov.Hwrite;
	  
		SIZEXWRITE: cross SIZE, WRITE;
	  
		//ADDRXDATA: cross ahb_cov.Haddr, ahb_cov.Hwdata;
	   endgroup: ahb_cg
	//////////////////////////////////////////////////////////////
	   covergroup apb_cg;
		option.per_instance = 1;
		
		ADDR : coverpoint apb_cov.Paddr {bins first_slave = {[32'h8000_0000:32'h8000_03ff]};
															bins second_slave = {[32'h8400_0000:32'h8400_03ff]};
															bins third_slave = {[32'h8800_0000:32'h8800_03ff]};
															bins fourth_slave = {[32'h8C00_0000:32'h8C00_03ff]};}
		  
		DATA_IN : coverpoint apb_cov.Pwdata {bins low = {[0:32'h0000_ffff]};
																bins mid1 = {[32'h0001_ffff:32'hffff_ffff]};}
	  
					  DATA_OUT : coverpoint apb_cov.Prdata {bins low = {[0:32'hffff_ffff]};}
	  
					  WRITE : coverpoint apb_cov.Pwrite;
	  
					  SEL : coverpoint apb_cov.Pselx {bins first_slave = {4'b0001};
														   bins second_slave = {4'b0010};
														   bins third_slave = {4'b0100};
														   bins fourth_slave = {4'b1000};}
	  
		WRITEXSEL: cross WRITE, SEL;
		//ADDRXWRITE: cross apv_cov_data.Paddr, apb_cov.Pwrite;
	   endgroup: apb_cg

	/////////////////////////////////////////////////////////////////////

	   function new(string name="scoreboard",uvm_component parent);
		super.new(name,parent);
		ahb_cg = new();
        apb_cg = new();
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ahb_porth=new("ahb_porth",this);
		apb_porth=new("apb_porth",this);
	endfunction

	task run_phase(uvm_phase phase);
		forever
		begin
			ahb_porth.get(ahb_data);
			apb_porth.get(apb_data);
			check_data();
			ahb_cov = ahb_data;
			apb_cov = apb_data;

			//sample the AHB CG
			ahb_cg.sample();
			 //sample the APB CG
			apb_cg.sample();
		
		end
	endtask

	task check_data();
	if(ahb_data.Hwrite)
		begin
			case(ahb_data.Hsize)
				0: begin
					if(ahb_data.Haddr[1:0]==2'b00)
					begin
						if(ahb_data.Hwdata[7:0]==apb_data.Pwdata[7:0])
							`uvm_info("Scoreboard","At Hsize==0, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==0, Compare failed %h:%h----%h:%h",ahb_data.Hwdata,ahb_data.Haddr,apb_data.Pwdata,apb_data.Paddr))
					end
					if(ahb_data.Haddr[1:0]==2'b01)
					begin
						if(ahb_data.Hwdata[15:8]==apb_data.Pwdata[7:0])
							`uvm_info("Scoreboard","At Hsize==0, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==0, Compare failed %h:%h----%h:%h",ahb_data.Hwdata,ahb_data.Haddr,apb_data.Pwdata,apb_data.Paddr))
					end
					if(ahb_data.Haddr[1:0]==2'b10)
					begin
						if(ahb_data.Hwdata[23:16]==apb_data.Pwdata[7:0])
							`uvm_info("Scoreboard","At Hsize==0, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==0, Compare failed%h:%h----%h:%h",ahb_data.Hwdata,ahb_data.Haddr,apb_data.Pwdata,apb_data.Paddr))
					end
					if(ahb_data.Haddr[1:0]==2'b11)
					begin
						if(ahb_data.Hwdata[31:24]==apb_data.Pwdata[7:0])
							`uvm_info("Scoreboard","At Hsize==0, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==0, Compare failed%h:%h----%h:%h",ahb_data.Hwdata,ahb_data.Haddr,apb_data.Pwdata,apb_data.Paddr))
					end
				    end	
				1:  begin
					if(ahb_data.Haddr[1:0]==2'b00)
					begin
						if(ahb_data.Hwdata[15:0]==apb_data.Pwdata[15:0])	
							`uvm_info("Scoreboard","At Hsize==1, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==1, Compare failed%h:%h----%h:%h",ahb_data.Hwdata,ahb_data.Haddr,apb_data.Pwdata,apb_data.Paddr))
					end
					if(ahb_data.Haddr[1:0]==2'b10)
					begin	
						if(ahb_data.Hwdata[31:16]==apb_data.Pwdata[15:0])
							`uvm_info("Scoreboard","At Hsize==1, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==1, Compare failed%h:%h----%h:%h",ahb_data.Hwdata,ahb_data.Haddr,apb_data.Pwdata,apb_data.Paddr))
					end
				    end
				2: begin	
					if(ahb_data.Haddr[1:0]==2'b00)
					begin
						if(ahb_data.Hwdata[31:0]==apb_data.Pwdata[31:0])
							`uvm_info("Scoreboard","At Hsize==2, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==2, Compare failed%h:%h----%h:%h",ahb_data.Hwdata,ahb_data.Haddr,apb_data.Pwdata,apb_data.Paddr))
					end
				    end
			default  : `uvm_fatal("Scoreboard","HSize is not a valid ")
			endcase
		end
		else
		begin
			case(ahb_data.Hsize)
				0: begin
					if(ahb_data.Haddr[1:0]==2'b00)
					begin
						if(apb_data.Prdata[7:0]==ahb_data.Hrdata[7:0])
							`uvm_info("Scoreboard","At Hsize==0, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==0, Compare failed %h:%h----%h:%h",ahb_data.Hrdata,ahb_data.Haddr,apb_data.Prdata,apb_data.Paddr))
					end
					if(ahb_data.Haddr[1:0]==2'b01)
					begin
						if(apb_data.Prdata[15:8]==ahb_data.Hrdata[7:0])
							`uvm_info("Scoreboard","At Hsize==0, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==0, Compare failed %h:%h----%h:%h",ahb_data.Hrdata,ahb_data.Haddr,apb_data.Prdata,apb_data.Paddr))
					end
					if(ahb_data.Haddr[1:0]==2'b10)
					begin
						if(apb_data.Prdata[23:16]==ahb_data.Hrdata[7:0])
							`uvm_info("Scoreboard","At Hsize==0, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==0, Compare failed%h:%h----%h:%h",ahb_data.Hrdata,ahb_data.Haddr,apb_data.Prdata,apb_data.Paddr))
					end
					if(ahb_data.Haddr[1:0]==2'b11)
					begin
						if(apb_data.Prdata[31:24]==ahb_data.Hrdata[7:0])
							`uvm_info("Scoreboard","At Hsize==0, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==0, Compare failed%h:%h----%h:%h",ahb_data.Hrdata,ahb_data.Haddr,apb_data.Prdata,apb_data.Paddr))
					end
				    end
				1:  begin
					if(ahb_data.Haddr[1:0]==2'b00)
					begin
						if(apb_data.Prdata[15:0]==ahb_data.Hrdata[15:0])	
							`uvm_info("Scoreboard","At Hsize==1, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==1, Compare failed%h:%h----%h:%h",ahb_data.Hrdata,ahb_data.Haddr,apb_data.Prdata,apb_data.Paddr))
					end
					if(ahb_data.Haddr[1:0]==2'b10)
					begin	
						if(apb_data.Prdata[31:16]==ahb_data.Hrdata[15:0])
							`uvm_info("Scoreboard","At Hsize==1, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==1, Compare failed%h:%h----%h:%h",ahb_data.Hrdata,ahb_data.Haddr,apb_data.Prdata,apb_data.Paddr))
					end
				    end
				2: begin
					if(ahb_data.Haddr[1:0]==2'b00)
					begin
						if(apb_data.Prdata[31:0]==ahb_data.Hrdata[31:0])
							`uvm_info("Scoreboard","At Hsize==2, Compared successfull",UVM_LOW)
						else 
							`uvm_error("Scoreboard",$sformatf("At Hsize==2, Compare failed%h:%h----%h:%h",ahb_data.Hrdata,ahb_data.Haddr,apb_data.Prdata,apb_data.Paddr))
					end
				    end
			default  : `uvm_fatal("Scoreboard","HSize is not a valid ")
			endcase
		end
	endtask
endclass
