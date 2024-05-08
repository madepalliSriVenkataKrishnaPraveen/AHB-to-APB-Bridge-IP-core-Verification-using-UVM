//--------------------Base seq----------------
class ahb_base_seq extends uvm_sequence#(ahb_trans);

	`uvm_object_utils(ahb_base_seq)
	
	int hsize;
	int haddr;
	int length;
	int hwrite;

	function new(string name="ahb_base_seq");
		super.new(name);
	endfunction
	
endclass
//---------------single write sequence--------------
class ahb_single_wseq extends ahb_base_seq;
	
	`uvm_object_utils(ahb_single_wseq)

	function new(string name="ahb_single_wseq");
		super.new(name);
	endfunction

	task body();
	//	repeat(1)
		begin
			req=ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hwrite==1'b1;Hburst==3'b0;});
			finish_item(req);
		end
	endtask
endclass
//---------------single read sequence--------------
class ahb_single_rseq extends ahb_base_seq;
	
	`uvm_object_utils(ahb_single_rseq)

	function new(string name="ahb_single_rseq");
		super.new(name);
	endfunction

	task body();
		repeat(1)
		begin
			req=ahb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hwrite==1'b0;Hburst==3'b0;});
			finish_item(req);
		end
	endtask
endclass


//--------------------unspecified length write seq---------------
class ahb_us_wseq extends ahb_base_seq;

	`uvm_object_utils(ahb_us_wseq)

	function new(string name="ahb_us_wseq");
		super.new(name);
	endfunction
	
	task body();
		repeat(1)
		begin
			/*bit[2:0] hsize;
			bit hwrite;
			bit[31:0] haddr;
*/
			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hwrite==1'b1;Hburst==3'b001;});
			finish_item(req);
			//Seq
			this.hsize=req.Hsize;
			this.hwrite=req.Hwrite;
			this.haddr=req.Haddr;
			for(int i=0;i<req.length;i++)
			begin
				start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b001;Hwrite==hwrite;Hsize==hsize;Haddr==haddr+(3'b001<<Hsize);});
				finish_item(req);
				haddr=req.Haddr;
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hwrite==hwrite;Hburst==3'b001;});
			finish_item(req);
		end
	endtask
endclass

//--------------------unspecified length read seq----------------
class ahb_us_rseq extends ahb_base_seq;

	`uvm_object_utils(ahb_us_rseq)

	function new(string name="ahb_us_rseq");
		super.new(name);
	endfunction
	
	task body();
/*			bit[2:0] hsize;
			bit hwrite;
			bit[31:0] haddr;
*/			repeat(1)
			begin
			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hwrite==1'b0;Hburst==3'b001;});
			finish_item(req);
			//Seq
			for(int i=0;i<req.length;i++)
			begin
			hsize=req.Hsize;
			hwrite=req.Hwrite;
			haddr=req.Haddr;
				start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b001;Hwrite==hwrite;Hsize==hsize;Haddr==haddr+(3'b001<<Hsize);});
				finish_item(req);	
				haddr=req.Haddr;
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hburst==3'b001;Hwrite==hwrite;});
			finish_item(req);
		end
	endtask
endclass

//-----------------------increment-4 write seq------------------
class ahb_inc4_wseq extends ahb_base_seq;
		
	`uvm_object_utils(ahb_inc4_wseq)

	function new(string name="ahb_inc4_wseq");
		super.new(name);
	endfunction
	
	task body();
/*		bit[2:0] hsize;
		bit hwrite;
		bit[31:0] haddr;
*/		repeat(1)
		begin

			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hwrite==1'b1;Hburst==3'b011;});
			finish_item(req);
			//Seq
			hsize=req.Hsize;
			hwrite=req.Hwrite;
			haddr=req.Haddr;
			for(int i=0;i<3;i++)
			begin
				start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b011;Hwrite==hwrite;Hsize==hsize;Haddr==haddr+(3'b001<<hsize);});
				finish_item(req);
				haddr=req.Haddr;
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hburst==3'b011;Hwrite==hwrite;});
			finish_item(req);
		end
	endtask
endclass

//-----------------------increment-4 read seq------------------
class ahb_inc4_rseq extends ahb_base_seq;
		
	`uvm_object_utils(ahb_inc4_rseq)

	function new(string name="ahb_inc4_rseq");
		super.new(name);
	endfunction
	
	task body();
		repeat(1)
		begin
	/*	bit[2:0] hsize;
			bit hwrite;
			bit[31:0] haddr;
*/
			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hwrite==1'b0;Hburst==3'b011;});
			finish_item(req);
			//Seq
			hsize=req.Hsize;
			hwrite=req.Hwrite;
			haddr=req.Haddr;
			for(int i=0;i<3;i++)
			begin
				start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b011;Hwrite==hwrite;Hsize==hsize;Haddr==haddr+(3'b001<<hsize);});
				finish_item(req);
				haddr=req.Haddr;
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hburst==3'b011;Hwrite==hwrite;});
			finish_item(req);
		end
	endtask
endclass

//--------------------Increment-8 write seq----------------
class ahb_inc8_wseq extends ahb_base_seq;
		
	`uvm_object_utils(ahb_inc8_wseq)

	function new(string name="ahb_inc8_wseq");
		super.new(name);
	endfunction
	
	task body();
	/*	bit[2:0] hsize;
		bit hwrite;
		bit[31:0] haddr;
		*/repeat(1)
		begin
			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hburst==3'b101;Hwrite==1'b1;});
			finish_item(req);
			
			//Seq
			hsize=req.Hsize;
			hwrite=req.Hwrite;
			haddr=req.Haddr;
			for(int i=0;i<7;i++)
			begin
				start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b101;Hwrite==hwrite;Hsize==hsize;Haddr==haddr+(3'b001<<hsize);});
				finish_item(req);
				haddr=req.Haddr;
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hburst==3'b101;Hwrite==hwrite;});
			finish_item(req);
		end
	endtask
endclass

//--------------------Increment-8 read seq----------------
class ahb_inc8_rseq extends ahb_base_seq;
		
	`uvm_object_utils(ahb_inc8_rseq)

	function new(string name="ahb_inc8_rseq");
		super.new(name);
	endfunction
	
	task body();
		repeat(1)
		begin
		/*bit[2:0] hsize;
			bit hwrite;
			bit[31:0] haddr;
*/
			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hburst==3'b101;Hwrite==1'b0;});
			finish_item(req);
			//Seq
			hsize=req.Hsize;
			hwrite=req.Hwrite;
			haddr=req.Haddr;
			for(int i=0;i<7;i++)
			begin
				start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b101;Hwrite==hwrite;Hsize==hsize;Haddr==haddr+(3'b001<<hsize);});
				finish_item(req);
				haddr=req.Haddr;
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hburst==3'b101;Hwrite==hwrite;});
			finish_item(req);
		end
	endtask
endclass

//--------------------Increment-16 write seq --------------------
class ahb_inc16_wseq extends ahb_base_seq;
		
	`uvm_object_utils(ahb_inc16_wseq)

	function new(string name="ahb_inc16_wseq");
		super.new(name);
	endfunction
	
	task body();
	/*	bit[2:0] hsize;
		bit hwrite;
		bit[31:0] haddr;
		*/repeat(1)
		begin

			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hburst==3'b111;Hwrite==1'b1;});
			finish_item(req);
			//Seq
			hsize=req.Hsize;
			hwrite=req.Hwrite;
			haddr=req.Haddr;
			for(int i=0;i<15;i++)
			begin
				start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b111;Hwrite==hwrite;Hsize==hsize;Haddr==haddr+(3'b001<<hsize);});
				finish_item(req);
				haddr=req.Haddr;
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hburst==3'b111;Hwrite==hwrite;});
			finish_item(req);
		end
	endtask
endclass

//--------------------Increment-16 read seq --------------------
class ahb_inc16_rseq extends ahb_base_seq;
	
	`uvm_object_utils(ahb_inc16_rseq)

	function new(string name="ahb_inc16_rseq");
		super.new(name);
	endfunction
	
	task body();
		/*bit[2:0] hsize;
		bit hwrite;
		*/bit[31:0] haddr;	
		repeat(1)
		begin
			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hburst==3'b111;Hwrite==1'b0;});
			finish_item(req);
			//Seq
			hsize=req.Hsize;
			hwrite=req.Hwrite;
			haddr=req.Haddr;
			for(int i=0;i<15;i++)
			begin
				start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b111;Hwrite==hwrite;Hsize==hsize;Haddr==haddr+(3'b001<<hsize);});
				finish_item(req);
				haddr=req.Haddr;
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hburst==3'b111;Hwrite==hwrite;});
			finish_item(req);
		end
	endtask
endclass

//-------------------Wrap-4 write seq------------------
class ahb_wrap4_wseq extends ahb_base_seq;

	`uvm_object_utils(ahb_wrap4_wseq)
	
	function new(string name="ahb_wrap4_wseq");
		super.new(name);
	endfunction
	
	task body();
			/*bit[2:0] hsize;
			bit hwrite;
			bit[31:0] haddr;
			*/repeat(1)
			begin
			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hburst==3'b010;Hwrite==1'b1;});
			finish_item(req);
			hwrite=req.Hwrite;
			hsize=req.Hsize;
			haddr=req.Haddr;

			//seq
			for(int i=0;i<3;i++)
			begin
			start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b010;Hwrite==hwrite;Hsize==hsize;
																					Hsize==0 ->{Haddr=={haddr[31:2],haddr[1:0]+1'b1}};
																					Hsize==1 ->{Haddr=={haddr[31:3],haddr[2:1]+1'b1,haddr[0]}};
																					Hsize==2 ->{Haddr=={haddr[31:4],haddr[3:2]+1'b1,haddr[1:0]}};});
				finish_item(req);
				haddr=req.Haddr;
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hburst==3'b010;Hwrite==hwrite;});
			finish_item(req);
		end
	endtask
endclass

//-------------------Wrap-4 read seq------------------
class ahb_wrap4_rseq extends ahb_base_seq;

	`uvm_object_utils(ahb_wrap4_rseq)
	
	function new(string name="ahb_wrap4_rseq");
		super.new(name);
	endfunction
	
	task body();
			/*bit[2:0] hsize;
			bit hwrite;
			bit[31:0] haddr;
			*/repeat(1)
			begin

			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hburst==3'b010;Hwrite==1'b0;});
			finish_item(req);
			hwrite=req.Hwrite;
			hsize=req.Hsize;
			haddr=req.Haddr;
			//seq
			for(int i=0;i<3;i++)
			begin
			start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b010;Hwrite==hwrite;Hsize==hsize;
																					Hsize==0 ->{Haddr=={haddr[31:2],haddr[1:0]+1'b1}};
																					Hsize==1 ->{Haddr=={haddr[31:3],haddr[2:1]+1'b1,haddr[0]}};
																					Hsize==2 ->{Haddr=={haddr[31:4],haddr[3:2]+1'b1,haddr[1:0]}};});
				finish_item(req);
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hburst==3'b010;Hwrite==hwrite;});
			finish_item(req);
		end
	endtask
endclass

//-------------------Wrap-8 write seq------------------
class ahb_wrap8_wseq extends ahb_base_seq;

	`uvm_object_utils(ahb_wrap8_wseq)
	
	function new(string name="ahb_wrap8_wseq");
		super.new(name);
	endfunction
	
	task body();
		/*bit[2:0] hsize;
		bit hwrite;
		bit[31:0] haddr;
		*/repeat(1)
		begin

			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hburst==3'b100;Hwrite==1'b1;});
			finish_item(req);
			//seq
			hwrite=req.Hwrite;
			hsize=req.Hsize;
			haddr=req.Haddr;

			for(int i=0;i<7;i++)
			begin
						
				start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b100;Hwrite==hwrite;Hsize==hsize;
																					Hsize==0 ->{Haddr=={haddr[31:3],haddr[2:0]+1'b1}};
																					Hsize==1 ->{Haddr=={haddr[31:4],haddr[3:1]+1'b1,haddr[0]}};
																					Hsize==2 ->{Haddr=={haddr[31:5],haddr[4:2]+1'b1,haddr[1:0]}};});
				finish_item(req);
				haddr=req.Haddr;
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hburst==3'b100;Hwrite==hwrite;});
			finish_item(req);
		end
	endtask
endclass

//-------------------Wrap-8 read seq------------------
class ahb_wrap8_rseq extends ahb_base_seq;

	`uvm_object_utils(ahb_wrap8_rseq)
	
	function new(string name="ahb_wrap8_rseq");
		super.new(name);
	endfunction
	
	task body();
		repeat(1)
		begin
			/*bit[2:0] hsize;
			bit hwrite;
			bit[31:0] haddr;
*/
			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hburst==3'b100;Hwrite==1'b0;});
			finish_item(req);
			//seq
			hwrite=req.Hwrite;
			hsize=req.Hsize;
			haddr=req.Haddr;
			for(int i=0;i<7;i++)
			begin
			
				start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b100;Hwrite==hwrite;Hsize==hsize;
																					Hsize==0 ->{Haddr=={haddr[31:3],haddr[2:0]+1'b1}};
																					Hsize==1 ->{Haddr=={haddr[31:4],haddr[3:1]+1'b1,haddr[0]}};
																					Hsize==2 ->{Haddr=={haddr[31:5],haddr[4:2]+1'b1,haddr[1:0]}};});
				finish_item(req);
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hburst==3'b100;Hwrite==hwrite;});
			finish_item(req);
		end
	endtask
endclass

//-------------------Wrap-16 write seq------------------
class ahb_wrap16_wseq extends ahb_base_seq;

	`uvm_object_utils(ahb_wrap16_wseq)
	
	function new(string name="ahb_wrap16_wseq");
		super.new(name);
	endfunction
	
	task body();
		repeat(1)
		begin
	/*		bit[2:0] hsize;
			bit hwrite;
			bit[31:0] haddr;
*/
			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hburst==3'b110;Hwrite==1'b1;});
			finish_item(req);
			//seq
			hwrite=req.Hwrite;
			hsize=req.Hsize;
			haddr=req.Haddr;
			for(int i=0;i<15;i++)
			begin
				start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b110;Hwrite==hwrite;Hsize==hsize;
																					Hsize==0 ->{Haddr=={haddr[31:4],haddr[3:0]+1'b1}};
																					Hsize==1 ->{Haddr=={haddr[31:5],haddr[4:1]+1'b1,haddr[0]}};
																					Hsize==2 ->{Haddr=={haddr[31:6],haddr[5:2]+1'b1,haddr[1:0]}};});
				finish_item(req);
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hburst==3'b110;/*Hwrite==hwrite;*/});
			finish_item(req);
		end
	endtask
endclass

//-------------------Wrap-16 read seq------------------
class ahb_wrap16_rseq extends ahb_base_seq;

	`uvm_object_utils(ahb_wrap16_rseq)
	
	function new(string name="ahb_wrap16_rseq");
		super.new(name);
	endfunction
	
	task body();
		repeat(1)
		begin
	/*		bit[2:0] hsize;
			bit hwrite;
			bit[31:0] haddr;
*/
			req=ahb_trans::type_id::create("req");
			//NS
			start_item(req);
			assert(req.randomize() with {Htrans==2'b10;Hburst==3'b110;Hwrite==1'b0;});
			finish_item(req);
			//seq
			hwrite=req.Hwrite;
			hsize=req.Hsize;
			haddr=req.Haddr;
			for(int i=0;i<15;i++)
			begin
				start_item(req);
				assert(req.randomize() with {Htrans==2'b11;Hburst==3'b110;Hwrite==hwrite;Hsize==hsize;
																					Hsize==0 ->{Haddr=={haddr[31:4],haddr[3:0]+1'b1}};
																					Hsize==1 ->{Haddr=={haddr[31:5],haddr[4:1]+1'b1,haddr[0]}};
																					Hsize==2 ->{Haddr=={haddr[31:6],haddr[5:2]+1'b1,haddr[1:0]}};});
				finish_item(req);
			end
			//IDLE
			start_item(req);
			assert(req.randomize() with {Htrans==2'b00;Hburst==3'b110;Hwrite==hwrite;});
			finish_item(req);
		end
	endtask
endclass
